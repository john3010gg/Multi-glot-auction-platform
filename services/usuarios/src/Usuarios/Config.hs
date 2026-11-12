-- | Configuracion por variables de entorno (ver docker-compose.yml).
module Usuarios.Config
  ( Config (..)
  , cargarConfig
  ) where

import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import Text.Read (readMaybe)

data Config = Config
  { cfgPuerto       :: Int
  -- | Interruptor de modo: HARDENED=true => blindado; otro valor => vulnerable.
  -- Cada defensa debe consultar este campo, no leer el entorno por su cuenta.
  , cfgHardened     :: Bool
  , cfgSubastasAddr :: String
  -- Placeholders de las defensas: se leen pero nadie los usa todavia.
  , cfgTlsCertFile  :: Maybe FilePath
  , cfgTlsKeyFile   :: Maybe FilePath
  , cfgAuthSecret   :: Maybe String
  }

cargarConfig :: IO Config
cargarConfig = do
  puerto   <- lookupEnv "PORT"
  hardened <- lookupEnv "HARDENED"
  subastas <- lookupEnv "SUBASTAS_GRPC_ADDR"
  cert     <- lookupEnv "TLS_CERT_FILE"
  key      <- lookupEnv "TLS_KEY_FILE"
  secreto  <- lookupEnv "AUTH_SECRET"
  pure Config
    { cfgPuerto       = fromMaybe 8080 (puerto >>= readMaybe)
    , cfgHardened     = hardened == Just "true"
    , cfgSubastasAddr = fromMaybe "localhost:50051" subastas
    , cfgTlsCertFile  = cert
    , cfgTlsKeyFile   = key
    , cfgAuthSecret   = secreto
    }
