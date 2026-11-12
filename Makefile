# Generación de código desde proto/ y atajos de despliegue.
#
# Requisitos para generar en local (las imágenes Docker de Elixir ya lo hacen
# solas durante el build):
#   - protoc                         https://grpc.io/docs/protoc-installation/
#   - protoc-gen-elixir              mix escript.install hex protobuf
#                                    (y ~/.mix/escripts en el PATH)
#   - proto-lens-protoc (Haskell)    cabal install proto-lens-protoc

PROTO_DIR   := proto
PROTO_FILES := $(wildcard $(PROTO_DIR)/*.proto)

ELIXIR_OUT_SUBASTAS := services/subastas/lib/generated
ELIXIR_OUT_CONSULTA := services/consulta/lib/generated
HASKELL_OUT         := services/usuarios/gen

.PHONY: help proto proto-elixir proto-haskell proto-clean \
        up-vulnerable up-hardened down logs seed certs todos

help: ## Lista los targets disponibles
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-16s %s\n", $$1, $$2}'

# ── Generación de código ─────────────────────────────────────

proto: proto-elixir proto-haskell ## Genera código para todos los lenguajes

proto-elixir: ## Elixir: mensajes + servidor (subastas) y cliente (consulta) gRPC
	mkdir -p $(ELIXIR_OUT_SUBASTAS) $(ELIXIR_OUT_CONSULTA)
	protoc -I $(PROTO_DIR) --elixir_out=plugins=grpc:$(ELIXIR_OUT_SUBASTAS) $(PROTO_FILES)
	protoc -I $(PROTO_DIR) --elixir_out=plugins=grpc:$(ELIXIR_OUT_CONSULTA) $(PROTO_FILES)

proto-haskell: ## Haskell: tipos proto-lens para usuarios (compilar con -f proto)
	mkdir -p $(HASKELL_OUT)
	protoc -I $(PROTO_DIR) \
	  --plugin=protoc-gen-haskell=$$(command -v proto-lens-protoc) \
	  --haskell_out=$(HASKELL_OUT) $(PROTO_FILES)

proto-clean: ## Borra todo el código generado
	rm -rf $(ELIXIR_OUT_SUBASTAS) $(ELIXIR_OUT_CONSULTA) $(HASKELL_OUT)

# ── Despliegue ───────────────────────────────────────────────

up-vulnerable: ## Levanta todo con las defensas apagadas (HARDENED=false)
	HARDENED=false docker compose up --build -d

up-hardened: ## Levanta todo con las defensas encendidas (HARDENED=true)
	HARDENED=true docker compose up --build -d

down: ## Detiene y elimina contenedores y redes
	docker compose down

logs: ## Sigue los logs de los tres servicios
	docker compose logs -f

seed: ## Crea datos de prueba (ver scripts/seed.sh)
	bash scripts/seed.sh

certs: ## TODO(equipo): generar CA y certificados de servicio en ./certs
	@echo "TODO(equipo): generar CA + certificados (SAN = subastas, usuarios, consulta) en ./certs"
	@echo "Los nombres esperados estan en .env.example (TLS_CA_FILE, TLS_CERT_FILE, TLS_KEY_FILE)."
	@exit 1

todos: ## Lista todos los puntos pendientes marcados para el equipo
	@grep -rn "TODO(equipo)" --exclude-dir=.git --exclude-dir=deps --exclude-dir=_build --exclude-dir=dist-newstyle . || true
