person(ana, female).
person(betty, female).
person(carlos, male).
person(diego, male).
person(esther, female).
person(franco, male).
person(gaston, male).
person(hector, male).
person(ignacio, male).
person(juana, female).
person(kelly, female).
person(luis, male).
person(maria, female).
person(natalia, female).
person(oscar, male).
person(pia, female).
person(quique, male).
person(raul, male).
person(sofia, female).
person(tomas, male).
%%Hijo/a,madre, padre.
parents(betty, ana, diego).
parents(carlos, ana, diego).
parents(gaston, esther, franco).
parents(hector, betty, gaston).
parents(ignacio, betty, gaston).
parents(luis, juana, ignacio).
parents(maria, juana, ignacio).
parents(natalia, kelly, hector).
parents(pia, natalia, oscar).
parents(raul, maria, quique).
parents(sofia, maria, quique).
parents(tomas, maria, quique).

married(ana, diego).
married(esther, franco).
married(betty, gaston).
married(juana, ignacio).
married( kelly, hector).
married(natalia, oscar).
married( maria, quique).
/*Ejercicios*/
%%
mother(X,Y):- person(X,female), parents(Y,X,_).
father(X,Y):- person(X,male), parents(Y,_,X).
sibling(X,Y):- parents(X,W,Z), parents(Y,W,Z), X\=Y.
%% X es hija de Y.
daughter(X,Y):- person(X,female), parents(X,Y,_).
daughter(X,Y):- person(X,female), parents(X,_,Y).
%%x es hijo de y.
son(X,Y):-person(X,male), parents(X,Y,_).
son(X,Y):-person(X,male), parents(X,_,Y).
%x es hermana de y.
sister(X,Y):- person(X,female),sibling(X,Y).
%x es hermano de y.
brother(X,Y):-person(X,male),sibling(X,Y).
%%X es tia de Y.
aunt(X,Y):-person(X,female),parents(Y,M,_),sister(X,M).
aunt(X,Y):-person(X,female),parents(Y,_,F),sister(X,F).
%%X es tio de Y.
uncle(X,Y):-person(X,male),parents(Y,M,_),brother(X,M).
uncle(X,Y):-person(X,male),parents(Y,_,F),brother(X,F).

%%grandparents.
%% nieto tiene abuela Abuela y abuelo Abuelo.
grandparents(Nieto,Abuela,Abuelo):-
  grandfather(Abuelo,Nieto),
  grandmother(Abuela,Nieto).

%%grandfather.
%% x es abuelo de y.
grandfather(Abuelo,Hija) :- person(Abuelo,male), parents(Alguien,_,Abuelo), daughter(Hija,Alguien).
grandfather(Abuelo,Hijo) :- person(Abuelo,male), parents(Alguien,_,Abuelo), son(Hijo,Alguien).

%%grandmother.
%% x es abuela de y.
grandmother(Abuela,Hija) :- person(Abuela,female), parents(Alguien,Abuela,_), daughter(Hija,Alguien).
grandmother(Abuela,Hijo) :- person(Abuela,female), parents(Alguien,Abuela,_), son(Hijo,Alguien).
%%ancestor.
%% x es ancestro de y. (tiene como padre o abuelo o Bisabuelo....)
ancestor(Ancestro,Desendiente):- parents(Desendiente,_,Ancestro);parents(Desendiente,Ancestro,_).
ancestor(Ancestro,Desendiente):-
  parents(Desendiente,Madre,_),ancestor(Ancestro,Madre).
ancestor(Ancestro,Desendiente):-
  parents(Desendiente,_,Padre),ancestor(Ancestro,Padre).
%%desendiente.
descendant(Desendiente,Ancestro):-
  ancestor(Ancestro,Desendiente).



/*Prueba
?- mother(ana,A).
La respuesta debe ser betty y carlos.
?- father(diego,A).
La respuesta debe ser betty y carlos.
?- daughter(betty,X).
Ana y Diego.
?- son(carlos,X).
Ana y Diego.
?- sibling(betty,X).
Carlos.
?- sister(betty,carlos).
true.
?- brother(carlos,X).
X=betty.
?- uncle(X,Y).
X = carlos,
Y = hector ;
X = carlos,
Y = ignacio ;
X = luis,
Y = raul ;
X = luis,
Y = sofia ;
X = luis,
Y = tomas ;
X = hector,
Y = luis ;
X = hector,
Y = maria ;
X = ignacio,
Y = natalia ;
?- grandparents(X,Y,Z).
X = natalia,
Y = betty,
Z = gaston ;
X = maria,
Y = betty,
Z = gaston ;
X = pia,
Y = kelly,
Z = hector ;
X = sofia,
Y = juana,
Z = ignacio ;
X = hector,
Y = ana,
Z = diego ;
X = hector,
Y = esther,
Z = diego ;
X = ignacio,
Y = ana,
Z = diego ;
X = ignacio,
Y = esther,
Z = diego ;
X = hector,
Y = ana,
Z = franco ;
X = hector,
Y = esther,
Z = franco ;
X = ignacio,
Y = ana,
Z = franco ;
X = ignacio,
Y = esther,
Z = franco ;
X = luis,
Y = betty,
Z = gaston ;
X = raul,
Y = juana,
Z = ignacio ;
X = tomas,
Y = juana,
Z = ignacio ;
grandfather(hector,Y).
grandmother(betty,JXZ).
ancestor(franco,hector).
*/
