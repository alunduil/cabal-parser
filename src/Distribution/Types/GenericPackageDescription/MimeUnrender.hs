{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Distribution.Types.GenericPackageDescription.MimeUnrender where

import Data.Bifunctor (first)
import Data.ByteString.Lazy (toStrict)
import Data.List (intercalate)
import Distribution.PackageDescription.Parsec (parseGenericPackageDescription, runParseResult)
import Distribution.Types.GenericPackageDescription (GenericPackageDescription)
import Servant (MimeUnrender (mimeUnrender), PlainText)

instance MimeUnrender PlainText GenericPackageDescription where
  mimeUnrender _ = errorToString . snd . runParseResult . parseGenericPackageDescription . toStrict
    where errorToString :: (Show b) => Either (a, [b]) GenericPackageDescription -> Either String GenericPackageDescription
          errorToString = first $ intercalate "\n" . map show . snd
