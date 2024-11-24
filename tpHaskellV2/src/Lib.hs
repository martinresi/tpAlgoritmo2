module Lib
    ( someFunc, luis,
    poder, danio, diferenciaDePoder, 
    hayMagoSinHechizos, 
    sonTodosViejosNionios, f, valorMaximo, mejorHechizoContra,
    mejorOponente, noPuedeGanarle, academiaEjemplo,academiaEjemplo2, academiaEjemplo3,
    ron, hermione, fede, show,
    Mago, Hechizo, lagrimaFenix,confundus,obliviate,sectumSempra
    ) where


someFunc :: IO ()

type Hechizo = Mago -> Mago

data Mago = Mago {
    nombre :: String,
    edad :: Int,
    salud :: Int,
    hechizos :: [Hechizo]
}

-- Como "Hechizo" ahora es una lista de funciones, el "Show" no sabe como mostrar las mismas
-- entonces seteamos esta instancia para poder ver que nos tira las funciones sin necesidad
-- de mostrar la lista de hechizos
instance Show Mago where
    show (Mago nombre edad salud _) =
        "Mago { nombre = " ++ show nombre ++
        ", edad = " ++ show edad ++
        ", salud = " ++ show salud ++ " }"


fede = Mago { 
    nombre = "prueba", 
    edad = 70,
    salud = 50,
    hechizos = [obliviate 1]
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
    
voldemore = Mago { 
    nombre = "Voldemore", 
    edad = 120, 
    salud = 250, 
    hechizos = replicate 200 confundus
    }

mark = Mago { nombre = "Mark", edad = 50, salud = 10, hechizos = replicate 10 confundus }

valeria = Mago { nombre = "Valeria", edad = 25, salud = 120, hechizos = replicate 50 sectumSempra }

juan = Mago { nombre = "Juan", edad = 63, salud = 150, hechizos = replicate 100 confundus }

lautaro = Mago { nombre = "Lautaro", edad = 37, salud = 110, hechizos = replicate 60 (lagrimaFenix 20) }

rodrigo = Mago { nombre = "Rodrigo", edad = 82, salud = 200, hechizos = replicate 75 confundus }


academiaEjemplo = [ Mago {nombre = "Hagrid", edad = 40, salud = 100, hechizos = [] }]

academiaEjemploA = [ Mago {nombre = "Hagrid", edad = 40, salud = 100, hechizos = [sectumSempra, lagrimaFenix 20] }]

academiaEjemplo2 = 
    [ Mago { nombre = "Dumbledore", edad = 100, salud = 100, hechizos = [confundus]},
      Mago { nombre = "Marcus", edad = 45, salud = 100, hechizos = [] },
      Mago { nombre = "Leticia", edad = 75, salud = 100, hechizos = [sectumSempra, lagrimaFenix 20]}]

academiaEjemplo3 = 
    [ Mago { nombre = "Marcus", edad = 50, salud = 100, hechizos = replicate 200 confundus }, 
    Mago { nombre = "Balrock", edad = 25, salud = 120, hechizos = replicate 80 sectumSempra },
    Mago { nombre = "Jarnia", edad = 63, salud = 150, hechizos = replicate 190 confundus },
    Mago { nombre = "Letme", edad = 37, salud = 110, hechizos = replicate 120 (lagrimaFenix 20) },
    Mago { nombre = "Rock", edad = 82, salud = 200, hechizos = replicate 250 confundus }]

academiaEjemplo4 = [mark, valeria, juan, lautaro, rodrigo]

academiaEjemplo5 = [luis, hermione]

lagrimaFenix :: Int -> Hechizo
lagrimaFenix cantidad mago = mago { salud = salud mago + cantidad }

sectumSempra :: Hechizo
sectumSempra mago 
    | salud mago > 10 = mago { salud = salud mago - 10 }
    | otherwise = mago { salud = salud mago `div` 2 }

obliviate :: Int -> Hechizo
obliviate n mago = mago { hechizos = drop n (hechizos mago) }

confundus :: Hechizo
confundus mago
    | length (hechizos mago) == 0 = error "El mago no tiene hechizos"
    | otherwise            = mago {salud = max 0 (salud mago - 5)}

--2
--a)
poder :: Mago -> Int
poder mago = salud mago + (edad mago * length (hechizos mago))

--b)
danio :: Mago -> Hechizo -> Int
danio mago hechizo = salud mago - salud (aplicarHechizo hechizo mago)

--c)
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
f x [y] = y
f x (y1:y2:ys)
      | x y1 >= x y2 = f x (y1:ys)
      | otherwise = f x (y2 : ys)

--a)
--Para que sirve:
-- Sirve para buscar el valor mas grande o maximo que se encuentra dentro de una lista
-- usando una funcion como parametro, el cual calcula (en base de como este hecha la funcion)
-- cada valor de la lista y las compara hasta obtener el valor mas alto.

--Como lo hace:
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

--5) 
aplicarHechizo :: Hechizo -> Mago -> Mago
aplicarHechizo hechizo mago = hechizo mago

aplicarHechizos :: Mago -> [Hechizo] -> Mago
aplicarHechizos mago hechizos = foldl (\m h -> h m) mago hechizos

noPuedeGanarle::Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud mago1 == salud (aplicarHechizos mago1 (hechizos mago2))

someFunc = putStrLn "someFunc"
