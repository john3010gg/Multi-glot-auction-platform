defmodule ConsultaWeb.Schema do
  @moduledoc """
  Esquema GraphQL del gateway. Refleja proto/subastas.proto y el contrato REST
  de usuarios. Todos los resolvers son stubs (ver ConsultaWeb.Resolvers.*).

  Ojo con la forma del grafo: `Subasta.vendedor -> Usuario.subastas -> Subasta`
  es un ciclo a propósito; es la superficie para demostrar consultas de
  profundidad/costo arbitrario (API4) mientras no existan límites.
  """
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  alias ConsultaWeb.Resolvers

  enum :estado do
    value :estado_desconocido
    value :abierta
    value :cerrada
  end

  object :subasta do
    field :id, non_null(:id)
    field :vendedor_id, :id
    field :titulo, :string
    field :precio_salida, :integer
    field :incremento_minimo, :integer
    field :precio_actual, :integer
    field :lider_id, :id
    field :cierre, :datetime
    field :estado, :estado

    field :vendedor, :usuario, resolve: &Resolvers.Usuarios.vendedor/3
    field :lider, :usuario, resolve: &Resolvers.Usuarios.lider/3
  end

  object :usuario do
    field :id, non_null(:id)
    field :nombre, :string
    # TODO(equipo): decidir qué propiedades del usuario expone el gateway y a
    # quién (el servicio REST es donde se demuestra API3).

    field :subastas, list_of(:subasta), resolve: &Resolvers.Subastas.de_usuario/3
  end

  object :resultado_puja do
    field :aceptada, non_null(:boolean)
    field :motivo, :string
    field :subasta, :subasta
  end

  input_object :nueva_subasta do
    field :titulo, non_null(:string)
    field :precio_salida, non_null(:integer)
    field :incremento_minimo, non_null(:integer)
    field :cierre, non_null(:datetime)
  end

  query do
    @desc "Una subasta por id (gRPC Obtener)"
    field :subasta, :subasta do
      arg :id, non_null(:id)
      resolve &Resolvers.Subastas.obtener/3
    end

    @desc "Listado de subastas"
    field :subastas, list_of(:subasta) do
      # TODO(equipo): paginación con tope máximo (API4).
      resolve &Resolvers.Subastas.listar/3
    end

    @desc "Un usuario por id (REST GET /usuarios/:id)"
    field :usuario, :usuario do
      arg :id, non_null(:id)
      resolve &Resolvers.Usuarios.obtener/3
    end
  end

  mutation do
    @desc "Crea una subasta (gRPC Crear)"
    field :crear_subasta, :subasta do
      arg :input, non_null(:nueva_subasta)
      resolve &Resolvers.Subastas.crear/3
    end

    @desc "Puja en una subasta (gRPC Pujar)"
    field :pujar, :resultado_puja do
      arg :subasta_id, non_null(:id)
      arg :monto, non_null(:integer)
      # TODO(equipo): en modo vulnerable el usuario llega como argumento; en
      # modo blindado sale de la identidad autenticada.
      arg :usuario_id, :id
      resolve &Resolvers.Subastas.pujar/3
    end
  end

  subscription do
    @desc "Cambios en vivo de una subasta (gRPC Seguir)"
    field :subasta_actualizada, :subasta do
      arg :id, non_null(:id)

      # Un topic por subasta. TODO(equipo): publicar en este topic desde el
      # proceso que consume Seguir() (ver Consulta.Application), y limitar
      # subscriptions por cliente en modo blindado (API4).
      config fn args, _resolution ->
        {:ok, topic: args.id}
      end
    end
  end
end
