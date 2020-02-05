{-# LANGUAGE DeriveFunctor #-}

module Problem1 where

-- TODO write the function (<$) in terms of fmap
cmap :: Functor f => a -> f b -> f a
cmap = undefined

-- TODO comment your answers to whether Functor instances are valid


data LotsOfPieces a =
    Gone
  | Two a a 
  | RecTwo a a (LotsOfPieces a)
  | TreeLike a (LotsOfPieces a) (LotsOfPieces a)
  | TripleSandwich (LotsOfPieces a) (LotsOfPieces a) (LotsOfPieces a)
  deriving (Show, Eq)

-- TODO write a functor instance for LotsOfPieces
instance Functor LotsOfPieces where
