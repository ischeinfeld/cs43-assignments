module Main5 (main5) where

import Control.Monad.Reader.Class -- provides MonadReader typeclass
import Control.Monad.Reader       -- provides MonadIO typeclass
import System.IO (Handle, hPutStrLn, stdout, stderr)
import Data.Time.Clock (UTCTime, getCurrentTime) -- getCurrentTime :: IO UTCTime

import RIO

{- EXERCISE: One drawback of the implementation in Main4 is that some functions 
 - do not have as general a type as possible. For example, sayTime requires an 
 - `App` environment while it only uses the `appHandle` field. For our small
 - example this is not a problem, but if we wanted to reuse code between
 - different configuration types this would require a separate function for
 - each. This can be remedies by the following approach.
 -
 - For each functional subset of the configuration environment, define a
 - typeclass of accessor functions. Then, write functions that are polymorphic
 - over the environment type when possible, restricting to only the necessary 
 - fields using the provided typeclasses. This also makes clear from the type
 - what values in the environment are depended upon. -} 

data App = App
  { appName :: String   
  , appHandle :: Handle
  }

-- typeclass for App environments containing a Handle

class HasHandle env where 
  getHandle :: env -> Handle

instance HasHandle App where -- an instance for our App configuration
  getHandle = appHandle

-- typeclass for App environments containing a name

class HasName env where
  getName :: env -> String

instance HasName App where
  getName = appName
  

main5 :: IO ()
main5 = undefined
-- TODO replicate the behaviour of main4. Code should be identical.

say :: HasHandle env => String -> RIO env ()
say msg = do
  h <- reader getHandle -- uses the function from our new typeclass
  liftIO $ hPutStrLn h msg

sayTime :: HasHandle env => RIO env ()
sayTime = do
  now <- liftIO $ getCurrentTime
  say $ "The time is: " ++ show now -- `say` requires the HasHandle constraint

sayHello :: (HasHandle env, HasName env) => RIO env ()
sayHello = undefined -- TODO make the necessary change from Main4 to fit the type

sayGoodbye :: (HasHandle env, HasName env) => RIO env ()
sayGoodbye = undefined -- TODO make the necessary change from Main4 to fit the type
