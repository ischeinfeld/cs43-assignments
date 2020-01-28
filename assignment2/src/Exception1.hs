module Exception1 where

{- This module provides a type Failing representing a possibly failed
 - computation with either a Failure error value or a Success value. Note
 - that Failing is identical to Either up to renaming. -}

data Failing a b = Failure a | Success b
  deriving (Show, Eq)

{- (Failing a) has a Functor instance (the same as (Either a)). This allows us to apply
 - functions to possibly failed values. E.g.
 -
 - > fmap (+ 1) (Failure "No value") = Failure "No value"
 - > fmap (+ 1) (Success 3) = Success 4
 -}

instance Functor (Failing a) where
  fmap f (Success x) = Success (f x)
  fmap f (Failure y) = (Failure y) -- note fmap f y = y work because types

{- (Failing a) also has an Applicative instance. Here, we implement the Applicative
 - instance to propagate the first error in an applicative computation. For
 - example, (here the same pattern is written in four different ways, showing
 - the results for different values)
 -
 - (+) <$> (Succes 1) <*> (Success 2) = Success 3
 - fmap (+) (Succes 1) <*> (Failure "No v2") = Failure "No v2"
 - pure (+) <*> (Failure "No v1") <*> (Success 2) = Failure "No v1"
 - liftA2 (+) (Failure "No v1") (Failure "No v2") = Failure "No v1"
 -}

instance Applicative (Failing a) where
  pure = Success
  
  (Failure e1) <*> _ = Failure e1 -- first Failure takes precedence
  _ <*> (Failure e2) = Failure e2
  (Success f) <*> (Success x) = Success $ f x
