module Primes where

-- tests whether an integer is prime
isPrime :: Int -> Bool
isPrime n = undefined

-- infinite list of primes
primes = undefined

-- infinite list of primes, computed using Sieve of Eratosthenes
primesSieve = sieve [2..]
  where sieve (x:xs) = undefined
