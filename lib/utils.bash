#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for cloud-sql-proxy.
GH_REPO="https://github.com/GoogleCloudPlatform/cloud-sql-proxy"
TOOL_NAME="cloud-sql-proxy"
TOOL_TEST="cloud-sql-proxy --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if cloud-sql-proxy is not hosted on GitHub releases.
# if [ -n "${GITHUB_API_TOKEN:-}" ]; then
#   curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
# fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Adapt this. By default we simply list the tag names from GitHub releases.
  # Change this function if cloud-sql-proxy has other means of determining installable versions.
  list_github_tags
}

get_platform() {
  local os=$(uname)
  if [[ "${os}" == "Darwin" ]]; then
    echo "darwin"
  elif [[ "${os}" == "Linux" ]]; then
    echo "linux"
  else
    echo >&2 "unsupported os: ${os}" && exit 1
  fi
}

get_arch() {
  local os=$(uname)
  local arch=$(uname -m)
  if [[ "${os}" == "Darwin" && "${arch}" == "arm64" ]]; then
    echo "arm64"
  elif [[ "${os}" == "Linux" && "${arch}" == "aarch64" ]]; then
    echo "aarch_64"
  elif [[ ("${os}" == "Linux" || "${os}" == "Darwin") && "${arch}" == "x86_64" ]]; then
    echo "amd64"
  else
    echo "${arch}"
  fi
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  url="https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v${version}/cloud-sql-proxy.$(get_platform).$(get_arch)"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp "$ASDF_DOWNLOAD_PATH/$TOOL_NAME" "$install_path/$TOOL_NAME"
    chmod +x "$install_path/$TOOL_NAME"

    # TODO: Assert cloud-sql-proxy executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
