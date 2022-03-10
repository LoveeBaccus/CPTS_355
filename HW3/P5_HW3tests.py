import unittest
from HW3 import *

class P5_HW3tests(unittest.TestCase):
    "Unittest setup file. Unittest framework will run this before every test."
    def setUp(self):
        self.graph = {'A':{'B','C','D'},'B':{'C'},'C':{'B','E','F','G'},'D':{'A','E','F'},'E':{'F'}, 'F':{'E', 'G'},'G':{}, 'H':{'F','G'}}

    #--- Problem 5 ----------------------------------
    def test_1_longest_path(self):
        self.assertEqual(longest_path(self.graph,'A'),6)
    
    def test_2_longest_path(self):
        self.assertEqual(longest_path(self.graph,'D'),7)
        
    def test_3_longest_path(self):
        self.assertEqual(longest_path(self.graph,'C'),4)

    def test_4_longest_path(self):
        self.assertEqual(longest_path(self.graph,'F'),2)


    def test_2_longest_path(self):
        pass
        # Provide your own test here. Create your own graph dictionary for this test (similar to self.graph). 

if __name__ == '__main__':
    unittest.main()

