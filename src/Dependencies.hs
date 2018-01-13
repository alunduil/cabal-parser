{-# LANGUAGE RecordWildCards #-}

module Dependencies
  (dependencies
  ) where

import           Data.List (nub)
import           Dependency
import           Distribution.Types.Benchmark (Benchmark (benchmarkBuildInfo))
import           Distribution.Types.BuildInfo (BuildInfo (..))
import           Distribution.Types.CondTree (CondBranch (..), CondTree (..))
import           Distribution.Types.Executable (Executable (buildInfo))
import           Distribution.Types.ExeDependency (ExeDependency (ExeDependency))
import           Distribution.Types.GenericPackageDescription (GenericPackageDescription (..))
import           Distribution.Types.Library (Library (libBuildInfo))
import           Distribution.Types.PackageDescription (PackageDescription (..))
import           Distribution.Types.TestSuite (TestSuite (testBuildInfo))
import qualified Distribution.Types.Dependency as Cabal (Dependency (Dependency))

dependencies :: GenericPackageDescription -> [Dependency]
dependencies = nub . deps undefined

class ToDependencies a where
  deps :: DependencyType -> a -> [Dependency]

instance ToDependencies GenericPackageDescription where
  deps _ GenericPackageDescription{..} = deps undefined packageDescription ++
                                         maybe [] (deps Runtime) condLibrary ++
                                         (deps Runtime <$> snd =<< condSubLibraries) ++
                                         (deps Runtime <$> snd =<< condExecutables) ++
                                         (deps Test <$> snd =<< condTestSuites) ++
                                         (deps Benchmark <$> snd =<< condBenchmarks)

instance ToDependencies PackageDescription where
  deps _ PackageDescription{..} = maybe [] (deps Runtime) library ++
                                  (deps Runtime =<< subLibraries) ++
                                  (deps Runtime =<< executables) ++
                                  (deps Runtime =<< testSuites) ++
                                  (deps Runtime =<< benchmarks)

instance (ToDependencies c, ToDependencies a) => ToDependencies (CondTree v c a) where
  deps t CondNode{..} = deps t condTreeData ++
                        deps t condTreeConstraints ++
                        (deps t =<< condTreeComponents)

instance (ToDependencies c, ToDependencies a) => ToDependencies (CondBranch v c a) where
  deps t CondBranch{..} = deps t condBranchIfTrue ++
                          maybe [] (deps t) condBranchIfFalse

instance (ToDependency a) => ToDependencies [a] where
  deps t = fmap $ dep t

instance ToDependencies Library where
  deps _ = deps Runtime . libBuildInfo

instance ToDependencies Executable where
  deps _ = deps Runtime . buildInfo

instance ToDependencies TestSuite where
  deps _ = deps Test . testBuildInfo

instance ToDependencies Benchmark where
  deps _ = deps Benchmark . benchmarkBuildInfo

instance ToDependencies BuildInfo where
  deps t BuildInfo{..} = (dep t <$> buildToolDepends) ++
                         (dep t <$> targetBuildDepends)

class ToDependency a where
  dep :: DependencyType -> a -> Dependency

instance ToDependency Cabal.Dependency where
  dep t (Cabal.Dependency n v) = Dependency n v t

instance ToDependency ExeDependency where
  dep _ (ExeDependency n _ v) = Dependency n v Build
