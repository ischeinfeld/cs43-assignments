{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}

module Parser where

{- This implementation was modified from Stephen Diehl's NanoParsec example
 - here: http://dev.stephendiehl.com/fun/002_parsers.html -}

import Data.Char           
import Control.Applicative  -- provides Applicative and applicative combinators
import Control.Monad        -- provides Monad and monadic combinators

-- First we write our Parser datatype and implement its typeclass instances. 

newtype Parser a = Parser { getParser :: String -> Maybe (a, String) }


{- Instead of defining each instance in the Functor f => Applicative f =>
 - Monad f hierarchy one after the next, we can define Functor
 - and Applicative in terms of Monad since we are writing a Monad instance
 - and Monads are strictly more powerful. -}

instance Functor Parser where
  fmap :: (a -> b) -> Parser a -> Parser b
  fmap f xs = xs >>= return . f

instance Applicative Parser where
  pure :: a -> Parser a
  pure = return

  (<*>) :: Parser (a -> b) -> Parser a -> Parser b
  (<*>) = ap -- defined in Control.Monad, ap = do { x1 <- m1; x2 <- m2; return (x1 x2) }

-- TODO complete the Monad instance for Parser. p >>= f should run parser p on
-- its input, and if a value is parsed we can use f to generate a new parser
-- and run this on the remaining string, returning the result. Review the
-- lecture code if that is helpful.

instance Monad Parser where
  return :: a -> Parser a
  return = undefined

  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  p >>= f = undefined

instance Alternative Parser where -- same as in lecture
  empty :: Parser a
  empty = Parser $ \_ -> Nothing
  
  (<|>) :: Parser a -> Parser a -> Parser a
  p <|> q = Parser $ \s -> case getParser p s of
    Nothing -> getParser q s
    x -> x


-- Now we define some simple parsers.

item :: Parser Char
item = Parser $ \case
  [] -> Nothing
  (x:xs) -> Just (x, xs)

satisfy :: (Char -> Bool) -> Parser Char
satisfy pred = do
  c <- item
  guard $ pred c
  return c

-- And some more parsers!

char :: Char -> Parser Char
char = satisfy . (==)

digit :: Parser Char
digit = satisfy isDigit

natural :: Parser Integer
natural = read <$> some (satisfy isDigit)

string :: String -> Parser String
string [] = return []
string (c:cs) = do
  char c
  string cs
  return (c:cs)

spaces :: Parser String
spaces = many $ char ' '

token :: Parser a -> Parser a
token p = do
  spaces
  a <- p
  spaces
  return a

keyword :: String -> Parser String
keyword s = token (string s)

-- TODO implement a function that takes a parser and returns a new one that
-- first parses whitespace, then '(', then the parser p, then ')', and then some
-- more whitespace, returning the result of p. Use do syntax.

inParens :: Parser a -> Parser a
inParens p = undefined
