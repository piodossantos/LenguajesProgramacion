from WhileExceptions import *


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

    ##def get_class(self):
##        return 'AExp'

class BExp:

    #constructor
    def __init__(self):
        pass

    def __repr__(self):
        return str(self)

    ##def get_class(self):
        ##return 'BExp'
    
class Stmt:

    #constructor
    def __init__(self):
        pass

    def __repr__(self):
        return str(self)

#Sub classes

class Num(AExp):

    value = 0

    def __init__(self, value):
        if(not (type(value) in [float,int])):
            raise AExpException("Value is not a numerical value.\n");
        self.value = value

    def __str__(self):
        if(not (type(self.value) in [float,int])):
            raise AExpException('{} is not a numerical value'.format(self.value));
        return str(self.value)

    def eval(self):
        if(not (type(self.value) in [float,int])):
            raise AExpException('{} is not a numerical value'.format(self.value));
        return self.value

class Var(AExp):
    name = None

    #constructor
    def __init__(self, name):
        if(type(name) not in [chr,str]):
            raise AExpException('{} is not a char/String value'.format(name))
        self.name = name

    def __str__(self):
        if(type(self.name) not in [chr,str]):
            raise AExpException('{} is not a char/String value'.format(self.name))
        return str(self.name)

    def eval(self):
        if(type(self.name) not in [chr,str]):
            raise AExpException('{} is not a char/String value'.format(self.name))
        return state.get(self.name,0)

class Sum(AExp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if(type(op1).__name__ != "AExp"):
            raise AExpException('op1 = {} is not a AExp Value'.format(op1))
        
        if(type(op2).__name__  != "AExp"):
            raise AExpException('op1 = {} is not a AExp Value'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() + self.op2.eval()

    def __str__(self):
        return '({} + {})'.format(str(self.op1),str(self.op2))

class Mul(AExp):

    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if(type(op1).__name__ != "AExp"):
            raise AExpException('op1 = {} is not a AExp Value'.format(op1))
        
        if(type(op2).__name__  != "AExp"):
            raise AExpException('op2 = {} is not a AExp Value'.format(op2))
        
        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() * self.op2.eval()

    def __str__(self):
        return '({} * {})'.format(str(self.op1),str(self.op2))

class Sub(AExp):

    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if(type(op1).__name__  != "AExp"):
            raise AExpException('op1 = {} is not a Num Value'.format(op1))
        
        if(type(op2).__name__   != "AExp"):
            raise AExpException('op2 = {} is not a Var Value'.format(op2))
        
        self.op1 = op1
        self.op2 = op2

    def eval(self):
        return self.op1.eval() - self.op2.eval()

    def __str__(self):
        return '({} - {})'.format(str(self.op1),str(self.op2))

class TruthValue(BExp):

    value = False

    #constructor
    def __init__(self,value):
        
        if(type(value).__name__   != "BExp"):
            raise BExpException('value = {} is not a BExp Value'.format(value))
        
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
        if(type(op1).__name__  != "BExp"):
            raise AExpException('op1 = {} is not a BExp Value'.format(op1))
        
        if(type(op2).__name__   != "BExp"):
            raise AExpException('op2 = {} is not a BExp Value'.format(op2))
        
        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} = {})'.format(str(self.op1),str(self.op2))


    def eval(self):
        return (self.op1.eval()) == (self.op2.eval())

class LowEq(BExp):

        op1, op2 = False, False

        def __init__(self,op1,op2):
            self.op1 = op1
            self.op2 = op2

        def __str__(self):
            return '({} <= {})'.format(str(self.op1),str(self.op2))


        def eval(self):
            return (self.op1.eval()) <= (self.op2.eval())

class And(BExp):

        op1, op2 = False, False

        def __init__(self,op1,op2):
            self.op1 = op1
            self.op2 = op2

        def __str__(self):
            return '({} and {})'.format(str(self.op1),str(self.op2))


        def eval(self):
            return (self.op1.eval()) and (self.op2.eval())

class Neg(BExp):

        op1 = False

        def __init__(self,op1):
            self.op1=op1

        def __str__(self):
            return '¬({})'.format(str(self.op1))


        def eval(self):
            return not(self.op1.eval())

class Skip(Stmt):

    def __init__(self):
        ...

    def __str__(self):
        return "skip"

    def eval(self):
        ...

class While(Stmt):

    cond=False

    DO=Skip()

    def __init__(self, cond, DO):
        self.DO = DO
        self.cond = cond

    def __str__(self):
        return 'while ({}) do ({})'.format(str(self.cond),str(self.DO))

    def eval(self):
        s1= Concat(self.DO,self)
        resultado = If(s1,Skip(),self.cond)
        resultado.eval()

class Concat(Stmt):

    s1, s2 = Skip(), Skip()

    def __init__(self,s1,s2):
        self.s1 = s1
        self.s2 = s2

    def eval(self):
        self.s1.eval()
        self.s2.eval()

    def __str__(self):
        return '({} ; {})'.format(str(self.s1),str(self.s2))

class If(Stmt):
    cond = False
    s1, s2 = Skip(), Skip()

    def __init__(self, s1, s2, cond):
        self.s1 = s1
        self.s2 = s2
        self.cond = cond

    def __str__(self):
        return 'if {} then ({}) else ({})'.format(str(self.cond),str(self.s1),str(self.s2))

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
        return '{} := {}'.format(str(self.op1),str(self.op2))


    def eval(self):
        state[str(self.op1)] = self.op2.eval()

###programa Principal
