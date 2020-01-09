module ListProcessSpec (main, spec) where

import Test.Hspec -- test framework
import Test.QuickCheck -- randomized property testing

import ListProcess

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "mymap" $ do
    -- basic hspec tests
    it "mymap not [True, False] == [False, True]" $ do
      (mymap not [True, False]) `shouldBe` [False, True]
    it "mymap (+ 1) [1..10] == [2..11]" $ do
      (mymap (+ 1) [1..10]) `shouldBe` [2..11]

    -- randomized property testing using QuickCheck
    it "identity" $ property mymapId
    it "composition" $ property mymapComp
    it "is length preserving" $ property mymapLenPres

  -- properties can also be written inline as lambdas
  describe "myfilter" $ do
    it "idempotent" $ property $ -- filtering by predicate once same as twice
      \lst -> myfilterPos lst == (myfilterPos . myfilterPos) lst
    it "myfilter (const True) lst == lst" $ property $
      \lst -> myfilter (const True) lst == (lst :: [Int])
    it "myfilter (const False) lst == []" $ property $
      \lst -> myfilter (const False) lst == ([] :: [Int])
    where
      myfilterPos = myfilter (> (0 :: Int))

-- properties to test, with concrete types so QuickCheck can
-- generate random examples for testing

mymapId :: [Int] -> Bool
mymapId lst = lst == mymap id lst

mymapComp :: [Int] -> Bool
mymapComp lst = mymap ((+ 1) . (* 2)) lst == mymap (+ 1) (mymap (* 2) lst)

mymapLenPres :: [Int] -> Bool
mymapLenPres lst = length lst == length (mymap (+ 1) lst)

