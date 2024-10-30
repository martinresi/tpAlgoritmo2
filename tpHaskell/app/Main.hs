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


--c
-- diferenciaDePoder:: Mago -> Mago -> Int
diferenciaDePoder mago1 mago2 = abs (poder mago1 - poder mago2)

--3
type Academia = [Mago]
--a
hayMagoSinHechizos :: Academia -> Bool
hayMagoSinHechizos = any (\mago -> nombre mago == "Hagrid" && null (hechizos mago))

--b
sonTodosViejosNionios :: Academia -> Bool
sonTodosViejosNionios = all (\mago -> edad mago <= 16 || length (hechizos mago) > (edad mago * 3))

main :: IO ()
main = someFunc
