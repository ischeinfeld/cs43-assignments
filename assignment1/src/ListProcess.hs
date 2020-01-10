module ListProcess (mymap, myfilter)  where

-- TODO implement map in terms of foldr
mymap :: (a -> b) -> [a] -> [b]
mymap f = foldr undefined undefined

-- TODO implement filter in terms of foldr
myfilter :: (a -> Bool) -> [a] -> [a]
myfilter p = foldr undefined undefined
