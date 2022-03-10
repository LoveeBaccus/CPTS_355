import unittest
from HW3 import *

class P6_HW3tests(unittest.TestCase):
    "Unittest setup file. Unittest framework will run this before every test."
    def setUp(self):
        self.numbers = """ 
            one 
            one two 
            one two three  
            one two three four 
            one two three four five
            one two three four five six
           """
        self.text = """ 
            Python's philosophy is summarized as
            Beautiful is better than ugly
            Explicit is better than implicit
            Simple is better than complex
            Complex is better than complicated
            Readability counts
        """

    #--- Problem 6----------------------------------
    def test_1_counter(self):
        # expected counter output
        self.tokens = [('two', 1), ('one', 3), ('two', 2), ('three', 1), ('one', 4), ('two', 3), ('three', 2), ('four', 1), ('one', 5), ('two', 4), ('three', 3), ('four', 2), ('five', 1), ('one', 6), ('two', 5), ('three', 4), ('four', 3), ('five', 2), ('six', 1)]
        mywords = counter(self.numbers)
        mywords.__next__()   # skip first tuple ('one',1)
        mywords.__next__()   # skip second tuple ('one',2)
        
        rest = []
        for word in mywords:  
            rest.append(word)
        self.assertListEqual(rest,self.tokens)

    def test_2_counter(self):
        # expected counter output
        self.tokens = [('summarized', 1), ('as', 1), ('beautiful', 1), ('is', 2), ('better', 1), ('than', 1), ('ugly', 1), ('explicit', 1), ('is', 3), ('better', 2), ('than', 2), ('implicit', 1), ('simple', 1), ('is', 4), ('better', 3), ('than', 3), ('complex', 1), ('complex', 2), ('is', 5), ('better', 4), ('than', 4), ('complicated', 1), ('readability', 1), ('counts', 1)]
        mywords = counter(self.text)
        mywords.__next__()   # skip first tuple ("python's", 1)
        mywords.__next__()   # skip second tuple ('philosophy', 1)
        mywords.__next__()   # skip third tuple ('is', 1)
        rest = []
        for word in mywords:  
            rest.append(word)
        self.assertListEqual(rest,self.tokens)

if __name__ == '__main__':
    unittest.main()

