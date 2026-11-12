defmodule Consulta.Clientes.Subastas do
  @moduledoc """
  Cliente gRPC hacia el motor de subastas.

  El stub `Subastas.V1.Subastas.Stub` es código GENERADO en lib/generated/
  (`make proto-elixir` o el build de Docker). Uso previsto:

      {:ok, canal} = GRPC.Stub.connect(direccion())
      Subastas.V1.Subastas.Stub.obtener(canal, %Subastas.V1.SubastaId{id: id})
  """

  def direccion, do: Application.fetch_env!(:consulta, :subastas_grpc_addr)

  # TODO(equipo): abrir y reutilizar el canal (GRPC.Stub.connect/2); en modo
  # blindado con TLS (`cred: GRPC.Credential.new(ssl: ...)`).
  # TODO(equipo): crear/1, pujar/1, obtener/1 y seguir/1 llamando al stub.
end

defmodule Consulta.Clientes.Usuarios do
  @moduledoc """
  Cliente REST hacia el servicio de usuarios y pagos
  (contrato en services/usuarios/README.md).
  """

  def url_base, do: Application.fetch_env!(:consulta, :usuarios_http_url)

  # TODO(equipo): obtener_usuario/1, pagos_de_usuario/1, etc.
  # TODO(equipo): propagar la identidad del llamador hacia usuarios.
end
