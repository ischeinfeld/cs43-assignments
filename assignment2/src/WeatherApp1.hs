module WeatherApp1 where

import Control.Applicative -- imports liftA2
import Exception1 -- our exception library


{- First define the types for components of our application -}

type Page = String -- Page is just a type synonym for String

data Weather = Weather { temp :: Int, rain :: Bool }
  deriving (Show)

data User = User { name :: String, identifier :: Int }
  deriving (Show, Eq)


{- Now define the type for our errors -}

data Exception = ServerException | DbException
  deriving (Show, Eq)


{- Define our "business logic," i.e. domain specific code -}

weatherPage :: User -> Weather -> Page
weatherPage (User name id) (Weather temp rain) =
  "Hello " ++ name ++ "! Today's temp is " ++ show temp ++ " degrees."


{- Lift this function to work on Failing values, representing 
 - either a successful value or an ExceptionLog -}

buildWeatherPage :: Failing Exception User
                 -> Failing Exception Weather
                 -> Failing Exception Page
buildWeatherPage = liftA2 weatherPage


{- Helper functions simulating server and db query results -}

badUserAccess :: Failing Exception User
badUserAccess = Failure ServerException

goodUserAccess :: Failing Exception User
goodUserAccess = Success $ User "Name" 123456789

badWeatherAccess :: Failing Exception Weather
badWeatherAccess = Failure DbException

goodWeatherAccess :: Failing Exception Weather
goodWeatherAccess = Success $ Weather 60 False


{- You can use the code above as follows in ghci as follows.
 -
 - > :l Exception1 WeatherApp1
 - > buildWeatherPage goodUserAccess goodWeatherAccess
 - > buildWeatherPage badUserAccess goodWeatherAccess
 -
 - Note that the following code returns the exception from 
 - badUserAccess, ignoring that from baWeatherAcces
 -}
