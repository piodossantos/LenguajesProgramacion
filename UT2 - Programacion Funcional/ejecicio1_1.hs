data Expresion = Numero Int |Suma Expresion Expresion |Producto Expresion Expresion
  deriving (Eq)

instance Show Expresion where
  show a = toString a

evaluate::Expresion -> Int
evaluate (Numero n)=n
evaluate (Suma a b)= (evaluate a) + (evaluate b)
evaluate (Producto a b)= (evaluate a) * (evaluate b)

toString::Expresion -> [Char]
toString (Numero n)= show n
toString (Suma a b)= "(" ++ (toString a) ++ " + " ++ (toString b) ++ ")"
toString (Producto a b)= "(" ++  (toString a) ++ " * " ++ (toString b)  ++ ")"
