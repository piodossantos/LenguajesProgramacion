import Data.List
data LambdaTerm = Variable [Char]|Application LambdaTerm LambdaTerm | Abstraction [Char] LambdaTerm | KBool Bool | KInt Int | KIf | KLt | KMult | KSub
  deriving(Show,Eq)

{-
  EJERCICIO 1.2. Con moficiciones para implementar 1.7
-}

-- devuelve un string con la representacion del lambda termino.
toString::LambdaTerm->String
toString (KBool x) = show(x)
toString (KInt x) = show(x)
toString (KIf) = "?"
toString (KLt) = "<"
toString (KMult) = "*"
toString (KSub) = "-"
toString (Variable v) = v
toString (Application a b) = "("++(toString a) ++ " " ++ (toString b) ++ ")"
toString (Abstraction a b) = "\x3BB" ++ a ++ "." ++ (toString b)

-- casos de clase
caso1 = (Variable "x")
caso2 = (Application (Variable "y") (Variable "z"))
caso3 = (Abstraction "w" (Variable "w") )
caso4 = (Abstraction "a" (Abstraction "b"  (Application (Variable "a") (Variable "b"))))
caso5 = (Abstraction "c" (Abstraction "a" (Abstraction "b"  (Application (Variable "a") (Variable "b")))))
caso6 = (Abstraction "x" (Application (Variable("x")) (Variable("x"))))
caso7 = (Abstraction "x" (Variable("x")) )
caso8 = (Abstraction "a" (Abstraction "b"  (Variable "a") ))
caso9 = (Variable "y")
caso10 = (Variable "w")
caso11 = (Application (Abstraction "x" (Abstraction "y" (Application (Variable "x")(Variable "y")))) (Variable "y"))
caso12 = (Application (Abstraction "x" (Abstraction "y" (Application (Variable "x")(Variable "y")))) (Variable "z"))



{-

  EJERCICIO 1.3 (Con modificaciones para implementar 1.7)

-}

-- freeVars devuelve una lista con las variables libres de un lambda termino
freeVars::LambdaTerm->[[Char]]
freeVars (Variable v)= [v]
freeVars (Application a b ) = (freeVars a) ++ (freeVars b)
freeVars (Abstraction a b) = filter (/=a) (freeVars b)
freeVars _ = []

-- freeVars devuelve una lista con las variables ligadas de un lambda termino
boundVars::LambdaTerm->[[Char]]
boundVars (Variable _)= []
boundVars (Application a b) = (boundVars a) ++ (boundVars b)
boundVars (Abstraction a b) = a:(boundVars b)
boundVars _ =[]

{- Input -> variable to be replaced -> Expression to be replaced -> Output -}
-- reemplaza una variable por una expresion, en un lambda termino.
substitution::LambdaTerm -> [Char] -> LambdaTerm ->LambdaTerm
substitution (Variable v) y z = if ( y == v ) then z else (Variable v)
substitution (Application x y) v s = (Application (substitution x v s )  (substitution y v s ))
substitution (Abstraction x y) v s = if x==v then (Abstraction x y ) else (Abstraction x (substitution y v s))
substitution x _ _ = x

-- calcula los redexes de un lambda termino y los devuelve en una lista.
redexes:: LambdaTerm-> [LambdaTerm]
redexes (Variable v) = []
redexes (Application (Abstraction x y) z ) = [(Application (Abstraction x y) z )] ++ redexes y
redexes (Application x y) = (redexes x) ++ (redexes y)
redexes (Abstraction x y) = redexes y
redexes _ =[]

{-

  EJERCICIO 1.4 . (Con modificaciones para 1.7)

-}

-- devuelve true si esta en forma normal, es decir si no se puede reducir mas.
inNormalForm::LambdaTerm->Bool
inNormalForm x = ((length$(redexes x)) == 0)

-- simplifica el lambda termino en un solo paso o reduccion.
normalReduction::LambdaTerm->LambdaTerm
normalReduction (Application (Abstraction a b) c) = substitution b a c
normalReduction (Application (Application KLt (KInt x)) (KInt y)) = KBool (x<y)
normalReduction (Application (Application KMult (KInt x)) (KInt y)) = KInt (x*y)
normalReduction (Application (Application KSub (KInt x)) (KInt y)) = KInt (x-y)
normalReduction (Application( Application( Application(KIf) (KBool x)  )( a )  )( b ) ) = if x then a else b
normalReduction (Application m n)
  |m2/=m = (Application m2 n)
  |otherwise = Application m (normalReduction n)
  where
    m2=normalReduction $ m
normalReduction (Abstraction x y)=(Abstraction x (normalReduction y))
normalReduction x = x


-- simplifica el lambda termino en un solo paso o reduccion.
-- el aplicativo va hacia las hojas del arbol de expresion.
applicativeReduction::LambdaTerm->LambdaTerm
applicativeReduction (Abstraction x y) = (Abstraction x (applicativeReduction y))
applicativeReduction (Application (Abstraction a b) c)
  |b1 /= b = Application (Abstraction a b1) (c)
  |c1 /= c = Application (Abstraction a (b)) c1
  |otherwise = substitution b a c
    where
      b1 = applicativeReduction b
      c1 = applicativeReduction c
