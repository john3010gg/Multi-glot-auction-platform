defmodule MotorSubastas.MixProject do
  use Mix.Project

  def project do
    [
      app: :motor_subastas,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MotorSubastas.Application, []}
    ]
  end

  defp deps do
    [
      # Servidor gRPC (desde la v1.0 el servidor vive en :grpc_server)
      {:grpc_server, "~> 1.0"},
      # Runtime de los mensajes generados por protoc-gen-elixir
      {:protobuf, "~> 0.17"}
      # TODO(equipo): {:grpc_reflection, "~> 0.5"} para exponer reflection
      # SOLO en modo vulnerable (API8/API9).
    ]
  end
end
