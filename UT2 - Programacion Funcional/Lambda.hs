import Data.List
data LambdaTerm= Variable [Char]|Application LambdaTerm LambdaTerm | Abstraction [Char] LambdaTerm
  deriving(Show,Eq)

toString::LambdaTerm->[Char]
toString (Variable v)= v
toString (Application a b)= "("++(toString a)++" "++(toString b) ++ ")"
toString (Abstraction a b)= "("++"\x3BB" ++ a ++"."++(toString b) ++ ")"



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



{- Exercise 1.5 -}

isNF::LambdaTerm->Bool
isNF x = ((length (redexes x))==1)

reduceNO::LambdaTerm->LambdaTerm
reduceNO (Variable x) = (Variable x)
reduceNO (Application (Abstraction x y) z) = substitution y x z
reduceNO (Application x y) = (Application (reduceNO x) (reduceNO y))
reduceNO (Abstraction x y) = (Abstraction x (reduceNO y))


reduceAO::LambdaTerm->LambdaTerm
reduceAO (Variable x) = (Variable x)
reduceAO (Application x y) = (Application (reduceAO x) (reduceAO y))
reduceAO (Abstraction x y) = (Abstraction x (reduceNO y))
