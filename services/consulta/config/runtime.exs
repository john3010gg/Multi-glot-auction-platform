import Config

# Toda la configuración llega por variables de entorno (ver docker-compose.yml).
config :consulta, ConsultaWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: String.to_integer(System.get_env("PORT", "4000"))],
  # TODO(equipo): TLS hacia el cliente en modo blindado (`https: [...]`, API8).
  check_origin: false,
  secret_key_base:
    System.get_env(
      "SECRET_KEY_BASE",
      "CAMBIAR_por_un_valor_aleatorio_de_al_menos_64_caracteres_0123456789abcdef"
    )

config :consulta,
  hardened: System.get_env("HARDENED", "false") == "true",
  subastas_grpc_addr: System.get_env("SUBASTAS_GRPC_ADDR", "localhost:50051"),
  usuarios_http_url: System.get_env("USUARIOS_HTTP_URL", "http://localhost:8080"),
  # Placeholders de las defensas: se leen pero nadie los usa todavía.
  graphql_max_depth: String.to_integer(System.get_env("GRAPHQL_MAX_DEPTH", "0")),
  graphql_max_complexity: String.to_integer(System.get_env("GRAPHQL_MAX_COMPLEXITY", "0")),
  rate_limit_max: String.to_integer(System.get_env("RATE_LIMIT_MAX", "0")),
  rate_limit_window_ms: String.to_integer(System.get_env("RATE_LIMIT_WINDOW_MS", "0")),
  tls_ca_file: System.get_env("TLS_CA_FILE"),
  tls_cert_file: System.get_env("TLS_CERT_FILE"),
  tls_key_file: System.get_env("TLS_KEY_FILE"),
  auth_secret: System.get_env("AUTH_SECRET")
