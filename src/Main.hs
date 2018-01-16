module Main (main) where

import API
import Environment
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.RequestLogger (logStdout)
import Servant (Application, Proxy (Proxy), serve)
import System.Envy (decodeEnv)

main :: IO ()
main = either fail (flip run application' . port) =<< decodeEnv
  where application' = logStdout application

application :: Application
application = serve (Proxy :: Proxy API) server
