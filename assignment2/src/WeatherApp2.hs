module WeatherApp2 where

import Control.Applicative -- imports liftA2
import Exception2 -- your new exception library


{- First define the types for components of our application. This
 - remains the same as in WeatherApp1. -}

type Page = String -- Page is just a type synonym for String

data Weather = Weather { temp :: Int, rain :: Bool }
  deriving (Show)

data User = User { name :: String, identifier :: Int }
  deriving (Show, Eq)


{- Now define the types for our errors. Since Exception2 combines multiple
 - Failure values using the Semigroup instance for the Failure value's type,
 - we can now track an ExceptionLog for each Failure value. Since we define
 - ExceptionLog to be a list, its <> is simply concatenation.-}

data Exception = ServerException | DbException
  deriving (Show, Eq)

type ExceptionLog = [Exception]  -- new


{- Define our "business logic," i.e. domain specific code -}

weatherPage :: User -> Weather -> Page
weatherPage (User name id) (Weather temp rain) =
  "Hello " ++ name ++ "! Today's temp is " ++ show temp ++ " degrees."


{- Lift this function to work on Failing values, representing 
 - either a successful value or an ExceptionLog -}

buildWeatherPage :: Failing ExceptionLog User
                 -> Failing ExceptionLog Weather
                 -> Failing ExceptionLog Page
buildWeatherPage = liftA2 weatherPage


{- Helper functions simulating server and db query results. Note
 - how little needs to be changed. This is the advantage of the 
 - modularity given by our abstractions. -}

badUserAccess :: Failing ExceptionLog User
badUserAccess = undefined -- TODO

goodUserAccess :: Failing ExceptionLog User
goodUserAccess = undefined -- TODO

badWeatherAccess :: Failing ExceptionLog Weather
badWeatherAccess = undefined -- TODO

goodWeatherAccess :: Failing ExceptionLog Weather
goodWeatherAccess = undefined -- TODO


{- You can test out your code in ghci as follows.
 -
 - > :l Exception2 WeatherApp2
 - > buildWeatherPage goodUserAccess goodWeatherAccess
 -}

