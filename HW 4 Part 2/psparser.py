""" Lovee's General Notes
    we get all the janky input from the file, and we have to process it by:
        break it into tokens where each token is an expression
        then take each token and actually translate it into the code that executes that input
            for each token, we convert it to an expression
            each expression has a value associated with it (the thing that will actually start the code)
            depending on what type of value it is, we can either be lazy and use normal python data types OR we have to create something 
                even tho the Literal and Name types seem redundant, it wouldn't make sense to have a class for StringExpr and Block 
                if we didn't have ones for the simple ones as well

                StringExpr and Blocks are complicated enough that they need another layer of extrapilation (I hope I am using that word right)
                so, we have the value class which has StrConsts, DictConsts, and CodeArrays

            Depending on what type of value it is, there are different operations associated with it, so each type has its own eval()
            Eval() is what will take the expression and call the functions necessary to calculate/perform the action needed 

"""

"""Parts of the lexer and parser code was adopted from https://composingprograms.com/. 
The code has been changed according to Postscript syntax. 
https://creativecommons.org/licenses/by-sa/3.0/
"""
import string
from buffer import Buffer
from elements import Literal, StringExpr,  Name, Block
from colors import *

# Constants
SYMBOL_STARTS = set(string.ascii_lowercase + string.ascii_uppercase + '_' + '/'+',')
SYMBOL_INNERS = SYMBOL_STARTS | set(string.digits + ',' + '-') 
NUMERAL = set(string.digits + '-.')
WHITESPACE = set(' \t\n\r')
DELIMITERS = set('(){}[]')
BOOLEANS =  {'true':True, 'false':False}
  
#---------------------------------------------------
#   Lexer #
#---------------------------------------------------

"""Splits the string s into tokens and returns a list of them.
>>> tokenize('/addsq { /sq {dup mul} def sq exch sq add exch sq add } def  2 3 4 addsq')  """
def tokenize(s):
    src = Buffer(s)
    tokens = []
    while True:
        token = next_token(src)
        if token is None:
            #print(RED+"tokens"+CEND,tokens)
            return tokens
        tokens.append(token)

""" Takes allowed characters only. Filters out everything else.  """
def take(src, allowed_characters):
    result = ''
    while src.current() in allowed_characters:
        result += src.pop_first()
    return result

"""Returns the next token from the given Buffer object. """
def next_token(src):
    take(src, WHITESPACE)  # skip whitespace
    c = src.current()
    if c is None:
        return None
    elif c in NUMERAL:
        literal = take(src, NUMERAL)
        try:
            return int(literal)
        except ValueError:
            try:
                return float(literal)
            except ValueError:
                raise SyntaxError("'{}' is not a numeral".format(literal))
    elif c in SYMBOL_STARTS:
        sym = take(src, SYMBOL_INNERS)
        if sym in BOOLEANS.keys():
            return BOOLEANS[sym] # FIX this for next year
        else: 
            return sym
    elif c in DELIMITERS:
        src.pop_first()
        return c
    else:
        raise SyntaxError("'{}' is not a token".format(c))

#---------------------------------------------------
#   Parser #
#---------------------------------------------------

# Helper functions for the parser.

""" Checks if the given token is a literal - primitive constant value. """
def is_literal(s):
    return isinstance(s, int) or isinstance(s, float) or isinstance(s,bool) 

""" Checks if the given token is a variable or function name. 
    The name can either be: 
    - a name constant (where the first character is /) or 
    - a variable, function, or built-in operator  """
def is_name(s):
    return isinstance(s, str) and s not in DELIMITERS

""" Returns the constant string enclosed within matching () paranthesis. """
def read_str_constant(src):
    s = []
    while src.current() != ')':
        if src.current() is None:
            raise SyntaxError("String doesn't have a matching `)`!")
        s.append(str(src.pop_first()))
    "Pop the `)`."
    src.pop_first()
    "Will insert ` ` between tokens."    
    return '(' + ' '.join(s) + ')'

""" Returns the constant code array enclosed within matching  {} paranthesis.  """
def read_block_expr(src):
    s = []
    while src.current() != '}':
        if src.current() is None:
            raise SyntaxError("Doesn't have a matching '{}'!".format('}'))
        s.append(read_expr(src))
    "Pop the `}`."
    src.pop_first()
    return s    

""" Converts the next token in the given Buffer to an expression. """
def read_expr(src):
    token = src.pop_first()
    if token is None:
        raise SyntaxError('Incomplete expression')
        
    #   if the token is a literal return a `Literal` object having `value` token.
    elif is_literal(token):
        return Literal(token)
    #   if the token is a string delimiter (i.e., '('), get all tokens until the matching ')' delimiter and combine them as a Python string; 
    #       create a StringExpr object having this string value. 
    elif token == '(':
        tempString = read_str_constant(src)
        return StringExpr(tempString)
    #   if the token is a name, create a Name object having `var_name` token. 
    # names are weird because they can be the definition or the function call 
    # I am not sure if I want to handle it here or later though but this feels to clean to mess up 
    # it tells you hw to do it in elements. py when you evaluate it
    elif is_name(token):
        return Name(token)
    #   if the token is a code-array delimiter (i.e., '{'), get all tokens until the matching '}' delimiter and combine them as a Python list; 
    #       create a Block object having this list value.       
    elif token == '{':
        tempCodeBlock = read_block_expr(src)
        return Block(tempCodeBlock)
    else:
        raise SyntaxError("'{}' is not the start of an expression".format(token))

"""Parse an expression from a string. If the string does not contain an
   expression, None is returned. If the string cannot be parsed, a SyntaxError
   is raised.
"""
def read(s):
    #reading one token at a time
    src = Buffer(tokenize(s))  
    out = []
    while src.current() is not None:
        out.append(read_expr(src))
    #print(OKGREEN+'out'+CEND,out)
    return out