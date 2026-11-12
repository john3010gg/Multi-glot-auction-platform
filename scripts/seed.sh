#!/usr/bin/env bash
# Datos de prueba: dos usuarios y una subasta abierta.
# Requiere la plataforma levantada (make up-vulnerable | make up-hardened).
#
# OJO: con el andamiaje recién clonado estas llamadas responden 501 /
# UNIMPLEMENTED; empiezan a crear datos cuando el equipo implemente
# POST /usuarios y el RPC Crear.
set -uo pipefail

GRPC_ADDR="subastas:${SUBASTAS_GRPC_PORT:-50051}"
REST_URL="http://usuarios:${USUARIOS_HTTP_PORT:-8080}"

rest() { docker compose run --rm -T curl -sS -w '\n[HTTP %{http_code}]\n' "$@"; }
grpc() { docker compose run --rm -T grpcurl -plaintext -import-path /proto -proto subastas.proto "$@"; }

echo "== usuarios =="
rest -X POST "$REST_URL/usuarios" -H 'content-type: application/json' \
  -d '{"nuevoNombre":"Ana Vendedora","nuevoEmail":"ana@example.test"}'
rest -X POST "$REST_URL/usuarios" -H 'content-type: application/json' \
  -d '{"nuevoNombre":"Beto Postor","nuevoEmail":"beto@example.test"}'

echo "== subasta =="
# TODO(equipo): usar el id real del vendedor devuelto arriba y un cierre futuro.
grpc -d '{
  "vendedor_id": "u-ana",
  "titulo": "Bicicleta de ruta",
  "precio_salida": 100000,
  "incremento_minimo": 5000,
  "cierre": "2030-01-01T00:00:00Z"
}' "$GRPC_ADDR" subastas.v1.Subastas/Crear

# TODO(equipo): en modo blindado, autenticarse y usar TLS (-cacert /certs/ca.pem).
# TODO(equipo): más datos (pujas, pagos, un usuario admin) para los ataques.
