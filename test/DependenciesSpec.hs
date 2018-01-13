{-# OPTIONS_GHC -fno-warn-deprecations #-}

{-# LANGUAGE OverloadedStrings #-}

module DependenciesSpec (main, spec) where

import Dependencies
import Dependency
import Distribution.PackageDescription.Parse (readGenericPackageDescription)
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
         dependencies d `shouldBe` [ Dependency "aeson" (WildcardVersion $ mkVersion [1,1]) Runtime
                                   , Dependency "base" (IntersectVersionRanges (UnionVersionRanges (ThisVersion $ mkVersion [4,9]) (LaterVersion $ mkVersion [4,9])) (EarlierVersion $ mkVersion [4,10])) Runtime
                                   , Dependency "Cabal" (WildcardVersion $ mkVersion [2,0]) Runtime
                                   , Dependency "envy" (WildcardVersion $ mkVersion [1,3]) Runtime
                                   , Dependency "servant-server" (WildcardVersion $ mkVersion [0,11]) Runtime
                                   , Dependency "text" (WildcardVersion $ mkVersion [1,2]) Runtime
                                   , Dependency "utf8-string" (WildcardVersion $ mkVersion [1,0]) Runtime
                                   , Dependency "warp" (WildcardVersion $ mkVersion [3,2]) Runtime
                                   , Dependency "hspec-discover" (WildcardVersion $ mkVersion [2,4]) Build
                                   , Dependency "aeson" (WildcardVersion $ mkVersion [1,1]) Test
                                   , Dependency "base" (IntersectVersionRanges (UnionVersionRanges (ThisVersion $ mkVersion [4,9]) (LaterVersion $ mkVersion [4,9])) (EarlierVersion $ mkVersion [4,10])) Test
                                   , Dependency "Cabal" (WildcardVersion $ mkVersion [2,0]) Test
                                   , Dependency "hspec" (WildcardVersion $ mkVersion [2,4]) Test
                                   , Dependency "text" (WildcardVersion $ mkVersion [1,2]) Test
                                   ]
