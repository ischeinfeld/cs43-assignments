{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

module Main where

import Diagrams.Prelude hiding ((<>), option, value)
import Diagrams.Backend.CmdLine
import Diagrams.Backend.Rasterific.CmdLine
import Diagrams.TwoD.Path.LSystem hiding (generations)
import Diagrams.Angle
import Options.Applicative
import qualified Data.Map as M

import LSystem 


-- Translates actions from our Action type defined in the
-- LSystem module to the internal Diagrams LSystem commands,
-- of which we have only defined a subset.

translateAction :: Action -> Symbol n
translateAction action = case action of
  Draw -> F
  Move -> G
  RTurn -> Plus
  LTurn -> Minus
  Mark -> Push
  Revert -> Pop
  Constant n -> X n


-- Executes a list of actions with a given turn angle, returning the diagram
-- this generates.

drawActions :: Double -> [Action] -> Diagram B
drawActions degrees actions =
  lSystemDiagram 0 (degrees @@ deg) (map translateAction actions) M.empty


-- Take a list of generations and draws the `niter` generation as a diagram

draw :: [[Action]] -> Int -> Double -> Diagram B
draw generations niter degrees = format $ drawActions degrees (generations !! niter)
  where format = (bgFrame 0.1 white) . (rotateBy (1/4))
        background = bgFrame 0.1 white
        rotateUp = rotateBy (1/4)


-- mainWith automatically generates a program that parses
-- an Int and Double from the command line. Once you are done completing the
-- code in LSystem, you can replace the first main definition with the second
-- to draw a different diagram.

main = mainWith (draw $ generate [Draw] rules1)
-- main = mainWith (draw $ generateByMap [Constant 0] ruleMap1)
