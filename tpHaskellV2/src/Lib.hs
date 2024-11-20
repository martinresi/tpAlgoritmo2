module Lib
    ( someFunc, luis,
    poder, danio, diferenciaDePoder, 
    hayMagoSinHechizos, 
    sonTodosViejosNionios, f, valorMaximo, mejorHechizoContra,
    mejorOponente, noPuedeGanarle, academiaEjemplo,academiaEjemplo2, academiaEjemplo3,
    ron, hermione, prueba, show,
    Mago, Hechizo, lagrimaFenix,confundus,obliviate,sectumSempra
    ) where


someFunc :: IO ()

type Hechizo = Mago -> Mago 

data Mago = Mago{
    nombre::String,
    edad::Int, 
    salud::Int, 
    hechizos::[Hechizo]
    }


prueba = Mago { 
    nombre = "prueba", 
    edad = 70,
    salud = 100,
    hechizos = [lagrimaFenix 50]
    }

luis = Mago { 
    nombre = "luis", 
    edad = 70,
    salud = 100,
    hechizos = [sectumSempra, lagrimaFenix 50] }

ron = Mago { 
    nombre = "ron", 
    edad = 100, 
    salud = 100, 
    hechizos = [confundus] 
    }
hermione = Mago { 
    nombre = "hermione", 
    edad = 90, 
    salud = 80, 
    hechizos = [obliviate 10, confundus]
    }


academiaEjemplo5 = [luis, hermione]
academiaEjemplo = 
  [ Mago 
      { nombre = "Hagrid", 
        edad = 40, 
        salud = 100, 
        hechizos = [] 
      }
  ]

academiaEjemplo2 = 
    [ Mago 
        {   nombre = "Dumbledore", 
            edad = 100, 
            salud = 100, 
            hechizos = [confundus] 
        }
    ]

academiaEjemplo3 = 
    [ Mago 
        {   nombre = "OldMago", 
            edad = 50, 
            salud = 100, 
            hechizos = replicate 200 confundus 
        }
    ]

lagrimaFenix :: Int -> Hechizo
lagrimaFenix cantidad mago = mago { salud = salud mago + cantidad }

sectumSempra :: Hechizo
sectumSempra mago 
    | salud mago > 10 = mago { salud = salud mago - 10 }
    | otherwise = mago { salud = salud mago `div` 2 }

obliviate :: Int -> Hechizo
obliviate cantidad mago = mago { edad = edad mago - cantidad }

confundus :: Mago -> Mago
confundus mago
    | length (hechizos mago) == 0 = error "El mago no tiene hechizos para confundirse"
    | otherwise = mago {salud = max 0 (salud mago - 5)}




--2
--a) ok
poder :: Mago -> Int
poder mago = salud mago + (edad mago * length (hechizos mago))

--b) chequear
danio :: Mago -> Hechizo -> Int
danio mago hechizo = salud mago - salud (aplicarHechizo hechizo mago)

--c) ok
diferenciaDePoder :: Mago -> Mago -> Int
diferenciaDePoder mago otroMago = abs (poder mago - poder otroMago)

--3
type Academia = [Mago]
--a

esListaVacia :: [Hechizo] -> Bool
esListaVacia [] = True
esListaVacia _  = False


hayMagoSinHechizos :: [Mago] -> Bool
hayMagoSinHechizos = any (\mago -> nombre mago == "Hagrid" && esListaVacia (hechizos mago))


--b
sonTodosViejosNionios :: Academia -> Bool
sonTodosViejosNionios = all (\mago -> edad mago > 16 && length (hechizos mago) > (edad mago * 3))

--4
--a
f x [y] = y
f x (y1:y2:ys)
      | x y1 >= x y2 = f x (y1:ys)
      | otherwise = f x (y2 : ys)

-- Analizando el cuerpo de la funcion, podemos intuir desde el inicio que se busca un valor Mayor/Maximo 
-- del contenido que se encuentra en la lista que ingresa como parametro. Este contenido es afectado por "x"
-- quien se encuentra afectando a cada elemento de la lista, por lo tanto actua como una funcion. 
-- Y dependiendo si es el primer elementro o el segundo, se llama nuevamente a la funcion de manera recursiva
-- para seguir analizando los casos siguientes que se encuentran en la lista hasta el final de la misma.

-- Tipo
-- como se esta usando ">=" ya sabemos que recibe y devuelve valores comparables
-- como hay una funcion dentro ("x") sabemos que este recibe un valor de tipo A y devuelve un valor B que es comparable
-- como la lista posee los elementos que usa la funcion "x", posee valores de tipo A
-- Y como el caso base devuelve un elemnto de la lista, entonces la funcion entera tambien devuelve un valor del mismo tipo "A"
valorMaximo :: Ord b => (a -> b) -> [a] -> a

--Mas expresivo
valorMaximo funcion [valor] = valor
valorMaximo funcion (cabeza : siguiente : cola)
      | funcion cabeza >= funcion siguiente = valorMaximo funcion (cabeza : cola)
      | otherwise = valorMaximo funcion (siguiente : cola)

--b
mejorHechizoContra :: Mago -> Mago -> Hechizo
mejorHechizoContra mago_A mago_B = valorMaximo (danio mago_A) (hechizos mago_B)

mejorOponente :: Mago -> Academia -> Mago
mejorOponente mago academia = valorMaximo (diferenciaDePoder mago) academia

--5 ok, hay que ver con los tests

aplicarHechizo :: Hechizo -> Mago -> Mago
aplicarHechizo hechizo mago = hechizo mago

aplicarHechizos :: Mago -> [Hechizo] -> Mago
aplicarHechizos mago hechizos = foldl (\m h -> h m) mago hechizos



noPuedeGanarle::Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud mago1 == salud (aplicarHechizos mago1 (hechizos mago2))







someFunc = putStrLn "someFunc"