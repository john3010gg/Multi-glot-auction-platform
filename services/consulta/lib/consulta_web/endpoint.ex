defmodule ConsultaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :consulta
  use Absinthe.Phoenix.Endpoint

  # WebSocket de las subscriptions GraphQL: ws://HOST:4000/socket/websocket
  socket "/socket", ConsultaWeb.UserSocket, websocket: true, longpoll: false

  plug Plug.RequestId
  plug Plug.Logger

  # TODO(equipo): rate limiting por cliente, activo solo en modo blindado
  # (valores en :rate_limit_max / :rate_limit_window_ms) — API4/API6.

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason

  # TODO(equipo): plug de autenticación que deje al usuario en el contexto de
  # Absinthe (`Absinthe.Plug.put_options(conn, context: %{...})`).

  plug ConsultaWeb.Router
end
