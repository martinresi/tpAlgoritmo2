module Main (main) where

import Lib

-- 1

data Mago = Mago{nombre::String, edad::Int, salud::Int, hechizos::[Hechizos]} deriving (Show, Eq)

data Hechizos = LagrimaFenix {lagrimaFenixSalud::Int}
              | SectumSempra {sectumSempraDanio::Int}
              | Obliviate {}
              | Confundus {}
              deriving (Show, Eq)

--2
--a
poder::Mago -> Int
poder mago = salud mago + (edad mago * length (hechizos mago))
--b
danio:: Mago -> Hechizos -> Int
-- a la salud del magoo total   le resto la que se cura  ATTENTION : a testear
danio mago (LagrimaFenix lagrimaFenixSalud) = salud mago - ( salud mago + lagrimaFenixSalud )  

danio mago (LagrimaFenix vida) = -vida -- a revisar esto me hace ruido
danio mago (SectumSempra  _)| salud mago > 10 = 10
                            | otherwise = div (salud mago) 2
-- no son hechizos de danio                                                    
danio _ Obliviate = 0  
danio _ Confundus = 0 

--c
diferenciaDePoder:: Mago -> Mago -> Int
diferenciaDePoder mago1 mago2 = abs (poder mago1 - poder mago2)

--3
type Academia = [Mago]
--a
hayMagoSinHechizos :: Academia -> Bool
hayMagoSinHechizos = any (\mago -> nombre mago == "Hagrid" && null (hechizos mago))

--b
sonTodosViejosNionios :: Academia -> Bool
sonTodosViejosNionios = all (\mago -> edad mago <= 16 || length (hechizos mago) > (edad mago * 3))

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
valorMaximo funcion [y] = y
valorMaximo funcion (cabeza : siguiente : cola)
      | funcion cabeza >= funcion siguiente = valorMaximo funcion (cabeza : cola)
      | otherwise = valorMaximo funcion (siguiente : cola)

--b
mejorHechizoContra :: Mago -> Mago -> hechizos
mejorHechizoContra mago_A mago_B = valorMaximo (danio mago_A) (hechizos mago_B)

mejorOponente :: Mago -> Academia -> Mago
mejorOponente mago academia = diferenciaDePoder mago (valorMaximo poder Academia)

--5

aplicarHechizo::Mago -> Hechizos -> Mago
aplicarHechizo mago hechizo = mago {salud=salud mago - danio mago hechizo}

aplicarHechizos::Mago -> [Hechizos] -> Mago
aplicarHechizos mago hechizos = foldl aplicarHechizo mago hechizos

noPuedeGanarle::Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud mago1 == salud (aplicarHechizos mago1 (hechizos mago2))


main :: IO ()
main = someFunc
