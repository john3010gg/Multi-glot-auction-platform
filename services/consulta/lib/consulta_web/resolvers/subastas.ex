defmodule ConsultaWeb.Resolvers.Subastas do
  @moduledoc "Resolvers que hablan con el motor de subastas (gRPC). Todos son stubs."

  @pendiente {:error, "TODO(equipo): resolver no implementado"}

  # Query.subasta(id)
  def obtener(_padre, _args, _resolucion) do
    # TODO(equipo): Consulta.Clientes.Subastas.obtener/1 y mapear a :subasta.
    @pendiente
  end

  # Query.subastas
  def listar(_padre, _args, _resolucion) do
    # TODO(equipo): listado (requiere extender el .proto con un RPC de listado).
    @pendiente
  end

  # Usuario.subastas
  def de_usuario(_usuario, _args, _resolucion) do
    # TODO(equipo): subastas del usuario; cuidado con N+1 (dataloader/batch).
    @pendiente
  end

  # Mutation.crearSubasta(input)
  def crear(_padre, _args, _resolucion) do
    # TODO(equipo): Consulta.Clientes.Subastas.crear/1.
    @pendiente
  end

  # Mutation.pujar(subastaId, monto, usuarioId)
  def pujar(_padre, _args, _resolucion) do
    # TODO(equipo): Consulta.Clientes.Subastas.pujar/1.
    # TODO(equipo): freno al flujo de negocio en modo blindado (API6).
    @pendiente
  end
end
