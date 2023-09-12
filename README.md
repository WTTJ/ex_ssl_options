# ExSslOptions

`ExSslOptions` provides default SSL configurations. 

They can be used with modules relying on ssl options like `:ssl` or `:hackney`.

Current version provides:
- a basic configuration: `ExSslOptions.basic_options()`
- a configuration based on [EEF Security WG recommandations](https://github.com/erlef/security-wg/blob/master/docs/secure_coding_and_deployment_hardening/ssl.md): `ExSslOptions.eef_options()`

## Installation

```elixir
def deps do
  [
    {:ex_ssl_options, "~> 0.1.0"}
  ]
end
```

## Examples

### :ssl

```elixir
iex -S mix
Erlang/OTP 26 [erts-14.0.2] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.15.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>  :ssl.connect('www.google.com', 443, [])
{:error, {:options, :incompatible, [verify: :verify_peer, cacerts: :undefined]}}
iex(2)> :ssl.connect('www.google.com', 443, ExSslOptions.eef_options)
{:ok,
 {:sslsocket, {:gen_tcp, #Port<0.4>, :tls_connection, :undefined},
  [#PID<0.193.0>, #PID<0.192.0>]}}
iex(3)> :ssl.connect('www.google.com', 443, ExSslOptions.basic_options)
{:ok,
 {:sslsocket, {:gen_tcp, #Port<0.5>, :tls_connection, :undefined},
  [#PID<0.198.0>, #PID<0.197.0>]}}
```

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
