module Main (main) where

import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Ejemplo de test" $ do
    it "1 + 1 es igual a 2" $ do
      (1 + 1 :: Integer) `shouldBe` 2
