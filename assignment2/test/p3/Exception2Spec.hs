module Exception2Spec (main, spec) where

import Test.Hspec -- test framework
import Test.Hspec.Checkers
import Test.QuickCheck hiding (Success, Failure)
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

import Exception2

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  testBatch (applicative (undefined :: Failing String (Integer, Integer, Integer)))


instance (Arbitrary a, Arbitrary b) => Arbitrary (Failing a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [Success a, Failure b]

instance (Eq a, Eq b) => EqProp (Failing a b) where 
  (=-=) = eq
