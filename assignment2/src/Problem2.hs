{-# LANGUAGE DeriveFunctor #-}

module Problem2 where


-- TODO Write a Stream type where a (Stream a) represents an infinite stream
-- of values of type a. It should have a single recursive constructor.

data Stream a

-- TODO write the Functor instance for Stream


-- TODO Write the following function to convert a stream to an infinite list

streamToList :: Stream a -> [a]
streamToList = undefined


-- TODO Write a Show instance for Stream that shows the first 10 elements


-- TODO Write the following function to generate a stream from an
-- initial starting value and a generating function

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed = undefined


-- TODO Define a stream of natural numbers

nats :: Stream Integer
nats = undefined


-- TODO Define a stream of fibonacci numbers 0, 1, 1, 2, 3, 5, ...

fibs :: Stream Integer
fibs = undefined
