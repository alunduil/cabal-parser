module Main (main) where

import API
import Environment
import Network.Wai.Handler.Warp (run)
import Servant (Application, Proxy (Proxy), serve)
import System.Envy (decodeEnv)

main :: IO ()
main = either fail (flip run application . port) =<< decodeEnv

application :: Application
application = serve (Proxy :: Proxy API) server
