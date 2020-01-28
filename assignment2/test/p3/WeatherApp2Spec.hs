module WeatherApp2Spec (main, spec) where

import Test.Hspec -- test framework
import Test.QuickCheck hiding (Success, Failure) -- randomized property testing

import Exception2
import WeatherApp2

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "badUserAccess" $ do
    it "is a Failure" $ do
      case badUserAccess of
        Failure x -> True
        Success y -> False
  describe "goodUserAccess" $ do
    it "is a Success" $ do
      case goodUserAccess of
        Failure x -> False
        Success y -> True
  describe "badWeatherAccess" $ do
    it "is a Failure" $ do
      case badUserAccess of
        Failure x -> True
        Success y -> False
  describe "goodWeatherAccess" $ do
    it "is a Success" $ do
      case goodUserAccess of
        Failure x -> False
        Success y -> True

