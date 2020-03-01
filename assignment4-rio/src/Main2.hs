module Main2 (main2) where

import Control.Monad.Reader.Class -- provides MonadReader typeclass
import Control.Monad.Reader       -- provides MonadIO typeclass

{- EXERCISE: In this exercise, we extend the previous program so that we do not need to
 - explicitly pass around name. We do this by augmenting IO with a configuration
 - environment / value. As we have seen previously, the Reader monad in Haskell
 - allows for this. The Reader type
 -
 -   newtype Reader env a = Reader { runReader :: env -> a }
 -
 - gives rise to a monad instance for `Reader env`, where `env` is the environment
 - type. When you see a reader value `Reader env a`, remember that it simply
 - wraps a function `env -> a`.
 -
 - Here, we work with a new monad built from IO using ReaderT. Recall that 
 - ReaderT augments an existing monad with a reader environment.
 -
 -   newtype ReaderT env m a = ReaderT { runReaderT :: env -> m a }
 -
 - Our core monad will simply be IO wrapped in ReaderT, giving us access to
 - IO operations as well as a configuration environment. 
 -   
 -   newtype RIO env a = RIO { unRIO :: ReaderT env IO a }
 - 
 -}

import RIO -- Read RIO.hs!

{- Note that `RIO env a` wraps `ReaderT env IO a`, which wraps `env -> IO a`.
   Thus, think of a value of type `RIO env a` as a value taking input `env` and
   capable of performing arbitrary IO oprations. This is almost like an impure function! 
   We can run RIO values using
     
     runRIO :: env -> RIO env a -> IO a
     
  -}

main2 :: IO ()
main2 = undefined -- TODO using the function runRIO and do notation, replicate the behavior of main1

sayHello :: RIO String ()
sayHello = do
  name <- ask
  liftIO $ putStrLn $ "Hello, " ++ name

sayGoodbye :: RIO String ()
sayGoodbye = do
  name <- ask
  liftIO $ putStrLn $ "Goodbye, " ++ name

{- While this is complete overkill for such a small program with only one piece
   of data in it's environment, it will become more useful as the environment
   grows in the following exercises. -}
