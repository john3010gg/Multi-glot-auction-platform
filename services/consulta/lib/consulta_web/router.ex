defmodule ConsultaWeb.Router do
  use Phoenix.Router

  forward "/health", ConsultaWeb.Health

  # POST /graphql — queries y mutations
  forward "/graphql", Absinthe.Plug, schema: ConsultaWeb.Schema
  # TODO(equipo): en modo blindado, límites de profundidad y costo con los
  # valores de :graphql_max_depth / :graphql_max_complexity (API4), y
  # deshabilitar la introspección (API8).

  # GET /graphiql — consola interactiva.
  # TODO(equipo): no exponerla en modo blindado (API8).
  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: ConsultaWeb.Schema,
    socket: ConsultaWeb.UserSocket,
    interface: :playground
end
