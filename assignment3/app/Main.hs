module Main where

import System.IO -- provides buffer stdout
import Control.Monad
import Interpreter

main :: IO ()
main = forever $ do
  putStr "> "
  hFlush stdout -- flushes buffer so that prompt renders immediately
  a <- getLine
  putStrLn $ calculate a
