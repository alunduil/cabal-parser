{-# OPTIONS_GHC -fno-warn-orphans #-}

module Distribution.Version.JSON where

import Data.Aeson (ToJSON (toJSON), Value (String))
import Data.Text (pack)
import Distribution.Text (disp)
import Distribution.Version (simplifyVersionRange, VersionRange)
import Text.PrettyPrint (render)

instance ToJSON VersionRange where
  toJSON = String . pack . render . disp . simplifyVersionRange
