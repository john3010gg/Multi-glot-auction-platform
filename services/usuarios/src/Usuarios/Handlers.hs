{-# LANGUAGE OverloadedStrings #-}

-- | Handlers de cada ruta. Salvo /health, todos responden 501 hasta que el
-- equipo escriba la logica.
module Usuarios.Handlers
  ( server
  ) where

import Data.Text (Text)
import Servant

import Usuarios.Api (API)
import Usuarios.Config (Config (..))
import Usuarios.Tipos

server :: Config -> Server API
server cfg =
       salud cfg
  :<|> crearUsuario
  :<|> obtenerUsuario
  :<|> pagosDeUsuario
  :<|> crearPago
  :<|> obtenerPago

-- GET /health
salud :: Config -> Handler Salud
salud cfg = pure Salud { servicio = "usuarios", hardened = cfgHardened cfg }

-- POST /usuarios
crearUsuario :: NuevoUsuario -> Handler Usuario
crearUsuario _nuevo =
  -- TODO(equipo): validar, asignar id y persistir.
  noImplementado

-- GET /usuarios/:id
obtenerUsuario :: Text -> Handler Usuario
obtenerUsuario _uid =
  -- TODO(equipo): buscar el usuario; 404 si no existe.
  -- TODO(equipo): autorizacion a nivel de objeto en modo blindado (API1).
  -- TODO(equipo): filtrar propiedades segun quien pregunta (API3).
  noImplementado

-- GET /usuarios/:id/pagos
pagosDeUsuario :: Text -> Handler [Pago]
pagosDeUsuario _uid =
  -- TODO(equipo): listar pagos del usuario.
  -- TODO(equipo): autorizacion a nivel de objeto en modo blindado (API1).
  noImplementado

-- POST /pagos
crearPago :: NuevoPago -> Handler Pago
crearPago _nuevo =
  -- TODO(equipo): logica de pagos (verificar ganador y monto contra el motor
  -- de subastas via gRPC, cfgSubastasAddr).
  -- TODO(equipo): no aceptar propiedades que el cliente no deberia fijar (API3).
  noImplementado

-- GET /pagos/:id
obtenerPago :: Text -> Handler Pago
obtenerPago _pid =
  -- TODO(equipo): buscar el pago; 404 si no existe.
  -- TODO(equipo): autorizacion a nivel de objeto en modo blindado (API1).
  noImplementado

noImplementado :: Handler a
noImplementado = throwError err501 { errBody = "TODO(equipo): no implementado" }
