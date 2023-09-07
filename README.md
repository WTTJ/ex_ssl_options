# ExSslOptions

`ExSslOptions` provides default SSL configurations. 

They can be used with modules relying on ssl options like `:ssl` or `:hackney`.

Current version provides a configuration based on [EEF Security WG recommandations](https://github.com/erlef/security-wg/blob/master/docs/secure_coding_and_deployment_hardening/ssl.md).

## Installation

```elixir
def deps do
  [
    {:ex_ssl_options, "~> 0.1.0"}
  ]
end
```
