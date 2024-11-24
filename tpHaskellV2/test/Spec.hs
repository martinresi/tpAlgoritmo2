import Test.Hspec
import Lib (Mago,Hechizo,show, lagrimaFenix,sectumSempra,obliviate, fede, confundus, poder, f, danio, diferenciaDePoder, luis,ron, hermione, academiaEjemplo, academiaEjemplo2, academiaEjemplo3,  hayMagoSinHechizos, sonTodosViejosNionios, noPuedeGanarle, valorMaximo, mejorHechizoContra, mejorOponente, academiaEjemploA, academiaEjemplo4)

main :: IO ()
main = hspec $ do

    -- 2a
    describe "poder" $ do
        it "Calcula el poder de un mago con hechizos" $ 
            poder fede `shouldBe` 120
  
    -- 2b
    describe "danio" $ do
        it "Calcula el daño de LagrimaFenix según lagrimaFenixSalud" $ 
            danio fede (lagrimaFenix 20) `shouldBe` (-20)

    -- 2c
    describe "diferenciaDePoder" $ do
        it "Calcula la diferencia de poder entre dos magos" $ 
            diferenciaDePoder fede luis `shouldBe` 120

    -- 3a
    describe "hayMagoSinHechizos" $ do
        it "Verifica si hay un mago llamado Hagrid sin hechizos en la academia" $ 
            hayMagoSinHechizos academiaEjemplo `shouldBe` True

        it "Verifica si hay un mago llamado Hagrid con hechizos en la academia" $ 
            hayMagoSinHechizos academiaEjemploA `shouldBe` False
        
        it "Verifica si no hay un mago llamado Hagrid sin hechizos en la academia" $ 
            hayMagoSinHechizos academiaEjemplo2 `shouldBe` False

    -- 3b
    describe "sonTodosViejosNionios" $ do
        it "Verifica si todos los magos viejos (edad > 16) son ñoños" $ 
            sonTodosViejosNionios academiaEjemplo3 `shouldBe` True

        it "Verifica que no todos los magos viejos son ñoños" $ 
            sonTodosViejosNionios academiaEjemplo4 `shouldBe` False

--4 a
    describe "f" $ do
        it "debe devolver el único elemento de una lista con un solo valor" $ 
            f length ["a"] `shouldBe` "a"
        
        it "debe devolver el valor con la mayor longitud cuando comparamos strings por longitud" $ 
            f length ["abc", "a", "ab"] `shouldBe` "abc"
        
        it "debe devolver el primer valor si ambos son iguales según la comparación" $ 
            f length ["abc", "def"] `shouldBe` "abc"
        
        it "debe devolver el mayor número según la función de comparación" $ 
            f id [1, 5, 3, 2] `shouldBe` 5
        
        it "debe funcionar correctamente en una lista con más de dos elementos" $ 
            f length ["a", "bc", "def"] `shouldBe` "def"

    
    describe "valorMaximo" $ do
        it "debe devolver el único valor de una lista de un solo elemento" $ 
            valorMaximo id [5] `shouldBe` 5

        it "debe devolver el valor máximo según la función de comparación" $ 
            valorMaximo id [3, 5, 2, 8, 1] `shouldBe` 8

        it "debe funcionar correctamente con una función de comparación como longitud de cadenas" $ 
            valorMaximo length ["a", "ab", "abc", "abcd"] `shouldBe` "abcd"

    -- b
        describe "mejorOponente" $ do
      it "Se coloca un mago debil y verifica quien de la academia posee mas poder que él" $
            mejorOponente fede academiaEjemplo5 `shouldBe` hermione

      it "Se coloca un mago poderoso y verifica con quien de la academia posee una mayor diferencia de poder" $
            mejorOponente voldemore academiaEjemplo4 `shouldBe` mark
    --5

    describe "noPuedeGanarle" $ do
        it "El segundo mago no puede ganarle al primero si la salud del primer mago sigue siendo la misma" $ 
            noPuedeGanarle ron hermione `shouldBe` False

        it "El segundo mago puede ganarle al primero si la salud del primero cambia" $ 
            noPuedeGanarle ron luis `shouldBe` False
