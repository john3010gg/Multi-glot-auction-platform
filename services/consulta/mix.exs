defmodule Consulta.MixProject do
  use Mix.Project

  def project do
    [
      app: :consulta,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Consulta.Application, []}
    ]
  end

  defp deps do
    [
      # HTTP + WebSocket (transporte de las subscriptions)
      {:phoenix, "~> 1.7"},
      {:phoenix_pubsub, "~> 2.1"},
      {:plug_cowboy, "~> 2.7"},
      {:jason, "~> 1.4"},
      # GraphQL
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},
      {:absinthe_phoenix, "~> 2.0"},
      # Cliente gRPC hacia el motor de subastas (stub generado en lib/generated/)
      {:grpc, "~> 1.0"},
      {:gun, "~> 2.4.0"},
      {:protobuf, "~> 0.17"}
      # TODO(equipo): cliente HTTP hacia usuarios, p. ej. {:req, "~> 0.5"}.
    ]
  end
end
