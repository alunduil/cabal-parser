module Environment
  ( Environment
      ( Environment
      , port
      )
  ) where

import System.Envy ((.!=), envMaybe, FromEnv (fromEnv))

newtype Environment = Environment { port :: Int }

instance Show Environment where
  show e = "PORT=" ++ show (port e) ++ "\n"

instance FromEnv Environment where
  fromEnv = Environment <$> envMaybe "PORT" .!= 5000
