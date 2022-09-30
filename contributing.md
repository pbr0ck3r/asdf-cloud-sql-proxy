# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test cloud-sql-proxy https://github.com/pbr0ck3r/asdf-cloud-sql-proxy.git "cloud_sql_proxy --version"
```

Tests are automatically run in GitHub Actions on push and PR.
