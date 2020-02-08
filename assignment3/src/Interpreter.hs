{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-} -- allows deriving for GADTs and existential types
{-# LANGUAGE ExistentialQuantification #-}

module Interpreter where

import Control.Applicative  -- provides Applicative and applicative combinators
import Control.Monad        -- provides Monad and monadic combinators

import Parser
import Language


-- We begin the parser by writing parsers for terms of a given type.

bP :: Parser (Term Bool)
bP = B <$> (token true <|> token false)
  where true = string "True" *> return True
        false = string "False" *> return False
  
nP :: Parser (Term Integer)
nP = token (N <$> natural)

notP :: Parser (Term Bool)
notP = keyword "not" *> (Not <$> bTermP)

andP :: Parser (Term Bool)
andP = keyword "&" *> (And <$> bTermP <*> bTermP)

-- TODO write the following parser using + as the operator keyword

addP :: Parser (Term Integer)
addP = undefined

equalP :: Parser (Term Bool)
equalP = keyword "=" *> (Equal <$> nTermP <*> nTermP)


{- The if-then-else expression gives a bit more difficulty, since it's return
 - type depends on the parsed sub-exprssions. One way to handle this is to
 - simply write two parsers, one for each return type. Another, which we take
 - here, is to write a parser parameterized over expression parsers.-}

ifThenElse :: Parser (Term a) -> Parser (Term a)
ifThenElse exprP = do
  keyword "if"
  b <- bTermP
  keyword "then"
  e1 <- exprP
  keyword "else"
  e2 <- exprP
  return $ IfThenElse b e1 e2


-- We can now write parsers for arbitary expressions of a given type

bTermP :: Parser (Term Bool)
bTermP = bP <|> inParens (bP <|> notP <|> andP <|> equalP <|> ifThenElse bTermP)

-- TODO complete the following parser, following the pattern of the one above

nTermP :: Parser (Term Integer)
nTermP = undefined

{- Finally, we want to write a parser for an arbitary expression in our
 - language. Since this parser must be able to parse values of type Term Bool
 - and of type Term Integer, we use the existential type Expr wrapping a (Term a). -}

exprP :: Parser Expr
exprP = (Expr <$> bTermP) <|> (Expr <$> nTermP) -- why not Expr <$> (bTermP <|> nTermP)?

parse :: String -> Maybe Expr
parse = (fmap fst) . (getParser exprP)

calculate :: String -> String
calculate s = case parse s of
  Nothing -> "Invalid Expression"
  Just e  -> answer e
