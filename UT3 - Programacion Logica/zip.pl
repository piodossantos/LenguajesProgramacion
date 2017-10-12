%%pair(X,Y,Tupla)
pair(X,Y,(X,Y)).

%% zip(+lista1,+lista2,-Salida).
zip([],_,[]):-!.
zip(_,[],[]):-!.
zip([X|Xs],[Y|Ys],[Cabeza|Cola]):-pair(X,Y,Cabeza),zip(Xs,Ys,Cola).
