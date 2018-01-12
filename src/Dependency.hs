{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Dependency
  ( Dependency
  , dependencies
  ) where

import Data.Aeson ((.=), object, Value (String), ToJSON (toJSON))
import Distribution.Simple.BuildToolDepends (getAllToolDependencies)
import Distribution.Types.Benchmark (Benchmark (benchmarkBuildInfo))
import Distribution.Types.BuildInfo (BuildInfo (targetBuildDepends))
import Distribution.Types.Executable (Executable (buildInfo))
import Distribution.Types.Library (Library (libBuildInfo))
import Distribution.Types.PackageDescription (allLibraries, PackageDescription (benchmarks, executables, testSuites))
import Distribution.Types.PackageName (PackageName)
import Distribution.Types.TestSuite (TestSuite (testBuildInfo))
import Distribution.Version (VersionRange)

import qualified Distribution.Types.Dependency as Cabal (Dependency (Dependency))
import qualified Distribution.Types.ExeDependency as Cabal (ExeDependency (ExeDependency))

import Distribution.Types.PackageName.JSON ()
import Distribution.Version.JSON ()

data Dependency = Dependency
  { dName        :: PackageName
  , dRequirement :: VersionRange
  , dType        :: DependencyType
  }

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

instance ToJSON DependencyType where
  toJSON Build     = String "build"
  toJSON Runtime   = String "runtime"
  toJSON Test      = String "test"
  toJSON Benchmark = String "benchmark"

dependencies :: PackageDescription -> [Dependency]
dependencies d = (dependencies' Runtime <$> libBuildInfo =<< allLibraries d) ++
                 (dependencies' Runtime <$> buildInfo =<< executables d) ++
                 (dependencies' Test <$> testBuildInfo =<< testSuites d) ++
                 (dependencies' Benchmark <$> benchmarkBuildInfo =<< benchmarks d)

  where dependencies' t b = (fromCabalExeDependency <$> getAllToolDependencies d b) ++
                            (fromCabalDependency t <$> targetBuildDepends b)

fromCabalExeDependency :: Cabal.ExeDependency -> Dependency
fromCabalExeDependency (Cabal.ExeDependency n _ v) = Dependency n v Build

fromCabalDependency :: DependencyType -> Cabal.Dependency -> Dependency
fromCabalDependency t (Cabal.Dependency n v) = Dependency n v t
