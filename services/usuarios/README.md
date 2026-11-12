# usuarios — REST de usuarios y pagos

Implementación de referencia en **Haskell + Servant**. El servicio es
**parametrizable**: el resto de la plataforma solo depende del contrato de
abajo, no del lenguaje.

## Contrato REST

| Método | Ruta                  | Cuerpo         | Respuesta | Falla OWASP |
|--------|-----------------------|----------------|-----------|-------------|
| GET    | `/health`             | —              | `Salud`   | —           |
| POST   | `/usuarios`           | `NuevoUsuario` | `Usuario` | API3        |
| GET    | `/usuarios/:id`       | —              | `Usuario` | API1, API3  |
| GET    | `/usuarios/:id/pagos` | —              | `[Pago]`  | API1        |
| POST   | `/pagos`              | `NuevoPago`    | `Pago`    | API3        |
| GET    | `/pagos/:id`          | —              | `Pago`    | API1        |

Los tipos están en `src/Usuarios/Tipos.hs` y las rutas en `src/Usuarios/Api.hs`.
Salvo `/health`, todo responde `501` hasta que el equipo implemente los handlers.

## Qué se puede parametrizar

| Qué                      | Cómo                                                        |
|--------------------------|-------------------------------------------------------------|
| Puerto                   | `USUARIOS_HTTP_PORT` (compose) → `PORT` (proceso)           |
| Modo                     | `HARDENED`                                                  |
| Dirección del motor gRPC | `SUBASTAS_GRPC_ADDR`                                        |
| Tipos generados de proto | `USUARIOS_CABAL_FLAGS="-f proto"` (tras `make proto-haskell`) |
| Implementación completa  | `USUARIOS_DOCKERFILE=ruta/a/otro/Dockerfile`                |

Para sustituir la implementación (otro lenguaje o framework) basta con otro
Dockerfile que respete el contrato REST, escuche en `PORT` y lea `HARDENED`.

## Desarrollo local

```sh
cabal run usuarios                 # http://localhost:8080/health
PORT=9000 HARDENED=true cabal run usuarios
```

## Código generado desde proto/

```sh
make proto-haskell                 # desde la raíz; deja Proto/*.hs en gen/
cabal build -f proto
```

Genera los **mensajes** (`Proto.Subastas`) con proto-lens.
TODO(equipo): elegir la librería de cliente gRPC para llamar al motor
(p. ej. `grapesy`) y agregarla al `.cabal`.
