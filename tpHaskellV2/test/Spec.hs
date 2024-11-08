import Test.Hspec
import Lib (Mago,Hechizos(LagrimaFenix,SectumSempra,Obliviate,Confundus), poder, danio, diferenciaDePoder, harry, luis,ron, hermione, academiaEjemplo, academiaEjemplo2, academiaEjemplo3,  hayMagoSinHechizos, sonTodosViejosNionios, noPuedeGanarle)

main :: IO ()
main = hspec $ do

    -- 2a
    describe "poder" $ do
        it "Calcula el poder de un mago con hechizos" $ 
            poder harry `shouldBe` 110
  
    -- 2b
    describe "danio" $ do
        it "Calcula el daño de LagrimaFenix según lagrimaFenixSalud" $ 
            danio harry (LagrimaFenix 20) `shouldBe` (-20)

        it "Calcula el daño de SectumSempra para salud > 10" $ 
            danio harry (SectumSempra 15) `shouldBe` 10

    -- 2c
    describe "diferenciaDePoder" $ do
        it "Calcula la diferencia de poder entre dos magos" $ 
            diferenciaDePoder harry luis `shouldBe` 130

    -- 3a
    describe "hayMagoSinHechizos" $ do
        it "Verifica si hay un mago llamado Hagrid sin hechizos en la academia" $ 
            hayMagoSinHechizos academiaEjemplo `shouldBe` True

        it "Verifica si no hay un mago llamado Hagrid sin hechizos en la academia" $ 
            hayMagoSinHechizos academiaEjemplo2 `shouldBe` False

    -- 3b
    describe "sonTodosViejosNionios" $ do
        it "Verifica si todos los magos viejos (edad > 16) son ñoños" $ 
            sonTodosViejosNionios academiaEjemplo3 `shouldBe` True

        it "Verifica que no todos los magos viejos son ñoños" $ 
            sonTodosViejosNionios academiaEjemplo `shouldBe` False

    --5

    describe "noPuedeGanarle" $ do
        it "El segundo mago no puede ganarle al primero si la salud del primer mago sigue siendo la misma" $ 
            noPuedeGanarle ron hermione `shouldBe` True

        it "El segundo mago puede ganarle al primero si la salud del primero cambia" $ 
            noPuedeGanarle ron luis `shouldBe` False