import Config

config :consulta, ConsultaWeb.Endpoint,
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  pubsub_server: Consulta.PubSub,
  render_errors: [formats: [json: ConsultaWeb.ErrorJSON], layout: false],
  server: true

config :phoenix, :json_library, Jason
config :logger, level: :info
