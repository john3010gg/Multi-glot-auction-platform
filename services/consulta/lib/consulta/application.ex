defmodule Consulta.Application do
  @moduledoc """
  Gateway de consulta: GraphQL (queries, mutations y subscriptions) sobre el
  motor de subastas (gRPC) y el servicio de usuarios (REST). Es el único
  servicio alcanzable desde fuera de la red backend.

  Fallas OWASP API Top 10 (2023) que se demuestran en este servicio:

    * API4 — Unrestricted Resource Consumption: consultas anidadas/costosas
      sin límite de profundidad ni de costo, batching y sin rate limiting.
    * API6 — Unrestricted Access to Sensitive Business Flows: automatización
      del flujo de pujas (bots, sniping) sin ningún freno.
    * API8 — Security Misconfiguration: introspección y GraphiQL abiertos,
      sin TLS, errores detallados.
  """
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info(
      "gateway GraphQL arrancando " <>
        "(modo #{if Consulta.Modo.hardened?(), do: "BLINDADO", else: "VULNERABLE"})"
    )

    children = [
      {Phoenix.PubSub, name: Consulta.PubSub},
      # Supervisor de conexiones del cliente gRPC (lo usa GRPC.Stub.connect/2)
      {GRPC.Client.Supervisor, []},
      ConsultaWeb.Endpoint,
      {Absinthe.Subscription, ConsultaWeb.Endpoint}
      # TODO(equipo): proceso que llama a Seguir() en el motor y publica cada
      # cambio con Absinthe.Subscription.publish/3 (alimenta subastaActualizada).
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Consulta.Supervisor)
  end
end
