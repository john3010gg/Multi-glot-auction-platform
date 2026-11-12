# Contexto de build: la RAÍZ del repo (necesita proto/).
FROM elixir:1.18-alpine

RUN apk add --no-cache build-base git protobuf protobuf-dev
RUN mix local.hex --force && mix local.rebar --force \
 && mix escript.install hex protobuf --force
ENV PATH="/root/.mix/escripts:${PATH}" MIX_ENV=prod

WORKDIR /app
# TODO(equipo): tras el primer `mix deps.get`, versionar mix.lock y copiarlo aquí.
COPY services/consulta/mix.exs ./
RUN mix deps.get --only prod && mix deps.compile

COPY proto /proto
COPY services/consulta/config config
COPY services/consulta/lib lib

# Generación de código desde los .proto (mensajes + stub cliente gRPC)
RUN rm -rf lib/generated && mkdir -p lib/generated \
 && protoc -I /proto --elixir_out=plugins=grpc:lib/generated /proto/*.proto
RUN mix compile

EXPOSE 4000
CMD ["mix", "run", "--no-halt"]
