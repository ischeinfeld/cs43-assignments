module LSystemSpec (main, spec) where

import qualified Data.Map as M
import Test.Hspec -- test framework
import Test.QuickCheck -- randomized property testing

import LSystem

-- `main` here so module can be run from GHCi
main :: IO ()
main = hspec spec

-- `spec` automatically discovered and tested by Spec.hs
spec :: Spec
spec = do
  describe "readActions" $ do
    -- basic hspec tests
    it "readActions \"DM+-[]012\" == [Draw, Move, ...]" $ do
      (readActions "DM+-[]012") `shouldBe` [Draw, Move, RTurn, LTurn, Mark, Revert,
                                            Constant 0, Constant 1, Constant 2]
  describe "rewriteByMap" $ do
    it "rewriteByMap M.empty == id" $ do
      (rewriteByMap M.empty [Draw, Move, Constant 0]) `shouldBe` [Draw, Move, Constant 0]
    it "rewriteByMap (M.fromList [(Draw, [Draw, Move])]) [Draw] == [Draw, Move]" $ do
      (rewriteByMap (M.fromList [(Draw, [Draw, Move])]) [Draw]) `shouldBe` [Draw, Move]

  describe "generateByMap" $ do
    it "checking 3 generations for a simple RuleMap" $ do
      take 3 lhs `shouldBe` rhs
        where lhs = generateByMap [Draw] (M.fromList [(Draw, [Draw, Move])]) 
              rhs = [[Draw], [Draw, Move], [Draw, Move, Move]]

