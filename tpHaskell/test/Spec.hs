module Main (main) where

import Test.Hspec

data Mago = Mago { nombre :: String, edad :: Int, salud :: Int, hechizos :: [Hechizos] } deriving (Show, Eq)
data Hechizos = LagrimaFenix { lagrimaFenixSalud :: Int }
              | SectumSempra { sectumSempraDanio :: Int }
              | Obliviate
              | Confundus
              deriving (Show, Eq)

poder :: Mago -> Int
poder mago = salud mago + (edad mago * length (hechizos mago))

danio :: Mago -> Hechizos -> Int
danio mago (LagrimaFenix lagrimaFenixSalud) = salud mago - (salud mago + lagrimaFenixSalud)
danio mago (LagrimaFenix vida) = -vida
danio mago (SectumSempra _) | salud mago > 10 = 10
                            | otherwise = div (salud mago) 2

diferenciaDePoder:: Mago -> Mago -> Int
diferenciaDePoder mago1 mago2 = abs (poder mago1 - poder mago2)

main :: IO ()
main = hspec $ do
  --2a
  describe "poder" $ do
    it "Calcula el poder de un mago con hechizos" $ do
      let mago = Mago { nombre = "Harry", edad = 5, salud = 100, hechizos = [LagrimaFenix 50, Confundus] }
      poder mago `shouldBe` 110
--2b
  describe "danio" $ do
    it "Calcula el daño de LagrimaFenix según lagrimaFenixSalud" $ do
      let magoEjemplo = Mago { nombre = "Albus", edad = 100, salud = 50, hechizos = [] }
      danio magoEjemplo (LagrimaFenix 20) `shouldBe` (-20)

    it "Calcula el daño de SectumSempra para salud > 10" $ do
      let magoEjemplo = Mago { nombre = "Harry", edad = 17, salud = 50, hechizos = [] }
      danio magoEjemplo (SectumSempra 15) `shouldBe` 10

  --2c
  describe "diferenciaDePoder" $ do
    it "Calcula la diferencia de poder entre dos magos" $ do
      let mago1 = Mago { nombre = "Dumbledore", edad = 100, salud = 90, hechizos = [Obliviate] }
      let mago2 = Mago { nombre = "Voldemort", edad = 70, salud = 100, hechizos = [SectumSempra 20, LagrimaFenix 50] }
      diferenciaDePoder mago1 mago2 `shouldBe` 50  