
import Test.Hspec
import Newtypefunc


main = hspec $ do
   describe "Type newtype" $ do
      it "should call f with a t" $ do
        let t = Type (+)
        f t 5 4 `shouldBe` 9

   describe "State newtype" $ do
      let state = State $ \s -> (s, s+1)
      it "should call runState with an state" $ do
        runState state 0 `shouldBe` (0, 1)
      it "should chaine the previous value to the next one" $ do
        runState state ((snd . runState state) 0) `shouldBe` (1, 2)
