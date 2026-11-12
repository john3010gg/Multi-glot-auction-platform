defmodule ConsultaWeb.Health do
  @moduledoc "GET /health — liveness; informa el modo activo."
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    cuerpo = Jason.encode!(%{servicio: "consulta", hardened: Consulta.Modo.hardened?()})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, cuerpo)
  end
end

defmodule ConsultaWeb.ErrorJSON do
  @moduledoc false

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
