module Main (main) where

import Lib

-- 1

data Mago = Mago{nombre::String, edad::Int, salud::Int, hechizos::[Hechizos]}

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


--3
main :: IO ()
main = someFunc