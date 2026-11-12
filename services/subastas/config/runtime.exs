import Config

# Toda la configuración llega por variables de entorno (ver docker-compose.yml).
config :motor_subastas,
  grpc_port: String.to_integer(System.get_env("GRPC_PORT", "50051")),
  hardened: System.get_env("HARDENED", "false") == "true",
  # Placeholders de las defensas: se leen pero nadie los usa todavía.
  tls_ca_file: System.get_env("TLS_CA_FILE"),
  tls_cert_file: System.get_env("TLS_CERT_FILE"),
  tls_key_file: System.get_env("TLS_KEY_FILE"),
  auth_secret: System.get_env("AUTH_SECRET")
