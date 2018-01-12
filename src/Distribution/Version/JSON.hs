{-# OPTIONS_GHC -fno-warn-orphans #-}

module Distribution.Version.JSON where

import Data.Aeson (ToJSON (toJSON), Value (String))
import Data.Text (pack)
import Distribution.Version (simplifyVersionRange, VersionRange)

instance ToJSON VersionRange where
  toJSON = String . pack . show . simplifyVersionRange
