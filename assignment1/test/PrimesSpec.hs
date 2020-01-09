module PrimesSpec (main, spec) where

import Test.Hspec -- test framework
import Test.QuickCheck -- randomized property testing

import Primes

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "isPrime" $ do
    it "map isPrime [1..10] == [False, True, True, ...]" $ do
      (map isPrime [1..10]) `shouldBe` [ False, True, True, False, True
                                       , False, True, False, False, False ]
  describe "primes" $ do
    it "take 6 primes == [2,3,5,7,11,13]" $ do
      take 6 primes `shouldBe` [2,3,5,7,11,13]

  describe "primesSieve" $ do
    it "take 6 primesSieve == [2,3,5,7,11,13]" $ do
      take 6 primesSieve `shouldBe` [2,3,5,7,11,13]
