{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API
  ( API
  , server
  ) where

import Dependencies
import Dependency
import Distribution.Types.GenericPackageDescription (GenericPackageDescription)
import Distribution.Types.GenericPackageDescription.MimeUnrender ()
import Servant ((:>), JSON, PlainText, Post, ReqBody, Server)

type API = "parse" :> ReqBody '[PlainText] GenericPackageDescription :> Post '[JSON] [Dependency]

server :: Server API
server = return . dependencies
