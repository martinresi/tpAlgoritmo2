--Cada robot tiene un identificador (nombre), un nivel de experiencia, 
--una cantidad de energía y un conjunto de programas (software). 
--A través de estos programas, un robot puede modificar las capacidades
-- de otros robots.
--Ejemplos de programas a implementar:
--recargarBateria: Este programa recibe un robot y lo recarga, aumentando su energía en una cantidad variable.
--descargaElectrica: Este programa causa una reducción de energía al robot objetivo: si su energía es mayor a 10, le quita 10 puntos; en caso contrario, reduce su energía a la mitad.
--olvidarProgramas: Hace que el robot que lo recibe olvide los primeros N programas que conoce.
--autoAtaque: El robot objetivo se ataca a sí mismo usando su primer programa registrado. Lanzar error si no tiene ningún programa.
--Funciones a realizar: (2)

type Programa = Robot -> Robot

data Robot = Robot {
      nombre :: String,
      nivelExperiencia:: Int,
      energia :: Int,
      programas :: [Programa]

}

-- Programas a implementar
recargaBateria :: Int -> Robot
recargaBateria n robot = robot {energia = energia robot + n}

descargaElectrica :: Programa
descargaElectrica robot
      | energia robot > 10 = robot { energia = energia robot - 10 }
      | otherwise          = robot { energia = energia robot `div` 2 }

olvidarPrograma :: Programa
olvidarPrograma n robot = robot{programas = drop n (programas robot)}

autoAtaque :: Programa
autoAtaque robot
      | length (programas robot) == 0 = error "no tiene programas"
      | otherwise                     = (head (programas robot)) robot
--1
poder :: Robot -> Int
poder robot = energia robot + (nivelExperiencia robot * length (programas robot))
--Calcula la fuerza de un robot sumando su energía más el producto de su nivel de experiencia por la cantidad de programas que tiene.
--2
daño :: Robot -> Programa -> Int
danio robot programa
    | energia robot == energia (programa robot) = 0  -- Si no hay cambio en la energía, retornamos 0
    | otherwise = energia robot - energia (programa robot)
--Calcula cuánta energía se pierde o gana al aplicar un programa a un robot. La ganancia se indica con un número negativo. La función retorna 0 si no hay cambio.


--3
diferenciaDePoder :: Robot -> Robot -> Int
diferenciaDePoder r1 r2 = abs (poder r1 - poder r2)

--La diferencia absoluta en poder entre dos robots

--Consultas:

type Academia = [Robot]
--Representa un conjunto de robots en una organización.
--Existe en la academia algún robot llamado "Atlas" que actualmente no tenga programas en su software?
hayRobotSinProgramasLlamado :: String -> Academia -> Bool
hayRobotSinProgramasLlamado nombreAtlas = any (\robot -> nombre robot == nombreAtlas && null (programas robot))

--Todos los robots viejos (con experiencia mayor a 16) son considerados "obstinados", esto es, que tengan más programas que el triple de su nivel de experiencia?
esObstinado :: Robot -> Bool
esObstinado robot = length (programas robot) > 3 * experiencia robot

todosLosViejosSonObstinados :: Academia -> Bool
todosLosViejosSonObstinados = all esObstinado . filter ((>16) . experiencia)


--Sobre la función auxiliar: (4)
f x [y] = y
f x (y1:y2:ys)
      | x y1 >= x y2 = f x (y1:ys)
      | otherwise = f x (y2 : ys)

--Explica brevemente cuál es su propósito, define su tipo y presenta una versión que sea más expresiva en el paradigma funcional.
--EXPLICACION:

-- Esta función se utiliza para encontrar el valor más alto o máximo dentro de una lista,
-- aplicando una función que se pasa como parámetro. Dicha función transforma cada elemento de la lista
-- y luego compara los resultados para determinar cuál es el mayor.
-- Al observar el cuerpo de la función, se puede deducir que su objetivo es hallar el valor máximo
-- entre los elementos de la lista. Para ello, aplica una función (representada por "x")
-- a cada elemento. Esta función transforma los elementos, y el resultado de cada transformación
-- se compara para determinar cuál es el más grande.

-- El proceso es recursivo: compara los primeros elementos y luego sigue evaluando
-- el resto de la lista hasta encontrar el valor máximo.

-- Como se utiliza el operador ">=", podemos inferir que los valores deben ser comparables.
-- La función recibida como parámetro toma un valor de tipo A y devuelve uno de tipo B,
-- que debe ser comparable.
-- La lista contiene elementos del tipo A, ya que son los que se le pasan a la función.
-- Dado que el caso base retorna un elemento de la lista, el tipo de retorno de la función
-- también es A.

valorMaximo :: Ord b => (a -> b) -> [a] -> a
valorMaximo funcion [valor] = valor
valorMaximo funcion (x : siguiente : xs)
      | funcion x >= funcion siguiente = valorMaximo funcion (x : xs)
      | otherwise = valorMaximo funcion (siguiente : xs)
--Sin definir funciones auxiliares, construye las siguientes:
--4
mejorProgramaContra :: Robot -> Robot -> Programa
--Elige el programa del segundo robot que cause mayor reducción de energía al primero.
--5
mejorOponente :: Robot -> Academia -> Robot
--Encuentra el robot con la mayor diferencia de poder respecto al robot recibido.

--Implementación sin recursividad:

--Implementa la función 
--6
noPuedeDerrotarle :: Robot -> Robot -> Bool
--La condición es que, tras aplicar todos los programas que conoce al segundo robot, la energía del primero quede igual que antes, sin necesidad de usar recursividad.
