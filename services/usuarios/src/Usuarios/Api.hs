{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

-- | Contrato REST del servicio (el tipo ES la especificacion).
-- Mantener sincronizado con la tabla de services/usuarios/README.md.
module Usuarios.Api
  ( API
  , api
  ) where

import Data.Text (Text)
import Servant

import Usuarios.Tipos

type API =
       -- GET /health
       "health" :> Get '[JSON] Salud
       -- POST /usuarios
  :<|> "usuarios" :> ReqBody '[JSON] NuevoUsuario :> Post '[JSON] Usuario
       -- GET /usuarios/:id                (API1, API3)
  :<|> "usuarios" :> Capture "id" Text :> Get '[JSON] Usuario
       -- GET /usuarios/:id/pagos          (API1)
  :<|> "usuarios" :> Capture "id" Text :> "pagos" :> Get '[JSON] [Pago]
       -- POST /pagos                      (API3)
  :<|> "pagos" :> ReqBody '[JSON] NuevoPago :> Post '[JSON] Pago
       -- GET /pagos/:id                   (API1)
  :<|> "pagos" :> Capture "id" Text :> Get '[JSON] Pago

-- TODO(equipo): agregar aqui las rutas nuevas (PATCH /usuarios/:id para
-- demostrar asignacion masiva, etc.) y su handler en Usuarios.Handlers.

api :: Proxy API
api = Proxy
