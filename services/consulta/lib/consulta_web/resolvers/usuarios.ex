defmodule ConsultaWeb.Resolvers.Usuarios do
  @moduledoc "Resolvers que hablan con el servicio de usuarios (REST). Todos son stubs."

  @pendiente {:error, "TODO(equipo): resolver no implementado"}

  # Query.usuario(id)
  def obtener(_padre, _args, _resolucion) do
    # TODO(equipo): Consulta.Clientes.Usuarios.obtener_usuario/1.
    @pendiente
  end

  # Subasta.vendedor
  def vendedor(_subasta, _args, _resolucion) do
    # TODO(equipo): resolver con subasta.vendedor_id.
    @pendiente
  end

  # Subasta.lider
  def lider(_subasta, _args, _resolucion) do
    # TODO(equipo): resolver con subasta.lider_id.
    @pendiente
  end
end
