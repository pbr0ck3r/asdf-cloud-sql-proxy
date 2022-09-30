<div align="center">

# asdf-cloud-sql-proxy [![Build](https://github.com/pbr0ck3r/asdf-cloud-sql-proxy/actions/workflows/build.yml/badge.svg)](https://github.com/pbr0ck3r/asdf-cloud-sql-proxy/actions/workflows/build.yml) [![Lint](https://github.com/pbr0ck3r/asdf-cloud-sql-proxy/actions/workflows/lint.yml/badge.svg)](https://github.com/pbr0ck3r/asdf-cloud-sql-proxy/actions/workflows/lint.yml)


[cloud-sql-proxy](https://github.com/GoogleCloudPlatform/cloud-sql-proxy) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add cloud-sql-proxy
# or
asdf plugin add cloud-sql-proxy https://github.com/pbr0ck3r/asdf-cloud-sql-proxy.git
```

cloud-sql-proxy:

```shell
# Show all installable versions
asdf list-all cloud-sql-proxy

# Install specific version
asdf install cloud-sql-proxy latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cloud-sql-proxy latest

# Now cloud-sql-proxy commands are available
cloud_sql_proxy --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pbr0ck3r/asdf-cloud-sql-proxy/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Phil Brocker](https://github.com/pbr0ck3r/)
