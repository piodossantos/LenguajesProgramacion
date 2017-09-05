from InterpreteWhile import *

class WhileSyntaxException(Exception):
    def __init__(self, message):
        super(WhileSyntaxException, self).__init__(message)

class ExpException(WhileSyntaxException):
    def __init__(self, message):
        super(ExpException, self).__init__(message)



class StmtException(WhileSyntaxException):
    def __init__(self, message):
        super(StmtException, self).__init__(message)

class VariableNotDeclaredException(Exception):
    def __init__(self, message):
        super(VariableNotDeclaredException, self).__init__(message)

class ReturnException(WhileSyntaxException):
    state={}
    retValue=0
    def __init__(self, message,state, retValue):
        #super(StmtException, self).__init__(message)
        self.state=state
        self.retValue=retValue
