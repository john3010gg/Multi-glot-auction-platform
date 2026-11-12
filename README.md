# Plataforma de subastas — gRPC + REST + GraphQL

Proyecto de redes: una plataforma de subastas en microservicios con dos modos
de despliegue, **vulnerable** y **blindado**, para demostrar fallas del
[OWASP API Security Top 10 (2023)](https://owasp.org/API-Security/editions/2023/en/0x11-t10/)
y sus defensas.

> **Estado: andamiaje.** Los tres servicios arrancan y exponen su interfaz,
> pero todos los RPC, rutas y resolvers son stubs. La lógica de pujas, la
> autenticación y las defensas las escribe el equipo. `make todos` lista cada
> punto pendiente (marcados `TODO(equipo)`).

## Estructura

```
proto/                contratos .proto compartidos (fuente de verdad)
services/subastas/    motor gRPC (Elixir)                       API5, API9
services/usuarios/    REST de usuarios y pagos (Haskell/Servant) API1, API3
services/consulta/    gateway GraphQL + subscriptions (Absinthe) API4, API6, API8
attack/               toolkit ofensivo, un script por falla (vacíos)
docs/                 informe de seguridad y topología (plantillas)
scripts/seed.sh       datos de prueba
certs/                certificados TLS locales (ignorados por git)
docker-compose.yml    despliegue e interruptor de modo
Makefile              generación de código desde proto/ y atajos
```

| Servicio   | Interfaz | Puerto | ¿Publicado al host? |
|------------|----------|--------|---------------------|
| `consulta` | GraphQL (HTTP + WebSocket) | 4000  | **sí**, el único |
| `subastas` | gRPC     | 50051  | no, solo red `backend` |
| `usuarios` | REST     | 8080   | no, solo red `backend` |

La red `backend` es `internal: true`: sin salida a Internet ni acceso desde el
host. Los servicios se encuentran por nombre (`subastas`, `usuarios`,
`consulta`). Diagrama en [docs/topologia.md](docs/topologia.md).

## Requisitos

- Docker con Compose v2. Nada más para levantar la plataforma.
- Opcional, para desarrollo local: Elixir ≥ 1.15, GHC 9.6 + cabal, `protoc`.

## Levantar

```sh
cp .env.example .env        # opcional: valores por defecto y placeholders
```

**Modo vulnerable** (defensas apagadas):

```sh
make up-vulnerable          # = HARDENED=false docker compose up --build -d
```

**Modo blindado** (defensas encendidas):

```sh
make certs                  # TODO(equipo): hoy solo imprime lo que falta
make up-hardened            # = HARDENED=true docker compose up --build -d
```

```sh
make logs                   # cada servicio registra en qué modo arrancó
make down
```

El primer build de `usuarios` tarda varios minutos (compila Servant y Warp).

### Qué controla `HARDENED`

Con `HARDENED=false` queda **apagado** todo lo siguiente; con `true`, encendido.

| Defensa | Servicio | Falla | Variables (placeholders) |
|---------|----------|-------|--------------------------|
| TLS entre servicios y hacia el cliente | los tres | API8 | `TLS_CA_FILE`, `TLS_CERT_FILE`, `TLS_KEY_FILE` |
| Introspección GraphQL deshabilitada (y GraphiQL) | consulta | API8 | — |
| Reflection gRPC deshabilitada | subastas | API8, API9 | — |
| Autorización a nivel de objeto | usuarios, consulta | API1, API3 | `AUTH_SECRET` |
| Autorización a nivel de función | subastas | API5 | `AUTH_SECRET` |
| Límites de profundidad y costo | consulta | API4 | `GRAPHQL_MAX_DEPTH`, `GRAPHQL_MAX_COMPLEXITY` |
| Rate limiting | consulta, usuarios | API4, API6 | `RATE_LIMIT_MAX`, `RATE_LIMIT_WINDOW_MS` |

> En el andamiaje la variable solo se **propaga y se registra**: los dos modos
> se comportan igual hasta que el equipo implemente cada defensa detrás de
> `Modo.hardened?/0` (Elixir) o `cfgHardened` (Haskell).

## Datos de prueba

```sh
make seed                   # = bash scripts/seed.sh
```

Crea dos usuarios (REST) y una subasta (gRPC) desde dentro de la red
`backend`. Con el andamiaje recién clonado responde `501` / `UNIMPLEMENTED`;
empieza a crear datos cuando existan `POST /usuarios` y el RPC `Crear`.

## Probar cada interfaz

gRPC y REST no están publicados, así que se prueban con contenedores de
herramientas conectados a la red `backend` (perfil `tools` del compose).

### gRPC — `subastas:50051`

```sh
# Listar servicios y métodos a partir del .proto (no necesita reflection)
docker compose run --rm grpcurl -plaintext -import-path /proto -proto subastas.proto \
  subastas:50051 list

docker compose run --rm grpcurl -plaintext -import-path /proto -proto subastas.proto \
  -d '{"id":"s-1"}' subastas:50051 subastas.v1.Subastas/Obtener

docker compose run --rm grpcurl -plaintext -import-path /proto -proto subastas.proto \
  -d '{"subasta_id":"s-1","usuario_id":"u-beto","monto":105000}' \
  subastas:50051 subastas.v1.Subastas/Pujar

# Streaming: queda abierto recibiendo cambios
docker compose run --rm grpcurl -plaintext -import-path /proto -proto subastas.proto \
  -d '{"id":"s-1"}' subastas:50051 subastas.v1.Subastas/Seguir
```

Hoy responden `Unimplemented`. En modo blindado: quitar `-plaintext` y usar
`-cacert /certs/ca.pem` (TODO(equipo)).

### REST — `usuarios:8080`

```sh
docker compose run --rm curl -s http://usuarios:8080/health
docker compose run --rm curl -s -i http://usuarios:8080/usuarios/u-ana
docker compose run --rm curl -s -i http://usuarios:8080/usuarios/u-ana/pagos
docker compose run --rm curl -s -i -X POST http://usuarios:8080/pagos \
  -H 'content-type: application/json' \
  -d '{"npUsuarioId":"u-beto","npSubastaId":"s-1","npMonto":105000}'
```

`/health` responde `200` con el modo activo; el resto, `501`. Contrato completo
en [services/usuarios/README.md](services/usuarios/README.md).

### GraphQL — `http://localhost:4000`

```sh
curl -s http://localhost:4000/health

curl -s http://localhost:4000/graphql -H 'content-type: application/json' \
  -d '{"query":"{ subasta(id: \"s-1\") { id titulo precioActual estado vendedor { nombre } } }"}'

curl -s http://localhost:4000/graphql -H 'content-type: application/json' \
  -d '{"query":"mutation { pujar(subastaId: \"s-1\", usuarioId: \"u-beto\", monto: 105000) { aceptada motivo } }"}'
```

Consola interactiva: <http://localhost:4000/graphiql>. Ahí también se prueban
las subscriptions (WebSocket en `ws://localhost:4000/socket`):

```graphql
subscription { subastaActualizada(id: "s-1") { precioActual liderId estado } }
```

Hoy cada campo devuelve el error `TODO(equipo): resolver no implementado`.

## Generar código desde `proto/`

Las imágenes Docker de los servicios Elixir generan su código durante el
build. Para desarrollo local:

```sh
make proto            # todos los lenguajes
make proto-elixir     # services/{subastas,consulta}/lib/generated/
make proto-haskell    # services/usuarios/gen/  (compilar con: cabal build -f proto)
make proto-clean
```

Requisitos y detalles al inicio del [Makefile](Makefile). El código generado
no se versiona.

## Toolkit ofensivo e informe

- [attack/](attack/README.md): un script por falla; debe funcionar en modo
  vulnerable y fallar en modo blindado.
- [docs/informe-seguridad.md](docs/informe-seguridad.md): plantilla con una
  sección por falla (descripción, evidencia, cómo la detiene el modo blindado).

Los ataques se ejecutan únicamente contra este despliegue local.

## Convención de pendientes

Todo lo que falta está marcado con `TODO(equipo)` usando el comentario de cada
lenguaje (`#` en Elixir/YAML/shell, `--` en Haskell, `//` en proto).

```sh
make todos
```
