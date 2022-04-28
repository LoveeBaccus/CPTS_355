from psbuiltins import Stacks
from elements import StrConstant, DictConstant
import unittest

class HW4Part1Tests(unittest.TestCase):
    def setUp(self):
        #create the Stack object
        self.psstacks = Stacks()
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
        self.psstacks.dictPush({'/a':'(355)'})
        s = StrConstant('(355)')
        self.psstacks.dictPush({'/a':s})
        self.assertTrue(self.psstacks.lookup("a") is s)
        self.assertEqual(self.psstacks.lookup("a").value,s.value)

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
        # (WSU) (WSU) eq
        #compare values
        self.psstacks.opPush(StrConstant('(WSU)'))
        self.psstacks.opPush(StrConstant('(WSU)'))
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),True)
        #compare objects
        s = StrConstant('(WSU)')
        self.psstacks.opPush(s)
        self.psstacks.opPush(s)
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),True)

    def test_eq3(self):
        # 1 dict  2 dict 
        #compare objects
        d1 = DictConstant({})
        self.psstacks.opPush(d1)
        d2 = DictConstant({})
        self.psstacks.opPush(d2)
        self.psstacks.eq()
        self.assertEqual(self.psstacks.opPop(),False)
        self.psstacks.opPush(d1)
        #duplicate the object
        self.psstacks.dup()
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

    #-----------------------------------------------------
    #String operator tests
    def test_string(self):
        # 3 string 
        self.psstacks.opPush(3)
        self.psstacks.string()
        d = self.psstacks.opPop() # pop the StrConstant value
        self.assertEqual(d.value,'(\x00\x00\x00)')  #the characters in the StrConstant's value should be initialized to '\0' , ascii NUL
        self.assertTrue(len(self.psstacks.opstack)==0)  

    def test_length_StrConstant(self):
        #(CptS355) length
        self.psstacks.opPush(StrConstant('(CptS355)'))
        self.psstacks.length()
        self.assertEqual(self.psstacks.opPop(),7)      
        self.assertTrue(len(self.psstacks.opstack)==0) 
        #length will not push back the StrConstant onto the opstack      

    def test_get_StrConstant(self):
        #(CptS355) 3 get
        self.psstacks.opPush(StrConstant('(CptS355)'))
        self.psstacks.opPush(3)
        self.psstacks.get()
        self.assertEqual(self.psstacks.opPop(),83)
        self.assertTrue(len(self.psstacks.opstack)==0)
        #get will not push back the StrConstant onto the opstack   

    def test_put_StrConstant1(self):
        #(CptS451) dup 4 51 put 
        str1 = StrConstant('(CptS451)')
        self.psstacks.opPush(str1)
        self.psstacks.dup()  #duplicating the StrConstant reference
        self.psstacks.opPush(4)
        self.psstacks.opPush(51)  # ascii value for '3'
        self.psstacks.put()  #put will not push back the changed StrConstant onto the opstack 
        str2 = self.psstacks.opPop()
        self.assertTrue(str2 is str1)  #we pop the StrConstant reference we copied with "dup"; check if it the same object
        self.assertEqual(str2.value,'(CptS351)')  #we check if the StrConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #put will not push back the original StrConstant onto the opstack 

    def test_put_StrConstant2(self):
        #/x (CptS321) def x 6 50 put x
        str1 = StrConstant('(CptS321)')
        self.psstacks.opPush('/x')
        self.psstacks.opPush(str1)
        self.psstacks.psDef()  #defines x; x holds the StrConstant reference
        self.psstacks.opPush(self.psstacks.lookup('x'))
        self.psstacks.opPush(6)
        self.psstacks.opPush(50)  # ascii value for '1'
        self.psstacks.put()  #put will not push back the changed StrConstant onto the opstack 
        self.psstacks.opPush(self.psstacks.lookup('x'))
        str2 = self.psstacks.opPop()
        self.assertTrue(str2 is str1)  #we pop the StrConstant reference we saved in x; check if it the same object
        self.assertEqual(str2.value,'(CptS322)')  #we check if the StrConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #put will not push back the original StrConstant onto the opstack 

    def test_getinterval(self):
        #(WSU Pullman Campus) 4 7 getinterval
        self.psstacks.opPush(StrConstant('(WSU Pullman Campus)'))
        self.psstacks.opPush(4)
        self.psstacks.opPush(7)
        self.psstacks.getinterval()
        s =  self.psstacks.opPop() #pop the StrConstant slice
        self.assertEqual(s.value, '(Pullman)')
        self.assertTrue(len(self.psstacks.opstack)==0)
        #getinterval will not push back the original StrConstant onto the opstack 

    def test_putinterval1(self):
        #(WSU Pullman Campus) dup dup dup (Everett) putinterval
        s1 = StrConstant('(WSU Pullman Campus)')
        self.psstacks.opPush(s1)
        self.psstacks.dup()  # duplicating the StrConstant reference
        self.psstacks.dup()  # duplicating the StrConstant reference
        self.psstacks.opPush(4)
        self.psstacks.opPush(StrConstant('(Everett)'))  # the slice that starts at index 4 will be replaced by (Everett)
        self.psstacks.putinterval()  # putinterval will not push back the changed StrConstant onto the opstack 
        s2 = self.psstacks.opPop()  # we pop the StrConstant reference we copied with "dup"; 
        self.assertTrue(s2 is s1)  # check if it the same object
        self.assertEqual(s2.value,'(WSU Everett Campus)')  # we check if the StrConstant object value is updated
        s3 = self.psstacks.opPop()  # we pop the string reference we copied with "dup";
        self.assertTrue(s3 is s1)  # check if it the same object
        self.assertEqual(s3.value,'(WSU Everett Campus)')  # we check if the StrConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #putinterval will not push back the original StrConstant onto the opstack 

    def test_putinterval2(self):
        # /str1 (WSU Pullman Campus) def s1  (Everett) putinterval
        s1 = StrConstant('(WSU Pullman Campus)')
        self.psstacks.opPush('/str1')
        self.psstacks.opPush(s1)
        self.psstacks.psDef()  # defines /str1 ; /str1 holds the StrConstant reference
        self.psstacks.opPush(self.psstacks.lookup('str1'))  # pushes the StrConstant reference str1 holds onto the stack
        self.psstacks.opPush(4)
        self.psstacks.opPush(StrConstant('(Everett)'))  # the slice that starts at index 4 will be replaced by (Everett)
        self.psstacks.putinterval()  # putinterval will not push back the changed StrConstant onto the opstack 
        
        self.psstacks.opPush(self.psstacks.lookup('str1'))  # pushes the StrConstant reference str1 holds onto the stack
        s2 = self.psstacks.opPop()  # we pop the StrConstant reference ; 
        self.assertTrue(s2 is s1)  # check if it the same object
        self.assertEqual(s2.value,'(WSU Everett Campus)')  # we check if the StrConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #putinterval will not push back the original StrConstant onto the opstack 

    def test_search1(self):
        # (WSU,Go,Cougs) (,) search 
        self.psstacks.opPush(StrConstant('(WSU,Go,Cougs)'))
        self.psstacks.opPush(StrConstant('(,)'))
        self.psstacks.search()
        self.assertTrue(self.psstacks.opPop())  # the substring exists
        self.assertEqual(self.psstacks.opPop().value,'(WSU)') 
        self.assertEqual(self.psstacks.opPop().value,'(,)') 
        self.assertEqual(self.psstacks.opPop().value,'(Go,Cougs)')       
        self.assertTrue(len(self.psstacks.opstack)==0)

    def test_search2(self):
        # (WSU Go Cougs) (,) search 
        self.psstacks.opPush(StrConstant('(WSU Go Cougs)'))
        self.psstacks.opPush(StrConstant('(,)'))
        self.psstacks.search()
        self.assertFalse(self.psstacks.opPop())  # the substring doesn't exist
        self.assertEqual(self.psstacks.opPop().value,'(WSU Go Cougs)')       
        self.assertTrue(len(self.psstacks.opstack)==0)

    #-----------------------------------------------------
    #Dictionary operator tests

    def test_dict(self):
        # 10 dict 
        self.psstacks.opPush(10)
        self.psstacks.psDict()
        d = self.psstacks.opPop() # pop the DictConstant value
        self.assertEqual(d.value,{}) 
        self.assertTrue(len(self.psstacks.opstack)==0)  # dict should pop the size argument

    def test_get_put_DictConstant1(self):
        # 1 dict dup dup 1 10 put 1 get
        self.psstacks.opPush(1)
        self.psstacks.psDict()
        self.psstacks.dup()  #duplicating the DictConstant reference
        self.psstacks.dup()  #duplicating the DictConstant reference

        self.psstacks.opPush(1)
        self.psstacks.opPush(10)  
        self.psstacks.put()  #put will not push back the changed string onto the opstack 
        self.psstacks.opPush(1)
        self.psstacks.get() 
        self.assertEqual(self.psstacks.opPop(),10)  #we pop the value get pushed onto the opstack
        d2 = self.psstacks.opPop()  # pop the updated DictStack value
        self.assertDictEqual(d2.value,{1:10})  #we check if the DictConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #put will not push back the original DictConstant onto the opstack 

    def test_get_put_DictConstant2(self):
        # /myd 1 dict def myd 2 10 put myd 2 22 put  myd 2 get myd
        self.psstacks.opPush('/myd')
        self.psstacks.opPush(1)
        self.psstacks.psDict()
        self.psstacks.psDef()
        self.psstacks.opPush(self.psstacks.lookup('myd'))
        self.psstacks.opPush(2)
        self.psstacks.opPush(10)
        self.psstacks.put() 
        self.psstacks.opPush(self.psstacks.lookup('myd'))
        self.psstacks.opPush(2)
        self.psstacks.opPush(22)
        self.psstacks.put() # overwrite the previous value for key (x)
        self.psstacks.opPush(self.psstacks.lookup('myd'))
        self.psstacks.opPush(2)        
        self.psstacks.get() 
        self.assertEqual(self.psstacks.opPop(),22)  #we pop the value get pushed onto the opstack
        self.psstacks.opPush(self.psstacks.lookup('myd'))        
        d2 = self.psstacks.opPop()  # pop the updated DictStack value
        self.assertDictEqual(d2.value,{2:22})  #we check if the DictConstant object value is updated
        self.assertTrue(len(self.psstacks.opstack)==0)
        #put will not push back the original DictConstant onto the opstack 

    def test_length_DictConstant(self):
        #1 dict 1 dup 11 put length
        self.psstacks.opPush(1)
        self.psstacks.psDict()
        self.psstacks.dup()
        self.psstacks.opPush(1)
        self.psstacks.opPush(11)
        self.psstacks.put()
        self.psstacks.length()
        self.assertEqual(self.psstacks.opPop(),1)      
        self.assertTrue(len(self.psstacks.opstack)==0) 
        #length will not push back the DictConstant onto the opstack  

    #-----------------------------------------------------
    #stack manipulation operator tests
    def test_dup(self):
        #(CptS355)  dup
        self.psstacks.opPush(StrConstant('(CptS355)'))
        self.psstacks.dup()
        isSame = self.psstacks.opPop() is self.psstacks.opPop()
        self.assertTrue(isSame)

    def test_exch(self):
        # /x 10 exch
        self.psstacks.opPush('/x')
        self.psstacks.opPush(10)
        self.psstacks.exch()
        self.assertEqual(self.psstacks.opPop(),'/x')
        self.assertEqual(self.psstacks.opPop(),10)

    def test_pop(self):
        l1 = len(self.psstacks.opstack)
        self.psstacks.opPush(10)
        self.psstacks.pop()
        l2 = len(self.psstacks.opstack)
        self.assertEqual(l1,l2)

    def test_copy(self):
        #true 1 3 4 3 copy
        self.psstacks.opPush(True)
        self.psstacks.opPush(1)
        self.psstacks.opPush(3)
        self.psstacks.opPush(4)
        self.psstacks.opPush(3)
        self.psstacks.copy()
        self.assertTrue(self.psstacks.opPop()==4 and self.psstacks.opPop()==3 and self.psstacks.opPop()==1 and self.psstacks.opPop()==4 and self.psstacks.opPop()==3 and self.psstacks.opPop()==1 and self.psstacks.opPop()==True)
        
    def test_clear(self):
        #10 /x clear
        self.psstacks.opPush(10)
        self.psstacks.opPush("/x")
        self.psstacks.clear()
        self.assertEqual(len(self.psstacks.opstack),0)


    #-----------------------------------------------------
    #dictionary stack operators

    def test_psDef(self):
        #/x 10 def /x 20 def x
        self.psstacks.dictPush({})
        self.psstacks.opPush("/x")
        self.psstacks.opPush(10)
        self.psstacks.psDef()
        self.psstacks.opPush("/x")
        self.psstacks.opPush(20)
        self.psstacks.psDef()
        self.assertEqual(self.psstacks.lookup('x'),20)

    def test_psDef2(self):
        #/x 10 def 1 dict begin /y 20 def x
        self.psstacks.dictPush({})
        self.psstacks.opPush("/x")
        self.psstacks.opPush(10)
        self.psstacks.psDef()
        self.psstacks.dictPush({})
        self.psstacks.opPush("/y")
        self.psstacks.opPush(20)
        self.psstacks.psDef()
        self.assertEqual(self.psstacks.lookup('x'),10)

    def test_begin_end(self):
        #/x 3 def 1 dict begin /x 4 def end x
        self.psstacks.opPush("/x")
        self.psstacks.opPush(3)
        self.psstacks.psDef()
        self.psstacks.opPush(1)
        self.psstacks.psDict()
        self.psstacks.begin()
        self.psstacks.opPush("/x")
        self.psstacks.opPush(4)
        self.psstacks.psDef()
        self.psstacks.end() 
        self.assertEqual(self.psstacks.lookup('x'),3)

    def test_dict_put_begin_end(self):
        #1 dict /x 3 def /myd 2 dict def myd /x 4 put myd begin x end x
        self.psstacks.opPush(1)
        self.psstacks.psDict()
        self.psstacks.opPush("/x")
        self.psstacks.opPush(3)
        self.psstacks.psDef()
        self.psstacks.opPush("/myd")
        self.psstacks.opPush(2)
        self.psstacks.psDict()
        self.psstacks.psDef()
        self.psstacks.opPush(self.psstacks.lookup('myd'))
        self.psstacks.opPush("/x")
        self.psstacks.opPush(4)
        self.psstacks.put()
        self.psstacks.opPush(self.psstacks.lookup('myd'))
        self.psstacks.begin()
        self.psstacks.opPush(self.psstacks.lookup('x'))        
        self.psstacks.end() 
        self.psstacks.opPush(self.psstacks.lookup('x'))                
        self.assertEqual(self.psstacks.opPop(),3)
        self.assertEqual(self.psstacks.opPop(),4)
        self.assertEqual(self.psstacks.opPop().value,{})
        self.assertTrue(len(self.psstacks.opstack)==0) 

    def test_psDef3(self):
        #/x 3 def 1 dict begin /x 30 def 1 dict begin /x 300 def end x
        # define x in the bottom dictionary
        self.psstacks.dictPush({})
        self.psstacks.opPush("/x")
        self.psstacks.opPush(3)
        self.psstacks.psDef()
        # define x in the second dictionary
        self.psstacks.dictPush({})
        self.psstacks.opPush("/x")
        self.psstacks.opPush(30)
        self.psstacks.psDef()
        # define x in the third dictionary
        self.psstacks.dictPush({})
        self.psstacks.opPush("/x")
        self.psstacks.opPush(300)
        self.psstacks.psDef()
        self.psstacks.dictPop()
        self.assertEqual(self.psstacks.lookup('x'),30)


#-----------------------------------------------------

if __name__ == '__main__':
    unittest.main()

