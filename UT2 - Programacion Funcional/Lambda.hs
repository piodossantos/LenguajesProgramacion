import Data.List
data LambdaTerm= Variable [Char]|Application LambdaTerm LambdaTerm | Abstraction [Char] LambdaTerm
  deriving(Show,Eq)

toString::LambdaTerm->[Char]
toString (Variable v)= v
toString (Application a b)= "("++(toString a)++" "++(toString b)++")"
toString (Abstraction a b)= "\x3BB" ++ a ++"."++(toString b)



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
caso11 = (Application (Abstraction "x" (Abstraction "y" (Application (Variable "x")( Variable "y"))  )  ) (Variable "y") )
caso12 = (Application (Abstraction "x" (Abstraction "y" (Application (Variable "x")( Variable "y"))  )  ) (Variable "z") )



{- Exercise 1.3 -}

freeVars::LambdaTerm->[[Char]]
freeVars (Variable v)= [v]
freeVars (Application a b ) = (freeVars a) ++ (freeVars b)
freeVars (Abstraction a b) = filter (/=a) (freeVars b)

boundVars::LambdaTerm->[[Char]]
boundVars (Variable _)= []
boundVars (Application a b) = (boundVars a)++(boundVars b)
boundVars (Abstraction a b) = a:(boundVars b)

{- Input -> variable to be replaced -> Expression to be replaced -> Output -}
substitution::LambdaTerm -> [Char] -> LambdaTerm ->LambdaTerm
substitution (Variable v) y z = if ( y == v ) then z else (Variable v)
substitution (Application x y) v s = (Application (substitution x v s )  (substitution y v s ))
substitution (Abstraction x y) v s = if x==v then (Abstraction x y ) else (Abstraction x (substitution y v s))

redexes:: LambdaTerm-> [LambdaTerm]
redexes (Variable v) = []
redexes (Application (Abstraction x y) z ) = [(Application (Abstraction x y) z )] ++ redexes y
redexes (Application x y) = (redexes x) ++ (redexes y)
redexes (Abstraction x y) = redexes y

{- Exercise 1.4 -}

{-
  Input
  variable que quiero sustituir
  variable por la que sustituyo
  output.
-}
{-
alphaConversion:: LambdaTerm -> [Char] -> [Char] -> LambdaTerm
alphaConversion (Variable v) x y = if v==x then (Variable y) else (Variable v)
alphaConversion (Application x y) var1 var2
  |null intersection = (Application x y)
  |elem var1 intersection = Application  (alphaConversion x var1 var2) (alphaConversion y var1 var2)
  |otherwise = (Application x y)
  where
    libres=freeVars (Application x y)
    ligadas=boundVars (Application x y)
    intersection= (intersect libres ligadas)
alphaConversion (Abstraction x y) var1 var2
  |null intersection = (Abstraction x y)
  |elem var1 intersection = Abstraction  (var2) (alphaConversion y var1 var2)
  |otherwise = (Abstraction x y)
  where
    libres=freeVars (Abstraction x y)
    ligadas=boundVars (Abstraction x y)
    intersection= (intersect libres ligadas)
-}

{-
  AlphaConversion
  Detecta las variables que deberan ser reemplazadas y las reemplaza.
-}


{-
alphaConversion::LambdaTerm->LambdaTerm
alphaConversion x
  |intersection == [] = x
  |otherwise = alphaConversionAUX1 $ x  (zip $ intersection variablesNuevas)
  where
    libres= nub freeVars x
    ligadas= nub boundVars x
    intersection = (intersect libres ligadas)
    variablesNuevas = map (\x-> "Variable_"++x )(take (length intersection) [1..] )

alphaConversionAUX1::LambdaTerm->[([Char],String)]->LambdaTerm
alphaConversionAUX1 x [] = x
alphaConversionAUX1 term [(x1,y1):(xs,ys)] = alphaConversionAUX1 (alphaConversionAUX2 term x1 y1) (xs,ys)


alphaConversionAUX2::LambdaTerm-> [Char] -> String ->LambdaTerm
alphaConversionAUX2 (Variable x) y z  = substitution x y z
alphaConversionAUX2 _ _ _  =error"No implementado"

-}


