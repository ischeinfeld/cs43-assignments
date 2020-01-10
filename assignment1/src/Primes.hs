module Primes where

-- TODO tests whether an integer is prime
isPrime :: Int -> Bool
isPrime n = undefined

-- TODO infinite list of primes
primes = undefined

-- TODO infinite list of primes, computed using Sieve of Eratosthenes
primesSieve = sieve [2..]
  where sieve (x:xs) = undefined
