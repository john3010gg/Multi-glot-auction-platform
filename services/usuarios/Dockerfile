# Contexto de build: la RAÍZ del repo.
# El primer build tarda (compila Servant y Warp desde cero); luego queda en caché.
FROM haskell:9.6-slim-bullseye AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN cabal update

# Capa de dependencias (solo cambia si cambia el .cabal)
COPY services/usuarios/usuarios.cabal ./
RUN cabal build --only-dependencies exe:usuarios

COPY services/usuarios/ ./

# "-f proto" compila además los módulos generados en gen/ (make proto-haskell)
ARG CABAL_FLAGS=""
RUN cabal build exe:usuarios ${CABAL_FLAGS} \
 && mkdir -p /out \
 && cp "$(cabal list-bin exe:usuarios ${CABAL_FLAGS})" /out/usuarios

FROM debian:bullseye-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends libgmp10 zlib1g ca-certificates \
 && rm -rf /var/lib/apt/lists/*
COPY --from=build /out/usuarios /usr/local/bin/usuarios

EXPOSE 8080
CMD ["usuarios"]
