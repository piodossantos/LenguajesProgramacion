connected(d,h,9).
connected(h,f,3).
connected(f,a,5).
connected(a,b,5).
connected(f,g,2).
connected(i,f,3).
path(X,Y,COSTO) :- connected(X,Y,Z),COSTO is Z.
path(X,Y,COSTO) :- connected(X,Z,C1),path(Z,Y,C2),COSTO is C1+C2.
/*Graph*/
/**Numbers**/
sumatoria(0,0):- ! .
sumatoria(N,R) :- A is N-1, sumatoria(A,Ra) , R is Ra+N.
fib(N,R):- N<2,R is N,!.
fib(N,R):- A is N-1, B is N-2 , fib(A,Ra) , fib(B,Rb) , R is Ra+Rb.
