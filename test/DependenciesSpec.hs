{-# OPTIONS_GHC -fno-warn-deprecations #-}

{-# LANGUAGE OverloadedStrings #-}

module DependenciesSpec (main, spec) where

import Dependencies
import Dependency
import Distribution.PackageDescription.Parsec (readGenericPackageDescription)
import Distribution.Types.PackageName (mkPackageName)
import Distribution.Verbosity (silent)
import Distribution.Version
import Test.Hspec (describe, hspec, it, shouldBe, Spec)

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "dependencies" $
    it "extracts dependencies from 'cabal-parser.cabal'" $
      do d <- readGenericPackageDescription silent "test/examples/cabal-parser.cabal"
         dependencies d `shouldBe` [ Dependency (mkPackageName "aeson") (WildcardVersion $ mkVersion [1,1]) Runtime
                                   , Dependency (mkPackageName "base") (IntersectVersionRanges (OrLaterVersion $ mkVersion [4,9]) (EarlierVersion $ mkVersion [4,10])) Runtime
                                   , Dependency (mkPackageName "Cabal") (WildcardVersion $ mkVersion [2,0]) Runtime
                                   , Dependency (mkPackageName "envy") (WildcardVersion $ mkVersion [1,3]) Runtime
                                   , Dependency (mkPackageName "servant-server") (WildcardVersion $ mkVersion [0,11]) Runtime
                                   , Dependency (mkPackageName "text") (WildcardVersion $ mkVersion [1,2]) Runtime
                                   , Dependency (mkPackageName "utf8-string") (WildcardVersion $ mkVersion [1,0]) Runtime
                                   , Dependency (mkPackageName "warp") (WildcardVersion $ mkVersion [3,2]) Runtime
                                   , Dependency (mkPackageName "hspec-discover") (WildcardVersion $ mkVersion [2,4]) Build
                                   , Dependency (mkPackageName "aeson") (WildcardVersion $ mkVersion [1,1]) Test
                                   , Dependency (mkPackageName "base") (IntersectVersionRanges (OrLaterVersion $ mkVersion [4,9]) (EarlierVersion $ mkVersion [4,10])) Test
                                   , Dependency (mkPackageName "Cabal") (WildcardVersion $ mkVersion [2,0]) Test
                                   , Dependency (mkPackageName "hspec") (WildcardVersion $ mkVersion [2,4]) Test
                                   , Dependency (mkPackageName "text") (WildcardVersion $ mkVersion [1,2]) Test
                                   ]
