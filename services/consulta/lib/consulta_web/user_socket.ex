defmodule ConsultaWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: ConsultaWeb.Schema

  @impl true
  def connect(_params, socket, _connect_info) do
    # TODO(equipo): autenticar la conexión WebSocket y cargar al usuario en el
    # contexto de Absinthe (Absinthe.Phoenix.Socket.put_options/2).
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