applicativeReduction (Application (Application KLt (KInt x)) (KInt y)) = KBool (x<y)
applicativeReduction (Application (Application KMult (KInt x)) (KInt y)) = KInt (x*y)
applicativeReduction (Application (Application KSub (KInt x)) (KInt y)) = KInt (x-y)
applicativeReduction (Application( Application( Application(KIf) (KBool x)  )( a )  )( b ) )
  |a1/=a = (Application( Application( Application(KIf) (KBool x)  )( a1 )  )( b ) )
  |b1/=b = (Application( Application( Application(KIf) (KBool x)  )( a )  )( b1 ) )
  |otherwise = if x then a else b
    where
      a1 = applicativeReduction a
      b1 = applicativeReduction b
applicativeReduction (Application( Application( Application(KIf) ( x)  )( a )  )( b ) )
  |x1/=x=(Application( Application( Application(KIf) ( x1)  )( a )  )( b ) )
  |otherwise=(Application( Application( Application(KIf) ( x)  )( a )  )( b ) )
    where
      x1=applicativeReduction x
applicativeReduction (Application m n)
  |m2 /= m = (Application m2 n)
  |otherwise = Application m (applicativeReduction n)
  where
    m2 = applicativeReduction $ m
applicativeReduction x = x

-- lleva el lambda termino a su forma normal mediante una secuencia de reducciones normales
-- devuelve todo los pasos de la reduccion en una lista.
normalReductions::LambdaTerm->[LambdaTerm]
normalReductions x
  |x == y = [x]
  |otherwise = nub ([x,y] ++ (normalReductions y))
    where
      y = normalReduction x

-- lleva el lambda termino a su forma normal mediante una secuencia de reducciones aplicativas
-- devuelve todo los pasos de la reduccion en una lista.
applicativeReductions::LambdaTerm->[LambdaTerm]
applicativeReductions x
  |x == y = [x]
  |otherwise = nub([x,y] ++ (applicativeReductions y))
    where
      y = applicativeReduction x

{-Ejemplos que se piden implementar-}
omega1 = (Abstraction "x" (Application (Variable "x") (Variable "x")))
omega = (Application omega1 omega1)
example1 = (Application (Abstraction "x" (Variable "y")) omega)

{-
  EJERCICIO 1.5. se recomienda llamar a l_ChurchEXP y l_ChurchPROP para probarlas.
-}

{- Church Boolean -}
l_True = Abstraction "x" (Abstraction "y" (Variable "x"))
l_False = Abstraction "x" (Abstraction "y" (Variable "y"))
l_IF = nAbs ["c","t","f"] (nVar ["c","t","f"])
l_AND = nAbs ["a","b"] (Application (nVar ["a","b"]) l_False )
l_OR = nAbs ["a","b"] (Application (Application (Variable "a") l_True) (Variable"b"))
l_NOT = nAbs ["a"] (Application (Application (Variable "a") l_False) (l_True))

{- Church Number-}
l_ZERO = Abstraction "s" (Abstraction "z" (Variable "z"))
l_ONE = nAbs ["s","z"] (nVar ["s","z"])
l_TWO =  nAbs ["s","z"] (Application (Variable"s") (nVar["s","z"]))
l_THREE = nAbs ["s","z"] (Application (Variable"s") (Application (Variable"s") (Application (Variable"s") (Variable"z"))))
l_FOUR = nAbs ["s","z"] (Application (Variable"s") (Application(Variable"s") (Application(Variable"s") (Application (Variable"s") (Variable"z")))))
l_ADD = nAbs ["m","n","s","z"] (Application (Application (Variable"m") (Variable"s")) (nVar["n","s","z"]))
l_MULT = nAbs ["m","n","s","z"] (Application (Application (Variable"m") (Application (Variable"n") (Variable"s")))(Variable"z"))



{-
  EJERCICIO 1.6 - 1.7 (Se recomienda llamar a la funcion factorial para corroborar su funcionamiento.)
-}

-- OPERADOR DE PUNTO FIJO: para delta reducciones. Copia la funcion y mantiene el nombre
y_T::LambdaTerm
y_T = Abstraction "h" (Application j j)
  where
     j = Abstraction "x" (Application (Variable"h") (Application (Variable"x") (Variable"x") ))

-- Funcion factorial expresada en calculo lambda Impuro.
l_factorial::LambdaTerm
l_factorial = nAbs["f","n"] (nApl[KIf, cond, (KInt 1), pasoRec])
  where
    cond = nApl[KLt, Variable"n", (KInt 2)]
    aux = Application (Variable"f") (nApl[KSub, Variable"n", (KInt 1)])
    pasoRec = nApl [KMult, Variable"n", aux]


{--
  FUNCIONES EXTRA, que se usan para testear el codigo o simplificar alguna funcion.
--}


