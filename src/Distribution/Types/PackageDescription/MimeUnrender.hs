{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Distribution.Types.PackageDescription.MimeUnrender where

import Data.ByteString.Lazy.UTF8 (toString)
import Distribution.PackageDescription.Parse (parseGenericPackageDescription, ParseResult (ParseFailed, ParseOk))
import Distribution.Types.GenericPackageDescription (packageDescription)
import Distribution.Types.PackageDescription (PackageDescription)
import Servant (MimeUnrender (mimeUnrender), PlainText)

instance MimeUnrender PlainText PackageDescription where
  mimeUnrender _ = toEither . parseGenericPackageDescription . toString
    where toEither (ParseFailed e) = Left $ show e
          toEither (ParseOk _ d)   = Right $ packageDescription d
