from InterpreteWhile import *
from WhileExceptions import *

def test1():
    a=Num(5)
    b=Var("hola")
    c=Assignment(b,a)
    c.eval()
    print(a)
    print(b)
    print(c)
    print(state)

def test2():
    ## Este programa recibe dos numeros,
    ## lo q hace es mientras a>b resta 1 a a y suma 1 a b.

    a=Num(410)
    b=Num(-103)
    c=Var("VARIABLE_1")
    d=Var("VARIABLE_2")
    e=Assignment(c,a)
    f=Assignment(d,b)
    g=Concat(e,f)
    h=Concat(Skip(),g)
    ##Armo flujo do.
    ##Sumo 1 a fruta2 y resto 1 a fruta1
    i=Sub(c,Num(1))
    ii=Assignment(c,i)
    j=Sum(d,Num(1))
    jj=Assignment(d,j)
    k=Concat(ii,jj)
    ##armo cond.
    l=LowEq(c,d)
    m=Neg(l)
    n=While(m,k)
    ##junto ToDo
    o=Concat(h,n)
    print(o)
    o.eval()
    print(state)


##PROGRAMA Principal
test2()
