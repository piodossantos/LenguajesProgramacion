from InterpreteWhile import *
from WhileExceptions import *

def test1():
    print("\n Test 1 \n")
    state = {}
    a = Num(5)
    b = Var("hola")
    c = Assignment(b,a)
    c.eval(state)
    print(a)
    print(b)
    print(c)
    print(state)

def test2():
    print("\n Test 2 \n")

    ## Input: 2 numeros
    ## Mientras a > b resta 1 a a y suma 1 a b.
    state = {}
    a = Num("8383.78")
    b = Num(-6.5)
    c = Var("VARIABLE_1")
    d = Var("VARIABLE_2")
    e = Assignment(c,a)
    f = Assignment(d,b)
    g = Concat(e,f)
    h = Concat(Skip(),g)

    #Flujo do.
    #Sumo 1 a fruta2 y resto 1 a fruta1
    i = Sub(c,Num(1))
    ii = Assignment(c,i)
    j = Sum(d,Num(1))
    jj = Assignment(d,j)
    k = Concat(ii,jj)

    # Condition.
    l = LowEq(c,d)
    m = Neg(l)
    n = While(m,k)

    # Juntamos las partes
    o = Concat(h,n)
    print(o)
    o.eval(state)
    print(state)

def test3():
    print("\n Test 3 \n")
    state = {}
    a = And(TruthValue("falsE"), TruthValue("tRue"))
    b = Concat(Skip(), Skip())
    b1 = Assignment(Var("aaa"), Num("-77"))
    c = If(b,Assignment(Var("hello"), Var("aaa")), a)
    d = Concat(b1, c)
    print("\n" + str(d) + "\n")
    d.eval(state)
    print(state)

def test4():
    print("\n Test 4 \n")
    state = {}
    a = If((Assignment(Var("prueba"),Num(-4))),
           (Skip()),
           Equal(TruthValue(True),TruthValue("true")))
    b = Assignment(Var("prueba"),
                   Mul(Var("prueba"), Var("prueba")))
    c = Concat(a, b)
    print(c)
    c.eval(state)
    print(state)
def test5():
    state={}

    a=Assignment(Var("z"),Num(1))
    b=Assignment(Var("y"),Sub(Var("y"),Var("z")))
    c=Block([a,b])
    cond=LowEq(Var("y"),Num(0))
    w= While(cond,c)
    as1=Assignment(Var("x"),Num(1))
    as2=Assignment(Var("y"),Num(2))
    j=Assignment(Var("x"),Mul(Var("z"),Num(2)))
    final=Block([as1,as2,w,j])
    print(final)
    final.eval(state)
    print(state)


#MAIN
test5()
