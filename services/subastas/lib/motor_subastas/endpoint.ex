defmodule MotorSubastas.Endpoint do
  @moduledoc "Endpoint gRPC: lista de interceptores y de servicios publicados."
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger

  # TODO(equipo): interceptor de autenticación (identificar al llamador).
  # TODO(equipo): interceptor de autorización por función/RPC, activo solo en
  # modo blindado (API5).

  run MotorSubastas.Server

  # TODO(equipo): servicios extra para el catálogo (admin, versión antigua
  # olvidada para API9, reflection en modo vulnerable).
end
