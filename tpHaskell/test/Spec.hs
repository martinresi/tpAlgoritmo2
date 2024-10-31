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

type Academia = [Mago]

hayMagoSinHechizos :: Academia -> Bool
hayMagoSinHechizos = any (\mago -> nombre mago == "Hagrid" && null (hechizos mago))

sonTodosViejosNionios :: Academia -> Bool
sonTodosViejosNionios = all (\mago -> edad mago <= 16 || length (hechizos mago) > (edad mago * 3))

aplicarHechizo::Mago -> Hechizos -> Mago
aplicarHechizo mago hechizo = mago {salud=salud mago - danio mago hechizo}

aplicarHechizos::Mago -> [Hechizos] -> Mago
aplicarHechizos mago hechizos = foldl aplicarHechizo mago hechizos

noPuedeGanarle::Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud mago1 == salud (aplicarHechizos mago1 (hechizos mago2))

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
 -- 3a
  describe "hayMagoSinHechizos" $ do
    it "Verifica si hay un mago llamado Hagrid sin hechizos en la academia" $ do
      let academiaEjemplo = [Mago { nombre = "Hagrid", edad = 40, salud = 100, hechizos = [] }]
      hayMagoSinHechizos academiaEjemplo `shouldBe` True

    it "Verifica si no hay un mago llamado Hagrid sin hechizos en la academia" $ do
      let academiaEjemplo = [Mago { nombre = "Dumbledore", edad = 100, salud = 100, hechizos = [Confundus] }]
      hayMagoSinHechizos academiaEjemplo `shouldBe` False

   -- 3b
  describe "sonTodosViejosNionios" $ do
    it "Verifica si todos los magos viejos (edad > 16) son ñoños" $ do
      let academiaEjemplo = [Mago { nombre = "OldMago", edad = 50, salud = 100, hechizos = replicate 200 Confundus }]
      sonTodosViejosNionios academiaEjemplo `shouldBe` True

    it "Verifica que no todos los magos viejos son ñoños" $ do
      let academiaEjemplo = [Mago { nombre = "NonNerdMago", edad = 50, salud = 100, hechizos = replicate 10 Confundus }]
      sonTodosViejosNionios academiaEjemplo `shouldBe` False

  --5

  describe "noPuedeGanarle" $ do
    it "El segundo mago no puede ganarle al primero si la salud del primer mago sigue siendo la misma" $ do
      let mago1 = Mago { nombre = "Albus", edad = 100, salud = 100, hechizos = [] }
      let mago2 = Mago { nombre = "Snape", edad = 90, salud = 80, hechizos = [Obliviate, Confundus] }
      noPuedeGanarle mago1 mago2 `shouldBe` True

    it "El segundo mago puede ganarle al primero si la salud del primero cambia" $ do
      let mago1 = Mago { nombre = "Albus", edad = 100, salud = 100, hechizos = [] }
      let mago2 = Mago { nombre = "Snape", edad = 90, salud = 80, hechizos = [LagrimaFenix 20, SectumSempra 15] }
      noPuedeGanarle mago1 mago2 `shouldBe` False
