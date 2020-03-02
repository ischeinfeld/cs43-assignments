{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}

module Main6 (main6) where

import Control.Monad.Reader.Class -- provides MonadReader typeclass
import Control.Monad.Reader       -- provides MonadIO typeclass
import System.IO (Handle, hPutStrLn, stdout, stderr)
import Data.Time.Clock (UTCTime, getCurrentTime) -- getCurrentTime :: IO UTCTime
import GHC.TypeLits
import GHC.TypeNats
import GHC.OverloadedLabels
import SuperRecord

import RIO

{- EXERCISE: One drawback of the implementation in Main5 is the boilerplate
 - necessary to define the Has* typeclasses and instances. In this exercise, 
 - we replace our App record with anonymous records provided by the superrecord
 - package. This is not a standard Haskell pattern, but one among a number of 
 - recent attempts to create composable record types. If you want to know more
 - about superrecord than is necessary for this exercise, see 
 -   
 -   https://www.athiemann.net/2017/07/02/superrecord.html
 -
 - We will only use the following features. First, a record can be build up
 - as follows
 -
 -   record = #field1 := value1
 -          & #field2 := value2
 -          & #field3 := value3
 -          & rnil
 -
 - where this record has type (for value1 :: Type1, etc.)
 -
 -   record :: Rec '["field1" := Type1, "field2" := Type2, ..] 
 -
 - Thus `Rec` contains a type-level list of field-type pairs. If a record
 - has a field "field" of type Type, then it can be accessed as follows.
 -
 -   (get #field record) :: Type 
 -
 - You can constrain a record to have a field with a given Type
 - using the `Has` constraint
 -
 -   Has "field" r Type => type containing `Rec r`
 -
 - where `r` is the type-level list of records. -} 

main6 :: IO ()
main6 = undefined -- TODO replicate the behaviour of main4/main5, using `app`.

say :: Has "handle" r Handle => String -> RIO (Rec r) ()
say msg = do
  h <- reader (get #handle) 
  liftIO $ hPutStrLn h msg

sayTime :: Has "handle" r Handle => RIO (Rec r) ()
sayTime = do
  now <- liftIO $ getCurrentTime
  say $ "The time is: " ++ show now -- `say` requires the Has "handle" r Handle constraint

sayHello :: (Has "handle" r Handle, Has "name" r String) => RIO (Rec r) ()
sayHello = undefined -- TODO make the necessary change from Main5 to fit the type

sayGoodbye :: (Has "handle" r Handle, Has "name" r String) => RIO (Rec r) ()
sayGoodbye = undefined -- TODO make the necessary change from Main5 to fit the type
