from colors import *
from elements import StrConstant, DictConstant, CodeArray

# TODO 
# 
# 

class Stacks:

    # I used this for my name stuff so I just stuck it at the top so it was easy to see
    # I was trying to do this inside the name eval but it was so ugly like that 
    def getInd(self,name):
        name = '/' + name
        index = (len(self.dictstack))-1

        if name in self.dictstack[index][1]:
            return index
        else:
            link = self.dictstack[index][0]
            while link != 0:
                if name in self.dictstack[index][1]:
                    return link
                else:
                    link = self.dictstack[link][0]
        if name in self.dictstack[link][1]:
            return link
        else:
            print ("Error - getIndex() ")

    # Adding in an extra parameter to control the scope
    # get rid of begin and end in here 
    def __init__(self, scope):
        #stack variables
        self.scope = scope
        self.opstack = []  #assuming top of the stack is the end of the list
        self.dictstack = []  #assuming top of the stack is the end of the list
        # The environment that the REPL evaluates expressions in.
        # Uncomment this dictionary in part2
        self.builtin_operators = {
            "add":self.add,
            "sub":self.sub,
            "mul":self.mul,
            "mod":self.mod,
            "eq":self.eq,
            "lt": self.lt,
            "gt": self.gt,
            "dup": self.dup,
            "exch":self.exch,
            "pop":self.pop,
            "copy":self.copy,
            "count": self.count,
            "clear":self.clear,
            "stack":self.stack,
            "dict":self.psDict,
            "string":self.string,
            "length":self.length,
            "get":self.get,
            "put":self.put,
            "getinterval":self.getinterval,
            "putinterval":self.putinterval,
            "search" : self.search,
            "def":self.psDef,
            "if":self.psIf,
            "ifelse":self.psIfelse,
            "for":self.psFor
        }
    #------- Operand Stack Helper Functions --------------
    
    """
        Helper function. Pops the top value from opstack and returns it.
    """
    def opPop(self):
        if len(self.opstack) > 0:
            x = self.opstack[len(self.opstack) - 1] # Dont index out of bounds like a goon
            self.opstack.pop(len(self.opstack) - 1)
            return x
        else:
            print("Error: opPop - Operand stack is empty")

    """
       Helper function. Pushes the given value to the opstack.
    """
    def opPush(self,value):
        self.opstack.append(value)

    #------- Dict Stack Helper Functions --------------
    """
       Helper function. Pops the top dictionary from dictstack and returns it.
    """  
    def dictPop(self):
        if len(self.dictstack) > 0:
            x = self.dictstack[len(self.dictstack) - 1]
            self.dictstack.pop(len(self.dictstack) - 1)
            return x
        else:
            print("Error: dictPop - Dict stack is empty") 

    """
       Helper function. Pushes the given dictionary onto the dictstack. 
    """   
    def dictPush(self,index,d):
        # changed to accept the index feild since its a tuple now
        self.dictstack.append((index, d))

    """
       Helper function. Adds name:value pair to the top dictionary in the dictstack.
       (Note: If the dictstack is empty, first adds an empty dictionary to the dictstack then adds the name:value to that. 
    """  
    def define(self,name, value):
        if not self.dictstack:
            # we are pushing the index and the empty dictionary as a tuple
            # I originally thought we would make an element type for the tuple but that made it very weird
            self.dictPush(0, {})
        self.dictstack[-1][1][name] = value

    """
       Helper function. Searches the dictstack for a variable or function and returns its value. 
       (Starts searching at the top of the dictstack; if name is not found returns None and prints an error message.
        Make sure to add '/' to the begining of the name.)
    """
    def lookup(self,name):
        if len(self.dictstack) == 0:
            print("Error: Dictionary stack is empty")
        elif len(self.dictstack) > 0:
            # we just wanna change it to use the correct lookup based on the type
            name = "/" + name

            if self.scope == "static":
                index = self.dictstack[-1][0]
                current = self.dictstack[index][1]

                if isinstance(current, DictConstant):
                    current = current.value

                if index == 0:
                    if name in current:
                        return current[name]
                    return None
                else:
                    i = 0
                    while index != 0:
                        if name in self.dictstack[index][1]:
                            return self.dictstack[index][1][name]
                        index = self.dictstack[index][0]
                        i = i + 1
                    return None
            else: # dynamic
                i = 0
                while (i != len(self.dictstack)):
                    if name in self.dictstack[(-1 - i)][1]:
                        return self.dictstack[(-1 - i)][1][name]
                    i += 1
                raise ValueError('Error: lookup()')

    #------- Arithmetic Operators --------------

    """
       Pops 2 values from opstack; checks if they are numerical (int); adds them; then pushes the result back to opstack. 
    """  
    def add(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1,int) or isinstance(op1,float))  and (isinstance(op2,int) or isinstance(op2,float)):
                self.opPush(op1 + op2)
            else:
                print("Error: add - one of the operands is not a number value")
                self.opPush(op1)
                self.opPush(op2)             
        else:
            print("Error: add expects 2 operands")

    """
       Pops 2 values from opstack; checks if they are numerical (int); subtracts them; and pushes the result back to opstack. 

       NOTES: I had the subtraction backwards at first 
    """ 
    def sub(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1,int) or isinstance(op1,float))  and (isinstance(op2,int) or isinstance(op2,float)):
                self.opPush(op2 - op1) # don't forget to do 2 -1 
            else:
                print("Error: sub - one of the operands is not a number value")
                self.opPush(op2)
                self.opPush(op1)             
        else:
            print("Error: sub expects 2 operands")

    """
        Pops 2 values from opstack; checks if they are numerical (int); multiplies them; and pushes the result back to opstack. 
    """
    def mul(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1,int) or isinstance(op1,float))  and (isinstance(op2,int) or isinstance(op2,float)):
                self.opPush(op1 * op2)
            else:
                print("Error: mul - one of the operands is not a number value")
                self.opPush(op1)
                self.opPush(op2)             
        else:
            print("Error: mul expects 2 operands")

    """
        Pops 2 values from stack; checks if they are int values; calculates the remainder of dividing the bottom value by the top one; 
        pushes the result back to opstack.

        NOTES: Don't be a fool and do the order of op1 and op2 backwards like me
    """
    def mod(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1,int) or isinstance(op1,float))  and (isinstance(op2,int) or isinstance(op2,float)):
                self.opPush(op2 % op1) # Dont forget this part either 
            else:
                print("Error: mod - one of the operands is not a number value")
                self.opPush(op2)
                self.opPush(op1)             
        else:
            print("Error: mod expects 2 operands")

    """ Pops 2 values from stacks; if they are equal pushes True back onto stack, otherwise it pushes False.
          - if they are integers or booleans, compares their values. 
          - if they are StrConstant values, compares the `value` attributes of the StrConstant objects;
          - if they are DictConstant objects, compares the objects themselves (i.e., ids of the objects).
        """
    def eq(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if (isinstance(op1,int) or isinstance(op1,float))  and (isinstance(op2,int) or isinstance(op2,float)):
                if op1 == op2:
                    self.opPush(True)
                else:
                    self.opPush(False)
            elif (isinstance(op1,StrConstant) and isinstance(op2,StrConstant)):
                if op1.value == op2.value:
                    self.opPush(True)
                else:
                    self.opPush(False)
            elif (isinstance(op1,DictConstant) and isinstance(op2,DictConstant)):
                if id(op1.value) == id(op2.value): # The id part is very important and I didn't have it at first and it broke. Also I was trying to do the keys
                    self.opPush(True)
                else:
                    self.opPush(False)
        else:
            print("Error: equals expects 2 operands")

    """ Pops 2 values from stacks; if the bottom value is less than the second, pushes True back onto stack, otherwise it pushes False.
          - if they are integers or booleans, compares their values. 
          - if they are StrConstant values, compares the `value` attributes of them;
          - if they are DictConstant objects, compares the objects themselves (i.e., ids of the objects).
    """  
    def lt(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if op1 > op2:
                self.opPush(True)
            else:
                self.opPush(False)
        else:
            print("Error: less than expects 2 operands")

    """ Pops 2 values from stacks; if the bottom value is greater than the second, pushes True back onto stack, otherwise it pushes False.
          - if they are integers or booleans, compares their values. 
          - if they are StrConstant values, compares the `value` attributes of them;
          - if they are DictConstant objects, compares the objects themselves (i.e., ids of the objects).
    """  
    def gt(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            if op1 < op2:
                self.opPush(True)
            else:
                self.opPush(False)
        else:
            print("Error: greater than expects 2 operands")

    #------- Stack Manipulation and Print Operators --------------
    """
       This function implements the Postscript "pop operator". Calls self.opPop() to pop the top value from the opstack and discards the value. 
    """
    def pop (self):
        if (len(self.opstack) > 0):
            self.opPop()
        else:
            print("Error: pop - not enough arguments")

    """
       Prints the opstack and dictstack. The end of the list is the top of the stack. 
    """
    def stack(self):
        print(OKGREEN+"**opstack**")
        for item in reversed(self.opstack):
            print(item)
        print("-----------------------"+CEND)
        # this is where it gets tricky because now we gotta add the extra stuff
        # we need to follow the static declarations, so we have to use the index
        print(RED+"===**dictstack**===")
        for num, item in enumerate(reversed(self.dictstack)):
            print(f"----{len(self.dictstack) -1 -num}----{item[0]}----")
            if(item[1]):
                if(isinstance(item[1], DictConstant)):
                    for item, key in item[1].value.items():
                        print(f"{item}   {key}")
                else:
                    for item, key in item[1].items():
                        print(f"{item}   {key}")
            pass
        print("================="+ CEND)

    """
       Copies the top element in opstack.
    """
    def dup(self):
        if len(self.opstack) > 0:
            self.opPush(self.opstack[-1])
        else:
            print("Error: there are no elements to dup")

    """
       Pops an integer count from opstack, copies count number of values in the opstack. 
    """
    def copy(self):
        count = self.opPop()
        outputList = []

        for i in range(count):
            outputList.append(self.opstack[len(self.opstack) -1 -i])

        outputList.reverse()
        for i in outputList:
            self.opPush(i)

    """
        Counts the number of elements in the opstack and pushes the count onto the top of the opstack.
    """
    def count(self):
        self.opPush(len(self.opstack))

    """
       Clears the opstack.
    """
    def clear(self):
        self.opstack.clear()
        
    """
       swaps the top two elements in opstack
    """
    def exch(self):
        if len(self.opstack) > 1:
            op1 = self.opPop()
            op2 = self.opPop()
            self.opPush(op1)
            self.opPush(op2)
        else:
            print("Error - There are not enough elements to exchange")

    # ------- String and Dictionary creator operators --------------

    """ Creates a new empty string  pushes it on the opstack.
    Initializes the characters in the new string to \0 , i.e., ascii NUL """
    def string(self):
        self.opPop()
        tempString = StrConstant("(\x00\x00\x00)")
        self.opPush(tempString)
    
    """Creates a new empty dictionary  pushes it on the opstack """
    def psDict(self):
        self.opPop()
        d = DictConstant({})
        self.opPush(d)

    # ------- String and Dictionary Operators --------------
    """ Pops a string or dictionary value from the operand stack and calculates the length of it. Pushes the length back onto the stack.
       The `length` method should support both DictConstant and StrConstant values.
    """
    def length(self):
        if len(self.opstack) > 0:
            temp = self.opPop()
            if isinstance(temp, StrConstant):
                self.opPush(len(temp.value)-2) # dont want to count the parenthesis
            elif isinstance(temp, DictConstant):
                self.opPush(len(temp.value))
            else:
                print("Error - operand is not DictConstant or StrConstant type")
        else:
            self.opPush(len(temp))

    """ Pops either:
         -  "A (zero-based) index and an StrConstant value" from opstack OR 
         -  "A `name` (i.e., a key) and DictConstant value" from opstack.  
        If the argument is a StrConstant, pushes the ascii value of the the character in the string at the index onto the opstack;
        If the argument is an DictConstant, gets the value for the given `name` from DictConstant's dictionary value and pushes it onto the opstack
    """
    def get(self):
        if len(self.opstack) < 2:
            print("Error - get() function")
            return
        location = self.opPop()
        container = self.opPop()
        if not isinstance(container, (StrConstant, DictConstant)):
            print("Error - get() function wrong types")
            self.opPush(container)
            self.opPush(location)
            return
        if isinstance(container, DictConstant):
            self.opPush(container.value[location])
            return
        if isinstance(container, StrConstant):
            # make sure it is a valid place for a string 
            # if it isn't push it back to the stack and display the error 
            if not isinstance(location, int) or not 0 <= location < len(container.value) - 2:
                print("Error - get() bad index dummy")
                self.opPush(container)
                self.opPush(location)
                return
            else:
                self.opPush(ord(container.value[location + 1]))
   
    """
    Pops either:
    - "An `item`, a (zero-based) `index`, and an StrConstant value from  opstack", OR
    - "An `item`, a `name`, and a DictConstant value from  opstack". 
    If the argument is a StrConstant, replaces the character at `index` of the StrConstant's string with the character having the ASCII value of `item`.
    If the argument is an DictConstant, adds (or updates) "name:item" in DictConstant's dictionary `value`.
    """
    def put(self):
        item = self.opPop()
        index = self.opPop()
        x = self.opPop()
        if (isinstance(x, StrConstant)):
            x.value = x.value[:index + 1] + chr(item) + x.value[index + 2:]
        elif (isinstance(x, DictConstant)):
            x.value[index] = item
        else:
            self.opPush(x)
            self.opPush(index)
            self.opPush(item) 

    """
    getinterval is a string only operator, i.e., works only with StrConstant values. 
    Pops a `count`, a (zero-based) `index`, and an StrConstant value from  opstack, and 
    extracts a substring of length count from the `value` of StrConstant starting from `index`,
    pushes the substring back to opstack as a StrConstant value. 
    """ 
    def getinterval(self):
        count = self.opPop()
        index = self.opPop() + 1
        temp = self.opPop()
        endIndex = index + count

        if (endIndex > len(temp.value) - 1):
            print("Error - index out of bounds")
        else:
            self.opPush(StrConstant("(" + (temp.value[index:endIndex]) + ")"))


    """
    putinterval is a string only operator, i.e., works only with StrConstant values. 
    Pops a StrConstant value, a (zero-based) `index`, a `substring` from  opstack, and 
    replaces the slice in StrConstant's `value` from `index` to `index`+len(substring)  with the given `substring`s value. 
    """
    def putinterval(self):
        if len(self.opstack) > 2:
            substring = self.opPop()
            index = self.opPop()
            startstring = self.opPop()

            if isinstance(startstring, StrConstant):
                length = len(substring.value) - 2
                subString1 = list(substring.value[1:-1])
                subString2 = list(startstring.value[1:-1])
                newString = "".join(subString2[:index] + subString1 + subString2[index +length:])
                startstring.value = "(" + newString + ")"
            else:
                print("Error - putinterval -- not a string ")
                # need to push them in reverse order so they get popped in the right order you dork
                self.opPush(startstring)
                self.opPush(index)
                self.opPush(substring)
        else: 
            print("Error - putinterval needs three values")

        
    """
    search is a string only operator, i.e., works only with StrConstant values. 
    Pops two StrConstant values: delimiter and inputstr
    if delimiter is a sub-string of inputstr then, 
       - splits inputstr at the first occurence of delimeter and pushes the splitted strings to opstack as StrConstant values;
       - pushes True 
    else,
        - pushes  the original inputstr back to opstack
        - pushes False
    """
    def search(self):
        if len(self.opstack) > 1:
            delimiter = self.opPop()
            inputstr = self.opPop()
            if isinstance(delimiter, StrConstant) and isinstance(inputstr, StrConstant):
                if delimiter.value[1:-1] in inputstr.value[1:-1]:
                    split = inputstr.value[1:-1].split(delimiter.value[1:-1], 1)
                    self.opPush(StrConstant("(" + split[1] + ")"))
                    self.opPush(delimiter)
                    self.opPush(StrConstant("(" + split[0] + ")"))
                    self.opPush(True)
                else:
                    self.opPush(inputstr)
                    self.opPush(False)
            else:
                print("Error: search - delimiter or the input string were not a string")
                self.opPush(inputstr)
                self.opPush(delimiter)
        else:
            print("Error: search was expecting 2 operands")

    # ------- Operators that manipulate the dictstact --------------
    # Deleted begin and end operators since they aren't used I hope this doesn't break it 
        
    """ Pops a name and a value from stack, adds the definition to the dictionary at the top of the dictstack. """
    def psDef(self):
        if len(self.opstack):
            value = self.opPop()
            name = self.opPop()
            self.define(name, value)
        else:
            print("Error - psDef function")
    
## PART TWO ##
    # ------- if/ifelse Operators --------------
    """ if operator
        Pops a Block and a boolean value, if the value is True, executes the code array by calling apply.
    """
    def psIf(self):
        tempBlock = self.opPop()
        bval = self.opPop()
        if bval == True:
            self.dictPush(len(self.dictstack)-1,{})
            tempBlock.apply(self)
            self.dictPop()

    """ ifelse operator
        Pops two Blocks and a boolean value, if the value is True, executes the bottom Block otherwise executes the top Block.
    """
    def psIfelse(self):
        temp1 = self.opPop()
        temp2 = self.opPop()
        bval = self.opPop()
        if bval == True:
            self.dictPush(len(self.dictstack)-1,{})
            temp2.apply(self)
            self.dictPop()
        else:
            self.dictPush(len(self.dictstack)-1,{})
            temp1.apply(self)
            self.dictPop()

## PART TWO ##
    #------- Loop Operators --------------
    """
       Implements for operator.   
       Pops a Block, the end index (end), the increment (inc), and the begin index (begin) and 
       executes the code array for all loop index values ranging from `begin` to `end`. 
       Pushes the current loop index value to opstack before each execution of the Block. 
    """ 
    def psFor(self):
        if len(self.opstack) > 3:
            tempBlock = self.opPop()
            end = self.opPop()
            inc = self.opPop()
            start = self.opPop()
            for i in range(int(start), int(end)+1, int(inc)):
                self.opPush(i)
                tempBlock.apply(self)
        else:
            print("Error - need 4 operands")

    """ Cleans both stacks. """      
    def clearBoth(self):
        self.opstack[:] = []
        self.dictstack[:] = []

    """ Will be needed for part2"""
    def cleanTop(self):
        if len(self.opstack)>1:
            if self.opstack[-1] is None:
                self.opstack.pop()