{-
reduceNO::LambdaTerm->LambdaTerm
reduceNO (Variable x) = (Variable x)
reduceNO (Application (Abstraction x y) z) = substitution y x z
reduceNO (Application x y) = (Application (reduceNO x) (reduceNO y))
reduceNO (Abstraction x y) = (Abstraction x (reduceNO y))
-}{-
reduceNO::LambdaTerm->LambdaTerm
reduceNO (Variable x) = (Variable x)
reduceNO (Application (Abstraction x y) z) = substitution y x z
reduceNO (Application x y) = if isNF $ (Application x y) then (Application x y) else reduceNO (Application (reduceNO x) (reduceNO y))
reduceNO (Abstraction x y) = if isNF $ (Abstraction x y) then (Abstraction x y) else reduceNO (Abstraction x (reduceNO y))

reduceAO::LambdaTerm->LambdaTerm
reduceAO (Variable x) = (Variable x)
reduceAO (Application x y) = (Application (reduceAO x) (reduceAO y))
reduceAO (Abstraction x y) = (Abstraction x (reduceNO y))
-}
{-Ejercicio 1.4 ANDA-}

inNormalForm::LambdaTerm->Bool
inNormalForm x = ((length$(redexes x))==0)

normalReduction::LambdaTerm->LambdaTerm
normalReduction (Application (Abstraction a b) c) = substitution b a c
normalReduction (Application m n)
  |m2/=m = (Application m2 n)
  |otherwise = Application m (normalReduction n)
  where
    m2=normalReduction $ m
normalReduction (Abstraction x y)=(Abstraction x (normalReduction y))
normalReduction x = x


applicativeReduction::LambdaTerm->LambdaTerm
applicativeReduction (Application (Abstraction a b) c)
  |b1/=b = Application (Abstraction a b1) (applicativeReduction c)
  |c1/=c = Application (Abstraction a (applicativeReduction b)) c1
  |otherwise = substitution b a c
  where
    b1=applicativeReduction b
    c1=applicativeReduction c
applicativeReduction (Application m n)
  |m2/=m = (Application m2 n)
  |otherwise = Application m (applicativeReduction n)
  where
    m2=applicativeReduction$m
applicativeReduction x = x

prueba= Abstraction "x" (Abstraction "y" (Application (Application (Variable "a") (Variable "y")) (Variable "x")))

prueba2= Application (Abstraction "x" (Abstraction "y" (Application (Variable"x")(Variable"y")))) (Variable"z")

{-1.5 Ejercicio-}
normalReductions::LambdaTerm->[LambdaTerm]
normalReductions x
  |x==y=[x]
  |otherwise =[x] ++ (normalReductions y)
    where
      y=normalReduction x
applicativeReductions::LambdaTerm->[LambdaTerm]
applicativeReductions x
  |x==y=[x]
  |otherwise =[x] ++ (applicativeReductions y)
    where
      y=applicativeReduction x

nAbs::[[Char]]->LambdaTerm->LambdaTerm
nAbs vs b = foldr Abstraction b vs

nApl::[LambdaTerm]->LambdaTerm
nApl e=foldl1 Application e

nVar::[[Char]]->LambdaTerm
nVar x = nApl  (map  Variable  x)
{- Church Boolean -}
l_True = Abstraction "x" (Abstraction "y" (Variable "x"))
l_False = Abstraction "x" (Abstraction "y" (Variable "y"))
l_IF = nAbs ["c","t","f"] (nVar ["c","t","f"])
l_AND = nAbs ["a","b"] (Application (nVar ["a","b"]) l_False )
l_OR =  nAbs ["a","b"] (Application (Application (Variable "a") l_True) (Variable"b"))
l_NOT = nAbs ["a"] (Application (Application (Variable "a") l_False) (l_True))

{- Church Number-}
l_ZERO = Abstraction "s" (Abstraction "z" (Variable "z"))
l_ONE = nAbs ["s","z"] (nVar ["s","z"])
l_TWO =  nAbs ["s","z"] (nVar ["s","s","z"])
l_ADD = nAbs ["m","n","s","z"] (Application (Application (Variable"m") (Variable"s"))(nVar["n","s","z"]))
l_MULT = nAbs ["m","n","s","z"]  (Application (Application (nVar["m"]) (nVar["n","s"])) (nVar["z"]))
{-Use for Debug.-}
l_Church::IO()
l_Church = putStr $ concat $ map (\(x,y) -> x ++" = " ++(toString y)++ "\n") $ zip lista_nombre lista_elem
  where
    lista_elem   = [l_True,l_False,l_IF,l_AND,l_OR,l_NOT,l_ZERO,l_ONE,l_TWO,l_ADD,l_MULT]
    lista_nombre = ["True","False","IF","AND","OR","NOT","ZERO","ONE","TWO","ADD","MULT"]
