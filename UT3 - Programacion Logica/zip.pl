%%pair(X,Y,Tupla)
pair(X,Y,(X,Y)).

%% zip(+lista1,+lista2,-Salida).
zip([],_,[]):-!.
zip(_,[],[]):-!.
zip([X|Xs],[Y|Ys],[Cabeza|Cola]):-pair(X,Y,Cabeza),zip(Xs,Ys,Cola).


%%Version 2 mas bonita.
pair2(_,_).
zip2([],_,[]):-!.
zip2(_,[],[]):-!.
zip2([X|Xs],[Y|Ys],[(X,Y)|Cola]):- zip2(Xs,Ys,Cola).
