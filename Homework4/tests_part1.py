from psOperators import Operators
from psItems import ArrayValue
import unittest
import sys
sys.path.append('../')

class HW4Sampletests_part1(unittest.TestCase):
    #If the setUp doesn't clear the stacks succesfully, copy the following function to HW4_part1.py and call it in setup. 

    def setUp(self):
        #create the Operators object
        self.psstacks = Operators()
        #clear the opstack and the dictstack
        self.psstacks.clearBoth() 
    
    # Tests for helper functions : define, lookup   
    def test_lookup1(self):
        self.psstacks.dictPush({'/v':3, '/x': 20})
        self.psstacks.dictPush({'/v':4, '/x': 10})
        self.psstacks.dictPush({'/v':5})
        self.assertEqual(self.psstacks.lookup('x'),10)
        self.assertEqual(self.psstacks.lookup('v'),5)

    def testLookup2(self):
        self.psstacks.dictPush({'/a':355})
        arrayV = ArrayValue([3,5,5])
        self.psstacks.dictPush({'/a':arrayV})
        self.assertTrue(self.psstacks.lookup("a") is arrayV)
        self.assertEqual(self.psstacks.lookup("a").value,arrayV.value)

    def test_define1(self):
        self.psstacks.dictPush({})
        self.psstacks.define("/n1", 4)
        self.assertEqual(self.psstacks.lookup("n1"),4)

    def test_define2(self):
        self.psstacks.dictPush({})
        self.psstacks.define("/n1", 4)
        self.psstacks.define("/n1", 5)
        self.psstacks.define("/n2", 6)
        self.assertEqual(self.psstacks.lookup("n1"),5)
        self.assertEqual(self.psstacks.lookup("n2"),6)        

    def test_define3(self):
        self.psstacks.dictPush({})
        self.psstacks.define("/n1", 4)
        self.psstacks.dictPush({})
        self.psstacks.define("/n2", 6)
        self.psstacks.define("/n2", 7)
        self.psstacks.dictPush({})
        self.psstacks.define("/n1", 6)
        self.assertEqual(self.psstacks.lookup("n1"),6)
        self.assertEqual(self.psstacks.lookup("n2"),7)    

#-----------------------------------------------------
    #Arithmatic operator tests
    def test_add(self):
        #9 3 add
        self.psstacks.opPush(9)
        self.psstacks.opPush(3)
        self.psstacks.add()
        self.assertEqual(self.psstacks.opPop(),12)

    def test_sub(self):
        #10 2 sub
        self.psstacks.opPush(10)
        self.psstacks.opPush(2)
        self.psstacks.sub()
        self.assertEqual(self.psstacks.opPop(),8)

    def test_mul(self):
        #2 40 mul
        self.psstacks.opPush(2)
        self.psstacks.opPush(40)
        self.psstacks.mul()
        self.assertEqual(self.psstacks.opPop(),80)

    def test_mod(self):
        #20 3 mod
        self.psstacks.opPush(20)
        self.psstacks.opPush(3)
        self.psstacks.mod()
        self.assertEqual(self.psstacks.opPop(),2)
        
    #-----------------------------------------------------
    #Comparison operators tests
    def test_eq1(self):
        #6 6 eq
        self.psstacks.opPush(6)
        self.psstacks.opPush(6)
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),True)

    def test_eq2(self):
        #[1 2 3 4] [1 2 3 4] eq
        self.psstacks.opPush(ArrayValue([1,2,3,4]))
        self.psstacks.opPush(ArrayValue([1,2,3,4]))
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),False)
        arr1 = ArrayValue([1,2,3,4])
        self.psstacks.opPush(arr1)
        self.psstacks.opPush(arr1)
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),True)

    def test_lt(self):
        #3 6 lt
        self.psstacks.opPush(3)
        self.psstacks.opPush(6)
        self.psstacks.lt()
        self.assertEqual(self.psstacks.opPop(),True)

    def test_gt(self):
        #4 5 gt
        self.psstacks.opPush(4)
        self.psstacks.opPush(5)
        self.psstacks.gt()
        self.assertEqual(self.psstacks.opPop(),False)
if __name__ == '__main__':
    unittest.main()

