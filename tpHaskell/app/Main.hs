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


--b


--5

aplicarHechizo::Mago -> Hechizos -> Mago
aplicarHechizo mago hechizo = mago {salud=salud mago - danio mago hechizo}

aplicarHechizos::Mago -> [Hechizos] -> Mago
aplicarHechizos mago hechizos = foldl aplicarHechizo mago hechizos

noPuedeGanarle::Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud mago1 == salud (aplicarHechizos mago1 (hechizos mago2))


main :: IO ()
main = someFunc