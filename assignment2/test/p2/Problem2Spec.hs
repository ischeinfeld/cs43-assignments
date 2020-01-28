module Problem2Spec (main, spec) where

import Test.Hspec -- test framework
import Test.Hspec.Checkers
import Test.QuickCheck hiding (Success, Failure) -- randomized property testing
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

import Problem2

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "nats" $ do
    it "first 10 values correct" $ do
      (take 10 $ streamToList nats) `shouldBe` [0..9]
  describe "fibs" $ do
    it "first 10 values correct" $ do
      (take 10 $ streamToList fibs) `shouldBe` [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
