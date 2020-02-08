{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-} -- allows deriving for GADTs and existential types
{-# LANGUAGE ExistentialQuantification #-}

{- One of the primary uses of GADTs is modelling typed embedded languages. In
 - this module, we define a simple calculator-like language that embeds its own
 - type system in Haskell's. -}

module Language where

-- Define the datatype for our language using GADT syntax. 

data Term a where
  B :: Bool -> Term Bool
  N :: Integer -> Term Integer
  Not :: Term Bool -> Term Bool
  And :: Term Bool -> Term Bool -> Term Bool
  Add :: Term Integer -> Term Integer -> Term Integer
  Equal :: Term Integer -> Term Integer -> Term Bool
  IfThenElse :: Term Bool -> Term a -> Term a -> Term a

deriving instance Show (Term a) -- deriving for GADT using StandaloneDeriving

{- The evaluation function for our (Term a) type. Note that the types guarentee
 - that a (Term a) will always evaluate to a value of type a. This is the power
 - of GADTs, since for example pattern matching with B refines the type of b to
 - Bool from any a, and thus eval (B b) must return a Bool. We create a
 - typeclass so that we can overload eval below to work on a different type
 - (Expr). -}

-- TODO write the evaluation function, pattern matching on all the constructors

eval :: Term a -> a
eval (B b) = undefined
eval (N n) = undefined
eval (Not b) = undefined
eval (And b1 b2) = undefined
eval (Add n1 n2) = undefined
eval (Equal e1 e2) = undefined
eval (IfThenElse p e1 e2) = undefined


{- We will also implement an expression type Expr hiding the type `a` of the
 - value represented by a `Term a`. We can do so using existential
 - quantification. This will be useful when we want to parse String -> Term a
 - but cannot do so since we don't know ahead of time weather `a` is Bool or 
 - Integer. Thus, we can write a function String -> Expr. -}

data Expr = forall a. (Show a) => Expr (Term a)

deriving instance Show Expr -- Deriving for ex. quantified type using StandaloneDeriving
                            -- Note that this works only because (Term a) has a
                            -- show instance already.

{- We cannot write an evaluation function Expr -> a, since we do not know what
 - type `a` of the evaluated Term to return. However, since we know `a` is in Show,
 - we have the function show :: a -> String and can write a function Expr ->
 - String. -}

answer :: Expr -> String
answer (Expr t) = show $ eval t
