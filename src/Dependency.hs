{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Dependency
  ( DependencyType (..)
  , Dependency (..)
  ) where

import Data.Aeson ((.=), object, Value (String), ToJSON (toJSON))
import Distribution.Types.PackageName.JSON ()
import Distribution.Types.PackageName (PackageName)
import Distribution.Version.JSON ()
import Distribution.Version (VersionRange)

data Dependency = Dependency
  { dName        :: PackageName
  , dRequirement :: VersionRange
  , dType        :: DependencyType
  } deriving (Eq, Show)

instance ToJSON Dependency where
  toJSON Dependency{..} = object
    [ "name"        .= dName
    , "requirement" .= dRequirement
    , "type"        .= dType
    ]

data DependencyType = Build
                    | Runtime
                    | Test
                    | Benchmark
  deriving (Eq, Show)

instance ToJSON DependencyType where
  toJSON Build     = String "build"
  toJSON Runtime   = String "runtime"
  toJSON Test      = String "test"
  toJSON Benchmark = String "benchmark"
