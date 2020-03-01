{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module RIO where

import Control.Monad.Reader

newtype RIO env a = RIO { unRIO :: ReaderT env IO a }
  deriving ( Functor
           , Applicative
           , Monad
           , MonadIO -- provides `liftIO`, to lift IO actions into the RIO monad
           , MonadReader env -- provides `ask` and `reader`, to access environment in RIO
           )

{- The `MonadIO` and `MonadReader env` instances for RIO mean we can write code
 - like this:
 -   do
 -     env <- ask -- binds the environment value to env
 -     v <- reader getVFromEnv -- binds a function of the environment to v
 -     liftIO $ putStrLn (show v) -- lifts an IO action to an RIO action -}

runRIO :: env -> RIO env a -> IO a
runRIO env (RIO (ReaderT f)) = liftIO (f env)
