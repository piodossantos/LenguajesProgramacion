from WhileExceptions import *

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

class Num():

    value = 0

    def __init__(self, value):
        temp=str(value).lstrip('-').replace(".","",1)
        if(not (temp.isnumeric())):
            raise NumException('Value = {} is not a numerical value.'.format(value));
        self.value = float(value)

    def __str__(self):
        return str(self.value)

    def eval(self):

        return self.value

class Var():
    name = None

    #constructor
    def __init__(self, name):
        if(type(name) not in [chr,str]):
            raise VarException('{} is not a char/String value'.format(name))
        AExp.__init__(self)
        self.name = name

    def __str__(self):
        return str(self.name)

    def eval(self):
        temp= state.get(self.name)
        if (temp is None):
            raise VariableNotDeclaredException('{} is not initialized'.format(name))
        return temp


class Sum(AExp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if (not (isinstance(op1,AExp) or isinstance(op1,Num) or isinstance(op1,Var))):
            raise WhileSyntaxException('op1 = {} is not a AExp,Var or Num Value'.format(op1))

        if (not (isinstance(op2,AExp) or isinstance(op2,Num) or isinstance(op2,Var))):
            raise WhileSyntaxException('op2 = {} is not a AExp,Var or Num Value'.format(op2))

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
        if (not (isinstance(op1,AExp) or isinstance(op1,Num) or isinstance(op1,Var))):
            raise AExpException('op1 = {} is not a AExp,Var or Num Value'.format(op1))

        if (not (isinstance(op2,AExp) or isinstance(op2,Num) or isinstance(op2,Var))):
            raise AExpException('op2 = {} is not a AExp,Var or Num Value'.format(op2))

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
        if (not (isinstance(op1,AExp) or isinstance(op1,Num) or isinstance(op1,Var))):
            raise AExpException('op1 = {} is not a AExp,Var or Num Value'.format(op1))

        if (not (isinstance(op2,AExp) or isinstance(op2,Num) or isinstance(op2,Var))):
            raise AExpException('op2 = {} is not a AExp,Var or Num Value'.format(op2))

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

        if ( not ( isinstance(value,bool)  or (str(value).upper() in ["TRUE","FALSE"]))):
            raise BExpException('value = {} is not a boolean value'.format(str(value).upper()))
        if (str(value).upper()=="FALSE"):
            value=""
        value = bool(value)
        self.value = value

    def eval(self):
        return self.value

    def __str__(self):
        if(self.value):
            return "tt"
        return "ff"

class Equal(BExp):

    op1, op2 = False, False

    def __init__(self,op1,op2):
        if (not(isinstance(op1,BExp) or isinstance(op1,Var) or isinstance(op1,Num) or isinstance(op1,AExp))):
            raise BExpException('op1 = {} is not a BExp Value'.format(op1))

        if (not(isinstance(op2,BExp) or isinstance(op2,Var) or isinstance(op2,Num) or isinstance(op2,AExp))):
            raise BExpException('op2 = {} is not a BExp Value'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} = {})'.format(str(self.op1),str(self.op2))


    def eval(self):
        return (self.op1.eval()) == (self.op2.eval())

class LowEq(BExp):

    op1, op2 = False, False

    def __init__(self,op1,op2):
        if (not(isinstance(op1,BExp) or isinstance(op1,Var) or isinstance(op1,Num) or isinstance(op1,AExp))):
            raise BExpException('op1 = {} is not a BExp Value'.format(op1))

        if (not(isinstance(op2,BExp) or isinstance(op2,Var) or isinstance(op2,Num) or isinstance(op2,AExp))):
            raise BExpException('op2 = {} is not a BExp Value'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} <= {})'.format(str(self.op1),str(self.op2))


    def eval(self):
        return (self.op1.eval()) <= (self.op2.eval())

class And(BExp):

    op1, op2 = False, False

    def __init__(self, op1, op2):
        if (not(isinstance(op1,BExp) or isinstance(op1,Var) or isinstance(op1,Num) or isinstance(op1,AExp))):
            raise BExpException('op1 = {} is not a BExp Value'.format(op1))

        if (not(isinstance(op2,BExp) or isinstance(op2,Var) or isinstance(op2,Num) or isinstance(op2,AExp))):
            raise BExpException('op2 = {} is not a BExp Value'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} and {})'.format(str(self.op1),str(self.op2))


    def eval(self):
        return (self.op1.eval()) and (self.op2.eval())

class Neg(BExp):

    op1 = False

    def __init__(self, op1):
        if (not(isinstance(op1,BExp))):
            raise BExpException('op1 = {} is not a BExp Value'.format(op1))

        self.op1 = op1

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

    do=Skip()

    def __init__(self, cond, do):
        if(not(isinstance(cond,BExp))):
            raise BExpException('cond = {} is not a BExp Value'.format(cond))

        if(not(isinstance(do,Stmt))):
            raise StmtException('do = {} is not a Statement'.format(do))

        self.do = do
        self.cond = cond

    def __str__(self):
        return 'while ({}) do ({})'.format(str(self.cond),str(self.do))

    def eval(self):
        while(self.cond.eval()):
            self.do.eval()
        #Definicion alternativa, pero menos eficiente
##        s1= Concat(self.DO,self)
##        resultado = If(s1,Skip(),self.cond)
##        resultado.eval()

class Concat(Stmt):

    s1, s2 = Skip(), Skip()

    def __init__(self,s1,s2):

        if(not(isinstance(s1,Stmt))):
            raise StmtException('s1 = {} is not a Statement'.format(s1))
        if(not(isinstance(s2,Stmt))):
            raise StmtException('s2 = {} is not a Statement'.format(s2))

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
        if(not(isinstance(s1,Stmt))):
            raise StmtException('s1 = {} is not a Statement'.format(s1))
        if(not(isinstance(s2,Stmt))):
            raise StmtException('s2 = {} is not a Statement'.format(s2))
        if(not(isinstance(cond,BExp))):
            raise BExpException('cond = {} is not a BExp Value'.format(cond))

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
        if(not(isinstance(op1,Var))):
            raise VarException('op1 = {} is not a Var.'.format(op1))
        if(not(isinstance(op2,AExp) or isinstance(op2,Var) or isinstance(op2,Num))):
            raise WhileSyntaxException('op2 = {} is not a Var,Num or AExp'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '{} := {}'.format(str(self.op1),str(self.op2))


    def eval(self):
        state[str(self.op1)] = self.op2.eval()

###programa Principal
