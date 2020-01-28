module Problem1Spec (main, spec) where

import Test.Hspec -- test framework
import Test.Hspec.Checkers
import Test.QuickCheck hiding (Success, Failure) -- randomized property testing
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

import Problem1

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "cmap" $ do
    it "cmap 0 [1,2,3,4] = [0,0,0,0]" $ do
      cmap 0 [1,2,3,4] `shouldBe` [0,0,0,0]
  testBatch (functor (undefined :: LotsOfPieces (Integer, Integer, Integer)))

arbitrarySizedLotsOfPieces :: Arbitrary a => Int -> Gen (LotsOfPieces a)
arbitrarySizedLotsOfPieces m = do
  v1 <- arbitrary
  v2 <- arbitrary
  if (m <= 0)
    then elements [Gone, Two v1 v2]
    else do
      r1 <- (arbitrarySizedLotsOfPieces (m `div` 2))
      r2 <- (arbitrarySizedLotsOfPieces (m `div` 2))
      r3 <- (arbitrarySizedLotsOfPieces (m `div` 2))
      elements [ Gone
               , Two v1 v2
               , RecTwo v1 v2 r1
               , TreeLike v1 r1 r2
               , TripleSandwich r1 r2 r3 ]

instance Arbitrary a => Arbitrary (LotsOfPieces a) where
  arbitrary = sized arbitrarySizedLotsOfPieces

instance (Eq a) => EqProp (LotsOfPieces a) where
  (=-=) = eq
