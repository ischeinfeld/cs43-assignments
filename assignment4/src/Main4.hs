module Main4 (main4) where

import Control.Monad.Reader.Class -- provides MonadReader typeclass
import Control.Monad.Reader       -- provides MonadIO typeclass
import System.IO (Handle, hPutStrLn, stdout, stderr)
import Data.Time.Clock (UTCTime, getCurrentTime) -- getCurrentTime :: IO UTCTime

import RIO

{- EXERCISE: Now we want to extend the functionality of our program. We want to tell
 - the user the current time. The approach taken here will be improved in the 
 - following exercise. -}

data App = App
  { appName :: String   
  , appHandle :: Handle
  }

main4 :: IO ()
main4 = undefined
-- TODO replicate the behaviour of main3, but display the time between 
-- saying hello and goodbye. This is just a straightforward addition to main3.

{- We also define a helper function `say` -}

say :: String -> RIO App ()
say msg = do
  h <- reader appHandle -- binds a function `appHandle` of the environment
  liftIO $ hPutStrLn h msg

sayTime :: RIO App ()
sayTime = do
  now <- liftIO $ getCurrentTime
  say $ "The time is: " ++ show now

sayHello :: RIO App ()
sayHello = do
  name <- reader appName
  say $ "Hello, " ++ name

sayGoodbye :: RIO App ()
sayGoodbye = do
  name <- reader appName
  say $ "Goodbye, " ++ name
