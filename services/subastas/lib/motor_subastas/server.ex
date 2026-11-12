defmodule MotorSubastas.Server do
  @moduledoc """
  Implementación del servicio `subastas.v1.Subastas` (ver proto/subastas.proto).

  `Subastas.V1.Subastas.Service` y los structs `Subastas.V1.*` son código
  GENERADO en lib/generated/ (`make proto-elixir` o el build de Docker).

  Todos los RPC responden UNIMPLEMENTED hasta que el equipo escriba la lógica.
  Cada callback recibe `(request, materializer)`; ver la API de `GRPC.Stream`
  en https://hexdocs.pm/grpc_server para construir las respuestas.
  """
  use GRPC.Server, service: Subastas.V1.Subastas.Service

  # rpc Crear (Subasta) returns (Subasta)
  def crear(_subasta, _materializer) do
    # TODO(equipo): validar la subasta, asignar id, estado ABIERTA y persistir.
    # TODO(equipo): autorización a nivel de función (API5): ¿quién puede crear?
    no_implementado("Crear")
  end

  # rpc Pujar (PujarReq) returns (PujarResp)
  def pujar(_pujar_req, _materializer) do
    # TODO(equipo): lógica de pujas (incremento mínimo, cierre, líder,
    # concurrencia entre pujas simultáneas) y notificación a los seguidores.
    # TODO(equipo): no confiar en `usuario_id` del mensaje en modo blindado.
    no_implementado("Pujar")
  end

  # rpc Obtener (SubastaId) returns (Subasta)
  def obtener(_subasta_id, _materializer) do
    # TODO(equipo): buscar la subasta; NOT_FOUND si no existe.
    no_implementado("Obtener")
  end

  # rpc Seguir (SubastaId) returns (stream Subasta)
  def seguir(_subasta_id, _materializer) do
    # TODO(equipo): server-streaming: emitir el estado actual y luego cada
    # cambio de la subasta hasta que cierre o el cliente se desconecte.
    no_implementado("Seguir")
  end

  defp no_implementado(rpc) do
    raise GRPC.RPCError,
      status: GRPC.Status.unimplemented(),
      message: "TODO(equipo): #{rpc} no implementado"
  end
end
