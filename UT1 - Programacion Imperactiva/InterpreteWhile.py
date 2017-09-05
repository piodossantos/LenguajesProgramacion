from WhileExceptions import *

# Base classes
class Exp:

    #constructor
    def __init__(self):
        ...

    def __repr__(self):
        return self.__str__()


class Stmt:

    #constructor
    def __init__(self):
        ...

    def __repr__(self):
        return self.__str__()

#Sub classes
class Num(Exp):
    value = 0

    def __init__(self, value):
        temp = str(value).lstrip('-').replace(".","",1)
        if(not (temp.isnumeric())):
            raise NumException('Value = {} is not a numerical value.'
                               .format(value));

        self.value = float(value)

    def __str__(self):
        return str(self.value)

    def eval(self,state):
        return self.value

class Var(Exp):
    name = None

    #constructor
    def __init__(self, name):
        if(type(name) not in [chr,str]):
            raise VarException('{} is not a char/String value'
                               .format(name))
        Exp.__init__(self)
        self.name = name

    def __str__(self):
        return str(self.name)

    def eval(self,state):
        temp = state.get(self.name)
        if (temp is None):
            raise VariableNotDeclaredException('{} is not initialized'
                                               .format(name))
        return temp


class Sum(Exp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if (not (isinstance(op1,Exp)
                 or isinstance(op1,Num)
                 or isinstance(op1,Var))):
            raise WhileSyntaxException('op1 = {} is not a Exp,Var or Num Value'
                                       .format(op1))

        if (not (isinstance(op2, Exp)
                 or isinstance(op2, Num)
                 or isinstance(op2, Var))):
            raise WhileSyntaxException('op2 = {} is not a Exp,Var or Num Value'
                                       .format(op2))

        self.op1 = op1
        self.op2 = op2

    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if( (isinstance(a,bool) or isinstance(b,bool) )):
            raise  WhileSyntaxException('Invalid args')
        return a+b

    def __str__(self):
        return '({} + {})'.format(str(self.op1),str(self.op2))

class Mul(Exp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if (not (isinstance(op1, Exp)
                 or isinstance(op1, Num)
                 or isinstance(op1, Var))):
            raise ExpException('op1 = {} is not a Exp,Var or Num Value'
                                .format(op1))

        if (not (isinstance(op2, Exp)
                 or isinstance(op2, Num)
                 or isinstance(op2,Var))):
            raise ExpException('op2 = {} is not a Exp,Var or Num Value'
                                .format(op2))

        self.op1 = op1
        self.op2 = op2

    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if( (isinstance(a,bool) or isinstance(b,bool) )):
            raise  WhileSyntaxException('Invalid args')
        return a*b

    def __str__(self):
        return '({} * {})'.format(str(self.op1),str(self.op2))

class Sub(Exp):
    op1, op2 = 0, 0

    #constructor
    def __init__(self, op1, op2):
        if (not (isinstance(op1, Exp)
                 or isinstance(op1, Num)
                 or isinstance(op1, Var))):
            raise ExpException('op1 = {} is not a Exp,Var or Num Value'
                                .format(op1))

        if (not (isinstance(op2, Exp)
                 or isinstance(op2, Num)
                 or isinstance(op2, Var))):
            raise ExpException('op2 = {} is not a Exp,Var or Num Value'
                                .format(op2))

        self.op1 = op1
        self.op2 = op2

    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if((isinstance(a,bool) or isinstance(b,bool) )):
            raise  WhileSyntaxException('Invalid args')
        return a-b

    def __str__(self):
        return '({} - {})'.format(str(self.op1),str(self.op2))

class TruthValue(Exp):
    value = False

    #constructor
    def __init__(self,value):

        if ( not ( isinstance(value,bool)  or (str(value).upper() in ["TRUE","FALSE"]))):
            raise ExpException('value = {} is not a boolean value'.format(str(value).upper()))
        if (str(value).upper()=="FALSE"):
            value=""
        value = bool(value)
        self.value = value

    def eval(self,state):
        return self.value

    def __str__(self):
        if(self.value):
            return "tt"
        return "ff"

class Equal(Exp):
    op1, op2 = False, False

    def __init__(self, op1, op2):
        if (not(isinstance(op1, Exp)
                or isinstance(op1, Var)
                or isinstance(op1, Num)
                or isinstance(op1, Exp))):
            raise ExpException('op1 = {} is not a Exp Value'
                                .format(op1))

        if (not(isinstance(op2,Exp)
                or isinstance(op2,Var)
                or isinstance(op2,Num)
                or isinstance(op2,Exp))):
            raise ExpException('op2 = {} is not a Exp Value'.format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} = {})'.format(str(self.op1),str(self.op2))


    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if(( (isinstance(a,bool) or isinstance(b,bool)) ) and (not (isinstance(a,bool) and isinstance(b,bool)) )):
            raise  WhileSyntaxException('Invalid args')
        return (self.op1.eval(state)) == (self.op2.eval(state))

class LowEq(Exp):
    op1, op2 = False, False

    def __init__(self, op1, op2):
        if (not(isinstance(op1, Exp)
                or isinstance(op1, Var)
                or isinstance(op1, Num)
                or isinstance(op1, Exp))):
            raise ExpException('op1 = {} is not a Exp Value'
                                .format(op1))

        if (not(isinstance(op2, Exp)
                or isinstance(op2, Var)
                or isinstance(op2, Num)
                or isinstance(op2, Exp))):
            raise ExpException('op2 = {} is not a Exp Value'
                                .format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} <= {})'.format(str(self.op1), str(self.op2))


    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if(( (isinstance(a,bool) or isinstance(b,bool)) ) and (not (isinstance(a,bool) and isinstance(b,bool)) )):
            raise  WhileSyntaxException('Invalid args')
        return (self.op1.eval(state)) <= (self.op2.eval(state))

