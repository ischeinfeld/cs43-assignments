module Main3 (main3) where

import Control.Monad.Reader.Class -- provides MonadReader typeclass
import Control.Monad.Reader       -- provides MonadIO typeclass
import System.IO (Handle, hPutStrLn, stdout, stderr)

import RIO

{- EXERCISE: In this exercise, we extend our app to allow a configurable output stream.
 - The values
 -   `stdout, stderr :: Handle`
 - can be passed to 
 -   `hPutStrLn :: Handle -> String -> IO ()
 - to output text to either stdout or stderr. We can store the correct output
 - handle in our configuration environment, which we now provide with its own
 - datatype. -}

data App = App
  { appName :: String   -- record syntax defined accessor functions
  , appHandle :: Handle
  }

main3 :: IO ()
main3 = undefined
-- TODO replicate the behaviour of main1/main2, by defining a value of type
-- App and then using runRIO

{- We also define a helper function `say` -}

say :: String -> RIO App ()
say msg = do
  h <- reader appHandle -- binds a function `appHandle` of the environment
  liftIO $ hPutStrLn h msg

sayHello :: RIO App ()
sayHello = do
  name <- reader appName
  say $ "Hello, " ++ name

sayGoodbye :: RIO App ()
sayGoodbye = do
  name <- reader appName
  say $ "Goodbye, " ++ name
