{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE ExistentialQuantification #-}

{- One use for existentially-quantified types is in module-level information
 - hiding. In this module, we define a Shape datatype using existential
 - quantification to generalize over various concrete shapes while hiding their
 - individual representations. The export list provided in the module
 - declaration provides the IsShape typeclass with all it's functions, the Shape
 - type (but not it's constructors), and the three functions circle, rectangle,
 - and square for constructing values of type Shape. -}

module Problem1 ( IsShape(..)
                , Shape
                , circle
                , rectangle
                , square ) where

-- Typeclass representing operations on shapes. These are all the functions we
-- want to provide for our Shape datatype.

class IsShape a where
   perimeter :: a -> Double
   area      :: a -> Double


-- We define some basic datatypes for concrete shapes.

data Circle    = Circle    Double
data Rectangle = Rectangle Double Double
data Square    = Square    Double


-- And we make all of them instances of our IsShape typeclass

instance IsShape Circle where
  perimeter (Circle r) = 2 * pi * r
  area      (Circle r) = pi * r * r

instance IsShape Rectangle where
  perimeter (Rectangle x y) = 2*(x + y)
  area      (Rectangle x y) = x * y

instance IsShape Square where
  perimeter (Square s) = 4*s
  area      (Square s) = s*s


{- Now suppose we want to let people create shapes and use the operations
 - we have provided in the IsShape typeclass, but we want to hide all the
 - implementation details of Circle, Rectangle, etc. We can do so using
 - existential quantification: -}

data Shape = forall a. IsShape a => Shape a

{- The Shape type uses existential quantification to "hide" the boxed type. Now
 - values unpacked by pattern matching on the Shape constructor can only be
 - passed to functions in the IsShape typeclass, since all we know about the type
 - of the boxed value is that it is in that typeclass. If we had written
 -       data Shape a = Shape a
 - then a value of type (Shape a) would carry the type of the boxed value in the
 - type variable a. However, that is all we need to implement an IsShape
 - instance for our new Shape type. -}

-- TODO complete the following instance

instance IsShape Shape where
  perimeter :: Shape -> Double
  perimeter = undefined

  area :: Shape -> Double
  area = undefined


{- To completely hide the concrete shapes Circle, etc. outside this module, we
 - need to write constructors for each shape that return Shape values instead of
 - values of their respective types. Note in the module declaration that the
 - only types and functions provided by our module are these constructor
 - functions, the Shape datatype, and the IsShape typeclass and its functions.-}

-- TODO complete the following three functions

circle :: Double -> Shape
circle = undefined

rectangle :: Double -> Double -> Shape
rectangle = undefined

square :: Double -> Shape
square = undefined


-- Importantly, all Shape values have the same type, no matter the type of the
-- value they contain. Thus, we can for example define a list of different
-- shapes.

someShapes :: [Shape]
someShapes = [circle 1, rectangle 1 2, square 3]