class And(Exp):
    op1, op2 = False, False

    def __init__(self, op1, op2):
        if (not(isinstance(op1, Exp)
                or isinstance(op1, Var)
                or isinstance(op1, Num)
                or isinstance(op1, Exp))):
            raise ExpException('op1 = {} is not a Exp Value'
                                .format(op1))

        if (not(isinstance(op2, Exp)
                or isinstance(op2, Var)
                or isinstance(op2, Num)
                or isinstance(op2, Exp))):
            raise ExpException('op2 = {} is not a Exp Value'
                                .format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '({} and {})'.format(str(self.op1), str(self.op2))


    def eval(self,state):
        a=self.op1.eval(state)
        b=self.op2.eval(state)
        if(( (isinstance(a,bool) or isinstance(b,bool)) ) and (not (isinstance(a,bool) and isinstance(b,bool)) )):
            raise  WhileSyntaxException('Invalid args')
        return (self.op1.eval(state)) and (self.op2.eval(state))

class Neg(Exp):
    op1 = False

    def __init__(self, op1):
        if (not(isinstance(op1, Exp))):
            raise ExpException('op1 = {} is not a Exp Value'.format(op1))

        self.op1 = op1

    def __str__(self):
        return '¬({})'.format(str(self.op1))


    def eval(self,state):
        a=self.op1.eval(state)
        if(not (isinstance(a,bool) )):
            raise  WhileSyntaxException('Invalid args')
        return not(self.op1.eval(state))

class Skip(Stmt):
    def __init__(self):
        ...

    def __str__(self):
        return "skip"

    def eval(self, state):
        return state

class While(Stmt):
    cond = False
    do = Skip()

    def __init__(self, cond, do):
        if(not(isinstance(cond, Exp))):
            raise ExpException('cond = {} is not a Exp Value'.format(cond))

        if(not(isinstance(do, Stmt))):
            raise StmtException('do = {} is not a Statement'.format(do))

        self.do = do
        self.cond = cond

    def __str__(self):
        return 'while ({}) do ({})'.format(str(self.cond),str(self.do))

    def eval(self,state):
        while(self.cond.eval(state)):
            self.do.eval(state)

####      Definicion alternativa, pero menos eficiente
##        s1= Concat(self.DO,self)
##        resultado = If(s1,Skip(),self.cond)
##        resultado.eval(state)

        return state

class Concat(Stmt):
    s1, s2 = Skip(), Skip()

    def __init__(self, s1, s2):
        if(not(isinstance(s1, Stmt))):
            raise StmtException('s1 = {} is not a Statement'.format(s1))
        if(not(isinstance(s2, Stmt))):
            raise StmtException('s2 = {} is not a Statement'.format(s2))

        self.s1 = s1
        self.s2 = s2

    def eval(self, state):
        self.s1.eval(state)
        self.s2.eval(state)
        return state

    def __str__(self):
        return '({} ; {})'.format(str(self.s1),str(self.s2))

class If(Stmt):
    cond = False
    s1, s2 = Skip(), Skip()

    def __init__(self, s1, s2, cond):
        if(not(isinstance(s1, Stmt))):
            raise StmtException('s1 = {} is not a Statement'
                                .format(s1))
        if(not(isinstance(s2, Stmt))):
            raise StmtException('s2 = {} is not a Statement'
                                .format(s2))
        if(not(isinstance(cond, Exp))):
            raise ExpException('cond = {} is not a Exp Value'
                                .format(cond))

        self.s1 = s1
        self.s2 = s2
        self.cond = cond

    def __str__(self):
        return 'if {} then ({}) else ({})'.format(str(self.cond), str(self.s1), str(self.s2))

    def eval(self, state):
        if(self.cond.eval(state)):
            self.s1.eval(state)
        else:
            self.s2.eval(state)
        return state

class Assignment(Stmt):
    op1, op2 = "", 0

    def __init__(self, op1, op2):
        if(not(isinstance(op1, Var))):
            raise VarException('op1 = {} is not a Var.'
                               .format(op1))

        if(not(isinstance(op2, Exp)
               or isinstance(op2,Var)
               or isinstance(op2,Num)
               or isinstance(op2,ReturnValue)
               )):
            raise WhileSyntaxException('op2 = {} is not a Var,Num, Exp or ReturnValue'
                                       .format(op2))

        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return '{} := {}'.format(str(self.op1),str(self.op2))


    def eval(self, state):
        state[str(self.op1)] = self.op2.eval(state)
        return state


class Block(Stmt):
    args=[]
    def __init__(self,lista):
        self.lista=lista
    def __str__(self):
        a="{\n"
        for elemento in self.lista:
            a+=(str(elemento)+"\n")
        a+="}"
        return a
    def eval(self,state):
        stateBlock = state.copy()
        for elemento in self.lista:
            elemento.eval(stateBlock)
        for clave in state.keys():
            state[clave]=stateBlock[clave]
        print(stateBlock)
        return state

class FunctionDeclaration(Stmt):
    ID=""
    args=[]
    body=Block([])

    def __init__(self,ID,args,body,state):
        self.ID=ID
        self.args=args
        self.body=body
        state[self.ID]=self
    def __str__(self):
        return '{}({})[]'.format(str(self.ID),str(self.args))

    def eval(self,state):
        return self.eval(state,[])

    def eval(self,state,values):
        stateBlock = state.copy()
        i=0
        for argumento in values:
            stateBlock[str(argumento)]=values[i];
            i+=1
        try:
            self.body.eval(stateBlock)
        except ReturnException as e:
            for clave in state.keys():
                state[clave]=stateBlock[clave]
            return e.retValue
        for clave in state.keys():
            state[clave]=stateBlock[clave]
        return state

class FunctionCall(Exp):
    ID=""
    args=[]

    def __init__(self,ID,args):
        self.ID=ID;
        self.args=args;
    def __str__(self):
        temporal=""
        if(self.args==[]):
            temporal="void"
        else:
            for arg in self.args:
                temporal+=str(arg)+","
            temporal=temporal.rstrip(temporal[-1:])

        return "{}({});".format(str(self.ID),str(temporal))
    def eval(self,state):
        func=state.get(self.ID)
        if(func==None):
            ...
            ##Raise error
        return func.eval(state,self.args)
class ReturnValue(Stmt):
    value=0
    def __init__(self,value):
        self.value=value
    def __str__(self):
        return "return {}".format(str(self.value))
    def eval(self,state):
        raise ReturnException(str(self), state,self.value)
