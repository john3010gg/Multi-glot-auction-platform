defmodule MotorSubastas.Application do
  @moduledoc """
  Motor de subastas: servidor gRPC del contrato `subastas.v1.Subastas`.

  Fallas OWASP API Top 10 (2023) que se demuestran en este servicio:

    * API5 — Broken Function Level Authorization: RPCs privilegiados
      (crear/cerrar subastas, operaciones administrativas) invocables por
      cualquier llamador en modo vulnerable.
    * API9 — Improper Inventory Management: reflection gRPC abierta y
      servicios/versiones "olvidados" expuestos en modo vulnerable.
  """
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    puerto = Application.fetch_env!(:motor_subastas, :grpc_port)

    Logger.info(
      "motor de subastas escuchando gRPC en :#{puerto} " <>
        "(modo #{if MotorSubastas.Modo.hardened?(), do: "BLINDADO", else: "VULNERABLE"})"
    )

    children = [
      # TODO(equipo): proceso(s) que guardan el estado de las subastas
      # (GenServer por subasta, Registry, ETS...) y el temporizador de cierre.

      # TODO(equipo): reflection gRPC. Arrancar GrpcReflection SOLO si
      # `not MotorSubastas.Modo.hardened?()` (API8/API9).

      {GRPC.Server.Supervisor,
       endpoint: MotorSubastas.Endpoint,
       port: puerto,
       start_server: true,
       adapter_opts: [ip: {0, 0, 0, 0}]}
      # TODO(equipo): TLS. En modo blindado pasar `cred: GRPC.Credential.new(ssl: ...)`
      # con los archivos de :tls_cert_file / :tls_key_file / :tls_ca_file (API8).
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MotorSubastas.Supervisor)
  end
end
