{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API
  ( API
  , server
  ) where

import Control.Monad.IO.Class (liftIO)
import Data.Aeson (encode)
import Distribution.Types.PackageDescription (PackageDescription)
import Servant ((:>), JSON, PlainText, Post, ReqBody, Server)
import System.IO (hFlush, stdout)

import Dependency

import Distribution.Types.PackageDescription.MimeUnrender ()

type API = "parse" :> ReqBody '[PlainText] PackageDescription :> Post '[JSON] [Dependency]

server :: Server API
server d =
  do liftIO $ print d >> hFlush stdout
     liftIO $ print (encode ds) >> hFlush stdout
     return ds
  where ds = dependencies d
