# Informe de seguridad — Plataforma de subastas

> Plantilla. Reemplazar cada `TODO(equipo)` y borrar las instrucciones en cursiva.

| | |
|---|---|
| **Curso** | TODO(equipo) |
| **Integrantes** | TODO(equipo) |
| **Fecha** | TODO(equipo) |
| **Commit evaluado** | TODO(equipo) |

## 1. Resumen ejecutivo

TODO(equipo): _qué se construyó, qué fallas se demostraron y resultado global
de los dos modos, en un párrafo._

## 2. Alcance y metodología

- **Sistema bajo prueba:** ver [topologia.md](topologia.md).
- **Modos:** vulnerable (`HARDENED=false`) y blindado (`HARDENED=true`).
- **Posición del atacante:** TODO(equipo) _(externo vía gateway / con acceso a la red backend)._
- **Herramientas:** scripts de `attack/`, TODO(equipo).
- **Referencia:** OWASP API Security Top 10 — 2023.

## 3. Matriz de resultados

| Falla | Servicio | Script | Modo vulnerable | Modo blindado |
|-------|----------|--------|-----------------|---------------|
| API1 Broken Object Level Authorization | usuarios (REST) | `attack/api1_bola.sh` | TODO(equipo) | TODO(equipo) |
| API2 Broken Authentication | — | — | fuera del catálogo | fuera del catálogo |
| API3 Broken Object Property Level Authorization | usuarios (REST) | `attack/api3_bopla.sh` | TODO(equipo) | TODO(equipo) |
| API4 Unrestricted Resource Consumption | consulta (GraphQL) | `attack/api4_consumo_recursos.sh` | TODO(equipo) | TODO(equipo) |
| API5 Broken Function Level Authorization | subastas (gRPC) | `attack/api5_bfla.sh` | TODO(equipo) | TODO(equipo) |
| API6 Unrestricted Access to Sensitive Business Flows | consulta (GraphQL) | `attack/api6_flujos_negocio.sh` | TODO(equipo) | TODO(equipo) |
| API7 Server Side Request Forgery | — | — | fuera del catálogo | fuera del catálogo |
| API8 Security Misconfiguration | consulta (GraphQL) y transporte | `attack/api8_misconfig.sh` | TODO(equipo) | TODO(equipo) |
| API9 Improper Inventory Management | subastas (gRPC) | `attack/api9_inventario.sh` | TODO(equipo) | TODO(equipo) |
| API10 Unsafe Consumption of APIs | — | — | fuera del catálogo | fuera del catálogo |

## 4. Hallazgos

_Una sección por falla del OWASP API Top 10 (2023)._

### API1:2023 — Broken Object Level Authorization

- **Servicio afectado:** usuarios (REST)
- **Script:** `attack/api1_bola.sh`
- **Defensa que controla `HARDENED`:** Autorización a nivel de objeto

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api1_bola.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api1_bola.sh
TODO(equipo): pegar salida
```

### API2:2023 — Broken Authentication

_Fuera del catálogo del proyecto._ TODO(equipo): justificar en una o dos
líneas por qué no aplica o no se demuestra, o completar las tres subsecciones
de abajo si se decide cubrirla.

#### Descripción

TODO(equipo)

#### Evidencia en modo vulnerable

TODO(equipo)

#### Cómo lo detiene el modo blindado

TODO(equipo)

### API3:2023 — Broken Object Property Level Authorization

- **Servicio afectado:** usuarios (REST)
- **Script:** `attack/api3_bopla.sh`
- **Defensa que controla `HARDENED`:** Autorización a nivel de propiedad

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api3_bopla.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api3_bopla.sh
TODO(equipo): pegar salida
```

### API4:2023 — Unrestricted Resource Consumption

- **Servicio afectado:** consulta (GraphQL)
- **Script:** `attack/api4_consumo_recursos.sh`
- **Defensa que controla `HARDENED`:** Límites de profundidad/costo y rate limiting

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api4_consumo_recursos.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api4_consumo_recursos.sh
TODO(equipo): pegar salida
```

### API5:2023 — Broken Function Level Authorization

- **Servicio afectado:** subastas (gRPC)
- **Script:** `attack/api5_bfla.sh`
- **Defensa que controla `HARDENED`:** Autorización a nivel de función

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api5_bfla.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api5_bfla.sh
TODO(equipo): pegar salida
```

### API6:2023 — Unrestricted Access to Sensitive Business Flows

- **Servicio afectado:** consulta (GraphQL)
- **Script:** `attack/api6_flujos_negocio.sh`
- **Defensa que controla `HARDENED`:** Rate limiting y frenos al flujo de pujas

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api6_flujos_negocio.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api6_flujos_negocio.sh
TODO(equipo): pegar salida
```

### API7:2023 — Server Side Request Forgery

_Fuera del catálogo del proyecto._ TODO(equipo): justificar en una o dos
líneas por qué no aplica o no se demuestra, o completar las tres subsecciones
de abajo si se decide cubrirla.

#### Descripción

TODO(equipo)

#### Evidencia en modo vulnerable

TODO(equipo)

#### Cómo lo detiene el modo blindado

TODO(equipo)

### API8:2023 — Security Misconfiguration

- **Servicio afectado:** consulta (GraphQL) y transporte
- **Script:** `attack/api8_misconfig.sh`
- **Defensa que controla `HARDENED`:** TLS, introspección GraphQL deshabilitada

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api8_misconfig.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api8_misconfig.sh
TODO(equipo): pegar salida
```

### API9:2023 — Improper Inventory Management

- **Servicio afectado:** subastas (gRPC)
- **Script:** `attack/api9_inventario.sh`
- **Defensa que controla `HARDENED`:** Reflection gRPC deshabilitada, inventario de servicios

#### Descripción

TODO(equipo): _en qué consiste la falla en general y cómo se manifiesta en
esta plataforma (qué ruta/RPC/consulta, qué supuesto roto)._

#### Evidencia en modo vulnerable

TODO(equipo): _comando exacto, petición y respuesta (o captura), e impacto._

```text
$ HARDENED=false docker compose up -d
$ ./attack/api9_inventario.sh
TODO(equipo): pegar salida
```

#### Cómo lo detiene el modo blindado

TODO(equipo): _qué defensa se activa, dónde está en el código (archivo y
función), con qué valores y por qué esos valores; y la misma prueba fallando._

```text
$ HARDENED=true docker compose up -d
$ ./attack/api9_inventario.sh
TODO(equipo): pegar salida
```

### API10:2023 — Unsafe Consumption of APIs

_Fuera del catálogo del proyecto._ TODO(equipo): justificar en una o dos
líneas por qué no aplica o no se demuestra, o completar las tres subsecciones
de abajo si se decide cubrirla.

#### Descripción

TODO(equipo)

#### Evidencia en modo vulnerable

TODO(equipo)

#### Cómo lo detiene el modo blindado

TODO(equipo)

## 5. Riesgo residual y limitaciones

TODO(equipo): _qué sigue siendo posible en modo blindado y qué quedó fuera._

## 6. Conclusiones

TODO(equipo)

## Anexos

- A. Valores de las defensas (`.env`) usados en la evaluación: TODO(equipo)
- B. Cómo reproducir: ver [README](../README.md).
