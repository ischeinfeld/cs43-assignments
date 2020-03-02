module Main1 (main1) where

-- This series of exercises is based on a tutorial from FPComplete. Source in solutions.

{- EXERCISE: We begin with a very simple program using IO. To use the functions
 - from Main1 in ghci, type
 -   > :l Main1
 - This is necessary since modules export overlapping names. Then, you can run
 -   > main1
 -   > sayHello "Alice"
 - Try running main1 in ghci. -}

main1 :: IO ()
main1 = do
  let name = "Alice"
  sayHello name
  sayGoodbye name

sayHello :: String -> IO ()
sayHello name = putStrLn $ "Hello, " ++ name

sayGoodbye :: String -> IO ()
sayGoodbye name = putStrLn $ "Goodbye, " ++ name

{- In the next exercise, we extend this program so that we do not need to
 - explicitly pass around name. -}
