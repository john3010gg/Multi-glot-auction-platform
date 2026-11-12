-- | Servicio de usuarios y pagos (REST, Servant).
--
-- Fallas OWASP API Top 10 (2023) que se demuestran en este servicio:
--
--   * API1 - Broken Object Level Authorization: leer usuarios/pagos ajenos
--     cambiando el id de la ruta, en modo vulnerable.
--   * API3 - Broken Object Property Level Authorization: propiedades
--     sensibles devueltas de mas y asignacion masiva en los cuerpos JSON.
module Main (main) where

import Network.Wai.Handler.Warp (run)
import Servant (serve)
import System.IO (BufferMode (LineBuffering), hSetBuffering, stdout)

import Usuarios.Api (api)
import Usuarios.Config (Config (..), cargarConfig)
import Usuarios.Handlers (server)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  cfg <- cargarConfig
  putStrLn $
    "usuarios escuchando HTTP en :" <> show (cfgPuerto cfg)
      <> " (modo " <> (if cfgHardened cfg then "BLINDADO" else "VULNERABLE") <> ")"
  -- TODO(equipo): en modo blindado servir con TLS (warp-tls) usando los
  -- archivos de cfgTls* (API8).
  -- TODO(equipo): middleware de autenticacion (identificar al llamador).
  run (cfgPuerto cfg) (serve api (server cfg))
