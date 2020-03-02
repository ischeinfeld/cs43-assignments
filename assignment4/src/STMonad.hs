module STMonad where

import Control.Monad.ST
import Data.STRef
import Control.Monad

sumST :: Num a => [a] -> a
sumST xs = runST $ do
  n <- newSTRef 0

  forM_ xs $ undefined

  readSTRef n

foldlST :: (a -> b -> a) -> a -> [b] -> a
foldlST f acc xs = undefined

-- Might be useful for the collatz example
-- from Control.Monad.Loops.
whileM_ :: (Monad m) => m Bool -> m a -> m ()
whileM_ p f = go
    where go = do x <- p
                  if x
                     then f >> go
                     else return ()

collatz :: Integer -> Integer
collatz n | n > 0 = undefined
          | otherwise = error "n must be positive"
