module Exception2 where

import Data.Semigroup -- provides the Semigroup typeclass

{- This module provides a type Failing representing a possibly failed
 - computation with either a Failure error value or Success value.
 - Note that the Failure value need not be a single "error," for example
 - it could be an error log. -}

data Failing a b = Failure a | Success b
  deriving (Show, Eq)

{- (Failing a) has a functor instance. This must be the same as that in
 - Exception1, since Functor instances are unique. -}

instance Functor (Failing a) where
  fmap f (Success x) = Success (f x)
  fmap f (Failure y) = (Failure y)


{- (Failing a) also has an Applicative instance. In this module, you 
 - should implement a different instance of Applicative, similar to that in
 - Exception1 except that it handles failures by propagating a failure in one
 - argument and combining failures in both arguments using <>. You will need a
 - typeclass constraint on the error type in the Applicative instance.-}

-- TODO write Applicative instance for (Failing a)

instance Applicative (Failing a) where
  pure = undefined
  (<*>) = undefined
