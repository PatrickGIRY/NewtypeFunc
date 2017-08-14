# Haskell newtype with function
## A first type

Given a type `Type` that wrap a function `f` as record accessor :

    newtype Type a = Type { f :: a -> a -> a }   

The type of `Type` data constructor is :

    Type :: (a -> a -> a) -> Type a

The type of the function `f` is :

    f :: Type a -> a -> a -> a

The function contained in the newtype must be isomorphic to the type is wraps. That is, there must be a way to go from the newtype to the thing it wraps and back again without losing information. 

When we create a constant of the type :

    let t = Type (+)

And you call `f` with `t` and two integers, then the result is the sum of the integers : 

    f t 5 4 `shouldBe` 9

## An other newtype called State

Given a type `State` 

   newtype State s a = State { runState :: s -> (a,s) }

State data comnstructor and `runState` record accessor as our means of putting a value and taking a value of the State type :

    State :: (s -> (a, s)) -> State s a

    runState :: State s a -> s -> (a, s)

State is a function tha takes input state and returns an output value, `a`, tupled with the new state value.

When we create a constant of the type :

    let state = State $ \s -> (s, s+1)    

And we call `runState` with `state` and an input state 0, then the result is a tuple with `(0, 1)`.

    runState state 0 `shouldBe` (0, 1) 

The key is that the previous state value is chained to the next one.

    runState state ((snd . runState state) 0) `shouldBe` (1, 2)

with :

    runState state 0 :: Num a => (a, a)

    snd :: (a, b) -> b

    (snd . runState state) :: Num c => c -> c


