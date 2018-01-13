{-# OPTIONS_GHC -fno-warn-deprecations #-}

module Distribution.Version.JSONSpec (main, spec) where

import Data.Aeson (encode)
import Data.ByteString.Lazy.Char8 (pack)
import Distribution.Version
import Distribution.Version.JSON ()
import Test.Hspec (context, describe, hspec, it, shouldBe, Spec)

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "ToJSON" $
    context "encodes examples" $
      do let s = "\"==1.1.*\"" in it s $ encode (WildcardVersion $ mkVersion [1,1]) `shouldBe` pack s
         let s = "\">=4.9 && <4.11\"" in it s $ encode (IntersectVersionRanges (UnionVersionRanges (ThisVersion $ mkVersion [4,9]) (LaterVersion $ mkVersion [4,9])) (EarlierVersion $ mkVersion [4,11])) `shouldBe` pack s
         let s = "\"*\"" in it s $ encode anyVersion `shouldBe` pack s
