######### DATA STRUCTURES #####################
#                                             #
# Data structures needed for the interperter. #
# Base classes: AExp, BExp, Stmt.             #
#                                             #
###############################################

state={}

class AExp:

    #constructor
    def __init__(self):
        pass

    def __repr__(self):
        return str(self)


class BExp:

    #constructor
    def __init__(self):
        pass

    def __repr__(self):
        return str(self)
class Stmt:

    #constructor
    def __init__(self):
        pass

    def __repr__(self):
        return str(self)

#ToDo: Hay que seguir agregando los prints para cada tipo

class Num(AExp):
    value = 0

    #constructor2
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return str(self.value)

    def eval(self):
        return self.value

class Var(AExp):
    name = None

    #constructor
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return str(self.name)

    def eval(self):
        return state.get(self.name,0)

class Sum(AExp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() + self.op2.eval()

    def __str__(self):
        return str("("
                   + str(self.op1)
                   + "+"
                   + str(self.op2)
                   + ")")


class Mul(AExp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() * self.op2.eval()

    def __str__(self):
        return str("("
                   + str(self.op1)
                   + "*"
                   + str(self.op2)
                   + ")")


class Sub(AExp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() - self.op2.eval()

    def __str__(self):
        return str("("
                   + str(self.op1)
                   + "-"
                   + str(self.op2)
                   + ")")


class TruthValue(BExp):
    value = False

    #constructor
    def __init__(self,value):
        self.value = value

    def eval(self):
        return value

    def __str__(self):
        if(self.value):
            return "tt"
        return "ff"

class Equal(BExp):
    op1, op2 = False, False

    def __init__(self,op1,op2):
        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return str("("
                   + str(self.op1)
                   + "="
                   + str(self.op2)
                   + ")")

    def eval(self):
        return (self.op1.eval()) == (self.op2.eval())

class LowEq(BExp):
        op1, op2 = False, False

        def __init__(self,op1,op2):
            self.op1 = op1
            self.op2 = op2

        def __str__(self):
            return str("("
                       + str(self.op1)
                       + "<="
                       + str(self.op2)
                       + ")")

        def eval(self):
            return (self.op1.eval()) <= (self.op2.eval())

class And(BExp):
        op1, op2 = False, False

        def __init__(self,op1,op2):
            self.op1 = op1
            self.op2 = op2

        def __str__(self):
            return str("("
                       + str(self.op1)
                       + "&"
                       + str(self.op2)
                       + ")")

        def eval(self):
            return (self.op1.eval()) and (self.op2.eval())

class Neg(BExp):
        op1=False

        def __init__(self,op1):
            self.op1=op1

        def __str__(self):
            return str("(¬"
                       + str(self.op1)
                       + ")")

        def eval(self):
            return not(self.op1.eval())

class While(Stmt):
    cond=False
    DO=""

    def __init__(self, cond, DO):
        self.DO = DO
        self.cond = cond

    def __str__(self):
        return str("( While "
                   +str(self.cond)
                   +" do ("+str(self.DO)
                   +"))")

    def eval(self):
        while(self.cond.eval()):
            self.DO.eval()

class Skip(Stmt):
    def __init__(self):
        pass
    def __str__(self):
        return "Skip"
    def eval(self):
        return

class Concat(Stmt):

    s1, s2 = Skip(), Skip()

    def __init__(self,s1,s2):
        self.s1 = s1
        self.s2 = s2

    def eval(self):
        self.s1.eval()
        self.s2.eval()
        
    def __str__(self):
        return str(str(self.s1)
                   +" ; "
                   +str(self.s2))

class If(Stmt):
    cond = False
    s1, s2 = Skip(), Skip()

    def __init__(self, s1, s2, cond):
        self.s1 = s1
        self.s2 = s2
        self.cond = cond

    def __init__(self, s1, cond):
        self.s1 = s1
        self.cond = cond

    def __str__(self):
        return str("(if "
                   +str(self.cond)
                   +" then "
                   +str(self.s1)
                   +" else "
                   +str(self.s2)+")")

    def eval(self):
        if(self.cond.eval()):
            self.s1.eval()
        else:
            self.s2.eval()

class Assignment(Stmt):
    op1, op2 = "", 0

    def __init__(self, op1, op2):
        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return str("("
                   +str(self.op1)
                   +":="
                   +str(self.op2)
                   +")")

    def eval(self):
        state[str(self.op1)] = self.op2.eval()

###programa Principal
