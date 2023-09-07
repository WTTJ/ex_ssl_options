defmodule ExSslOptions.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_ssl_options,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      elixirc_options: [
        warnings_as_errors: true
      ],
      dialyzer: [
        flags: [:unmatched_returns, :error_handling, :unknown, :extra_return],
        list_unused_filters: true,
        plt_add_apps: []
      ],
      preferred_cli_env: [
        quality: :test
      ],
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dev deps
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases() do
    [
      quality: [
        "format",
        "credo --strict",
        "deps.audit --format human",
        "test --cover",
        "dialyzer"
      ]
    ]
  end
end
