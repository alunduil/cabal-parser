module Main (main) where

import Network.Wai.Handler.Warp (run)
import Servant (Application, Proxy (Proxy), serve)
import System.Envy (decodeEnv)

import API
import Environment

main :: IO ()
main = either fail (flip run application . port) =<< decodeEnv

application :: Application
application = serve (Proxy :: Proxy API) server
