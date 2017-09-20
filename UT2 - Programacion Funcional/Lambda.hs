import Data.List
data LambdaTerm= Variable [Char]|Application LambdaTerm LambdaTerm | Abstraction [Char] LambdaTerm | KBool Bool | KInt Int | KIf | KLt | KMult | KSub
  deriving(Show,Eq)

toString::LambdaTerm->[Char]
toString (KBool x)=show(x)
toString (KInt x)=show(x)
toString (KIf)="?"
toString (KLt)="<"
toString (KMult)="*"
toString (KSub)="-"
toString (Variable v)= v
toString (Application a b)= "("++(toString a)++" "++(toString b)++")"
toString (Abstraction a b)
  |null(elemento)="\x3BB" ++ a ++"."++(toString b)
  |otherwise= snd$head$filter (\x-> fst x==(head elemento)) (zip lista_elem lista_nombre)
  where
    lista_elem   = [l_True,l_False,l_IF,l_AND,l_OR,l_NOT,l_ZERO,l_ONE,l_TWO,l_THREE,l_FOUR,l_ADD,l_MULT]
    lista_nombre = ["True","False","IF","AND","OR","NOT","ZERO","ONE","TWO","THREE","FOUR","ADD","MULT"]
    elemento= filter (== (Abstraction a b)) lista_elem

{-for Print in console.-}
toIO::LambdaTerm->IO()
toIO x = putStrLn$toString$x

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

y_T::LambdaTerm
y_T = Abstraction "h" (Application j j)
  where
     j = Abstraction "x" (Application (Variable"h") (Application (Variable"x") (Variable"x") ))
l_factorial::LambdaTerm
l_factorial= nAbs["f","n"] (nApl[KIf,cond,(KInt 1),pasoRec])
  where
    cond=nApl[KLt,Variable"n",(KInt 2)]
    aux=Application (Variable"f") (nApl[KSub,Variable"n",(KInt 1)])
    pasoRec=nApl [KMult,Variable"n",aux]

{- Exercise 1.3 -}

freeVars::LambdaTerm->[[Char]]
freeVars (Variable v)= [v]
freeVars (Application a b ) = (freeVars a) ++ (freeVars b)
freeVars (Abstraction a b) = filter (/=a) (freeVars b)
freeVars _ = []

boundVars::LambdaTerm->[[Char]]
boundVars (Variable _)= []
boundVars (Application a b) = (boundVars a)++(boundVars b)
boundVars (Abstraction a b) = a:(boundVars b)
boundVars _ =[]

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
l_TWO =  nAbs ["s","z"] (Application (Variable"s") (nVar["s","z"]))
l_THREE = nAbs ["s","z"] (Application (Variable"s") (Application (Variable"s")(Application (Variable"s")(Variable"z")  ) ) )
l_FOUR = nAbs ["s","z"] (Application (Variable"s") (Application(Variable"s")(Application(Variable"s")(Application (Variable"s")(Variable"z") ) ) ) )
l_ADD = nAbs ["m","n","s","z"] (Application (Application (Variable"m")(Variable"s") )(nVar["n","s","z"]))
l_MULT = nAbs ["m","n","s","z"] (Application (Application (Variable"m") (Application (Variable"n") (Variable"s")) )(Variable"z") )


{-Use for Debug.-}
l_Church::IO()
l_Church = putStr $ concat $ map (\(x,y) -> x ++" = " ++(toString y)++ "\n") $ zip lista_nombre lista_elem
  where
    lista_elem   = [l_True,l_False,l_IF,l_AND,l_OR,l_NOT,l_ZERO,l_ONE,l_TWO,l_ADD,l_MULT]
    lista_nombre = ["True","False","IF","AND","OR","NOT","ZERO","ONE","TWO","ADD","MULT"]

l_ChurchTEST::IO()
l_ChurchTEST = putStr $ concat $ map (\(x,y)-> (toString x) ++ "=" ++ (toString y) ++ "\n" ) $zip listaNoReducida listaReducida
  where
    numberVAL=[l_ZERO,l_ONE,l_TWO]
    boolVAL=[l_True,l_False]
    listaIF= map (\x-> nApl[l_IF,x,Variable"a",Variable"b"]) boolVAL
    listaAND= map (\(x,y)-> nApl[l_AND,x,y]) [(x,y)|x<-boolVAL,y<-boolVAL]
    listaOR=map (\(x,y)-> nApl[l_OR,x,y]) [(x,y)|x<-boolVAL,y<-boolVAL]
    listaNOT= [nApl[l_NOT,l_True],nApl[l_NOT,l_False]]
    listaADD=map (\(x,y)-> nApl[l_ADD,x,y]) [(x,y)|x<-numberVAL,y<-numberVAL]
    listaMULT=map (\(x,y)-> nApl[l_MULT,x,y]) [(x,y)|x<-numberVAL,y<-numberVAL]
    listaNoReducida = listaIF++listaAND++listaOR++listaNOT++listaADD++listaMULT
    listaReducida= map (\x-> last $ normalReductions x) listaNoReducida
