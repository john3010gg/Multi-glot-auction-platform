{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

-- | Tipos del contrato REST. Las instancias JSON son las genericas de aeson:
-- la clave JSON es el nombre del campo Haskell tal cual.
--
-- TODO(equipo): definir los nombres JSON definitivos y, sobre todo, separar
-- los tipos de ENTRADA de los de SALIDA: que el mismo record sirva para
-- ambas cosas es justo lo que permite la asignacion masiva y la exposicion
-- excesiva de propiedades (API3).
module Usuarios.Tipos
  ( Salud (..)
  , Usuario (..)
  , NuevoUsuario (..)
  , Pago (..)
  , NuevoPago (..)
  ) where

import Data.Aeson (FromJSON, ToJSON)
import Data.Int (Int64)
import Data.Text (Text)
import GHC.Generics (Generic)

data Salud = Salud
  { servicio :: Text
  , hardened :: Bool
  }
  deriving (Show, Generic, ToJSON)

data Usuario = Usuario
  { usuarioId :: Text
  , nombre    :: Text
  , email     :: Text
  , rol       :: Text
  , saldo     :: Int64
  }
  deriving (Show, Generic, ToJSON, FromJSON)

data NuevoUsuario = NuevoUsuario
  { nuevoNombre :: Text
  , nuevoEmail  :: Text
  }
  deriving (Show, Generic, ToJSON, FromJSON)

data Pago = Pago
  { pagoId        :: Text
  , pagoUsuarioId :: Text
  , pagoSubastaId :: Text
  , pagoMonto     :: Int64
  , pagoEstado    :: Text
  }
  deriving (Show, Generic, ToJSON, FromJSON)

data NuevoPago = NuevoPago
  { npUsuarioId :: Text
  , npSubastaId :: Text
  , npMonto     :: Int64
  }
  deriving (Show, Generic, ToJSON, FromJSON)
