data LambdaTerm= Variable [Char]|Application LambdaTerm LambdaTerm | Abstraction [Char] LambdaTerm
  deriving(Show,Eq)

toString::LambdaTerm->[Char]
toString (Variable v)= v
toString (Application a b)= "("++(toString a)++" "++(toString b) ++ ")"
toString (Abstraction a b)= "("++"\x3BB" ++ a ++"."++(toString b) ++ ")"



caso1 = toString (Variable "x")
caso2 = toString (Application (Variable "y") (Variable "z"))
caso3 = toString (Abstraction "w" (Variable "w") )
caso4 = toString (Abstraction "a" (Abstraction "b"  (Application (Variable "a") (Variable "b"))))
caso5 = toString (Abstraction "c" (Abstraction "a" (Abstraction "b"  (Application (Variable "a") (Variable "b")))))
caso6 = toString (Abstraction "x" (Application (Variable("x")) (Variable("x"))))
caso7 = toString (Abstraction "x" (Variable("x")) )
caso8 = toString (Abstraction "a" (Abstraction "b"  (Variable "a") ))
caso9 = toString (Variable "y")
caso10 = toString (Variable "w")


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
substitution (Abstraction x y) v s = if x/=v then (Abstraction x y ) else (substitution y v s)
