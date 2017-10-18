
%%TDA Arbol Binario.
nil().
tree(_,Izq,Der):- isTree(Izq),isTree(Der).
isTree(nil()).
isTree(tree(_,_,_)).

%%Calcula la altura del arbol
height(nil(),0).
height(tree(_,Izq,Der),Resultado):- height(Izq,X),height(Der,Y),Resultado is 1 + max(X,Y) .


%% example.
%%tree(2,tree(1,nil(),nil()),tree(3,tree(4,nil(),nil()),tree(5,nil(),nil()))).


%% Preorden.
preorder(nil(),[]).
preorder(tree(Valor,Izq,Der), [Valor|Z]):-
  preorder(Izq,PreIzq),
  preorder(Der,PreDer),
  append(PreIzq,PreDer,Z).
%% Postorden.
postorder(nil(),[]).
postorder(tree(Valor,Izq,Der),Resultado):-
  postorder(Izq,PreIzq),
  postorder(Der,PreDer),
  append(PreIzq,PreDer,Z),
  append(Z,[Valor],Resultado).
%% Inorden.
inorder(nil(),[]).
inorder(tree(Valor,Izq,Der),Resultado):-
  inorder(Izq,PreIzq),
  inorder(Der,PreDer),
  append(PreIzq,[Valor],Z),
  append(Z,PreDer,Resultado).