-- Recibe un entero y devuelve su factorial, expresado como un Lambda termino.
-- Esta implementado como una operacion en calculo lambda impuro.
factorial::Int->LambdaTerm
factorial i =nApl[y_T,l_factorial,(KInt i)]



{-Hace lo mismo que toString pero no simplifica algunas expresiones conocidas por un nombre de variable
de forma de  hacerlo mas legible a la hora de testear.-}
toStringSIMPL::LambdaTerm->[Char]
toStringSIMPL (KBool x) = show(x)
toStringSIMPL (KInt x) = show(x)
toStringSIMPL (KIf) = "?"
toStringSIMPL (KLt) = "<"
toStringSIMPL (KMult) = "*"
toStringSIMPL (KSub) = "-"
toStringSIMPL (Variable v) = v
toStringSIMPL (Application a b) = "(" ++ (toStringSIMPL a) ++ " " ++ (toStringSIMPL b) ++ ")"
toStringSIMPL (Abstraction a b)
  |null(elemento) = "\x3BB" ++ a ++ "." ++ (toStringSIMPL b)
  |otherwise= snd $ head $ filter (\x -> fst x == (head elemento)) (zip lista_elem lista_nombre)
  where
    lista_elem = [l_True, l_False, l_IF, l_AND, l_OR, l_NOT, l_ZERO, l_ONE, l_TWO, l_THREE, l_FOUR, l_ADD, l_MULT,l_factorial,y_T,omega1]
    lista_nombre = ["TRUE", "FALSE", "IF", "AND", "OR", "NOT", "ZERO", "ONE", "TWO", "THREE", "FOUR", "ADD", "MULT","FACTORIAL","PUNTO_FIJO","\x03A9"]
    elemento = filter ( == (Abstraction a b)) lista_elem


{-for Print in console.-}
toIO::LambdaTerm->IO()
toIO x = putStrLn$toString$x


-- realiza n abstracciones
nAbs::[[Char]]->LambdaTerm->LambdaTerm
nAbs vs b = foldr Abstraction b vs

-- realiza n aplicaciones, respetando asociativa por izquierda.
nApl::[LambdaTerm]->LambdaTerm
nApl e = foldl1 Application e

-- aplica n variables recibidas por parametro
nVar::[[Char]]->LambdaTerm
nVar x = nApl (map Variable x)

--Muestra en consola la expresion de cada operador booleano/aritmetico definido.
l_ChurchEXP::IO()
l_ChurchEXP = putStr $ concat $ map (\(x,y) -> x ++ "\t=  " ++ (toString y) ++ "\n") $ zip lista_nombre lista_elem
  where
    lista_elem = [l_True, l_False, l_IF, l_AND, l_OR, l_NOT, l_ZERO, l_ONE, l_TWO, l_THREE, l_FOUR, l_ADD, l_MULT]
    lista_nombre = ["True", "False", "IF", "AND", "OR", "NOT", "ZERO", "ONE", "TWO", "THREE", "FOUR", "ADD", "MULT"]

--Evalua operadores logicos de los booleanos y operadores aritmeticos de los numeros (solamente 0 1 y 2).
l_ChurchPROP::IO()
l_ChurchPROP = putStr $ concat $ map (\(x,y)-> (toStringSIMPL x) ++ " = " ++ (toStringSIMPL y) ++ "\n" ) $ zip listaNoReducida listaReducida
  where
    numberVAL = [l_ZERO,l_ONE,l_TWO]
    boolVAL = [l_True,l_False]
    listaIF = map (\x-> nApl[l_IF, x, Variable "a", Variable "b"]) boolVAL
    listaAND = map (\(x, y)-> nApl[l_AND, x, y]) [(x, y)|x<-boolVAL, y<-boolVAL]
    listaOR = map (\(x, y)-> nApl[l_OR, x, y]) [(x, y)|x<-boolVAL, y<-boolVAL]
    listaNOT = [nApl[l_NOT, l_True], nApl[l_NOT, l_False]]
    listaADD = map (\(x, y)-> nApl[l_ADD, x, y]) [(x, y)|x<-numberVAL, y<-numberVAL]
    listaMULT = map (\(x, y)-> nApl[l_MULT, x, y]) [(x, y)|x<-numberVAL, y<-numberVAL]
    listaNoReducida = listaIF ++ listaAND ++ listaOR ++ listaNOT ++ listaADD ++ listaMULT
    listaReducida = map (\x-> last $ applicativeReductions x) listaNoReducida

-- Si se le pasa por parametro una reduccion imprimira en consola la lista de pasos que se ejectan/ejecutraron para llegar al resultado.
pruebaConversion::[LambdaTerm]->IO()
pruebaConversion x = putStr $ concat $ map ( ++ "\n" ) ( map ( toStringSIMPL ) ( x ))

-- Se usa para ver si soporta una delta reduction usando reduccion normal  o aplicativa.
pruebaDELTA::LambdaTerm
pruebaDELTA = nApl [KLt,a,b]
  where
    a = nApl [KSub,(KInt 30),(KInt 2)]
    b = nApl [KMult,(KInt 30),(KInt 2)]
