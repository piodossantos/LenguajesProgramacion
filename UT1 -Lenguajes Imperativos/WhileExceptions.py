from InterpreteWhile import *

class WhileSyntaxException(Exception):
    def __init__(self, message):
        super(WhileSyntaxException, self).__init__(message)

class AExpException(WhileSyntaxException):
    def __init__(self, message):
        super(AExpException, self).__init__(message)

class BExpException(WhileSyntaxException):
    def __init__(self, message, ):
        super(BExpException, self).__init__(message)

class NumException(WhileSyntaxException):
    def __init__(self, message):
        super(NumException, self).__init__(message)
        
class VarException(WhileSyntaxException):
    def __init__(self, message):
        super(VarException, self).__init__(message)        

class VariableNotDeclaredException(WhileSyntaxException):
    def __init__(self, message):
        super(StmtException, self).__init__(message)

class VariableNotDeclaredException(Exception):
    def __init__(self, message):
        super(VariableNotDeclaredException, self).__init__(message)
