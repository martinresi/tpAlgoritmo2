import Test.Hspec
import Lib

main :: IO ()
main = hspec $ do
    describe "poder" $ do
        it "Calcula el poder de un mago con hechizos" $ do
        poder harry `shouldBe` 110
