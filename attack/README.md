# attack/ — toolkit ofensivo

Un script por falla del catálogo. **Están vacíos a propósito**: el equipo
escribe y defiende cada ataque.

| Script | Falla | Objetivo |
|--------|-------|----------|
| `api1_bola.sh` | API1:2023 Broken Object Level Authorization | usuarios (REST) |
| `api3_bopla.sh` | API3:2023 Broken Object Property Level Authorization | usuarios (REST) |
| `api4_consumo_recursos.sh` | API4:2023 Unrestricted Resource Consumption | consulta (GraphQL) |
| `api5_bfla.sh` | API5:2023 Broken Function Level Authorization | subastas (gRPC) |
| `api6_flujos_negocio.sh` | API6:2023 Unrestricted Access to Sensitive Business Flows | consulta (GraphQL) |
| `api8_misconfig.sh` | API8:2023 Security Misconfiguration | consulta (GraphQL) y transporte |
| `api9_inventario.sh` | API9:2023 Improper Inventory Management | subastas (gRPC) |

## Reglas

- Solo contra el despliegue local de este repo (`docker compose`). Nunca contra
  sistemas de terceros.
- Cada script debe **tener éxito en modo vulnerable** y **fallar en modo
  blindado**; ambas corridas son la evidencia del informe.
- Guardar la salida en `attack/out/` (ignorado por git) y copiar al informe
  solo lo necesario.

## Desde dónde se ataca

Solo el gateway GraphQL está publicado (`http://localhost:4000`). Los ataques
a gRPC y REST parten de un contenedor dentro de la red `backend`, que modela a
un atacante que ya tiene un pie adentro:

```sh
docker compose run --rm grpcurl -plaintext -import-path /proto -proto subastas.proto subastas:50051 list
docker compose run --rm curl -s http://usuarios:8080/health
```

TODO(equipo): acordar variables comunes (URL del gateway, credenciales de los
usuarios de prueba) y documentarlas aquí.
