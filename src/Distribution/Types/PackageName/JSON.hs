{-# OPTIONS_GHC -fno-warn-orphans #-}

module Distribution.Types.PackageName.JSON where

import Data.Aeson (ToJSON (toJSON), Value (String))
import Data.Text (pack)
import Distribution.Types.PackageName (PackageName, unPackageName)

instance ToJSON PackageName where
  toJSON = String . pack . unPackageName
