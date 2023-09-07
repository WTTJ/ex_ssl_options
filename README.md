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

## Examples

### :httpc

Without `ExSslOptions`, we get a warning message:

```elixir
iex(1)> :httpc.request(:get, {"https://www.erlang.org", []}, [], [])

11:41:32.245 [warning] Description: 'Authenticity is not established by certificate path validation'
     Reason: 'Option {verify, verify_peer} and cacertfile/cacerts is missing'

{:ok, ...}
```

With `ExSslOptions`, no warning message since certificates verification is configured:
```elixir
iex(1)> :httpc.request(:get, {"https://www.erlang.org", []}, [ssl: ExSslOptions.eef_options()], [])
{:ok, ...}
```

### :hackney

```elixir
iex(1)> :hackney.request(:get, "https://www.erlang.org/", [], <<>>, [ssl_options: ExSslOptions.eef_options()])
```

### RabbitMQ

```elixir
Broadway.start_link(__MODULE__,
  ...
  producer: [
    module: {BroadwayRabbitMQ.Producer,
       ...,
       connection: [ssl_options: ExSslOptions.eef_options()], 
       ...
    }
  ]
  ...
)
```
