module Newtypefunc where


newtype Type a = Type { f :: a -> a -> a }

newtype State s a = State { runState :: s -> (a,s) }

