defmodule Consulta.Modo do
  @moduledoc """
  Interruptor de modo. `HARDENED=true` => blindado, cualquier otro valor => vulnerable.

  Es el ÚNICO lugar donde se consulta la variable: cada defensa debe preguntar
  aquí en vez de leer el entorno por su cuenta.
  """

  @spec hardened?() :: boolean()
  def hardened?, do: Application.get_env(:consulta, :hardened, false)
end
