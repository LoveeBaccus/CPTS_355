module P3_HW2tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

p3a_test1 = TestCase (assertEqual "nested_max test-1" 
                                    9 
                                    (nested_max [[1,2,3],[4,5],[6,7,8,9],[]]) ) 
p3a_test2 = TestCase (assertEqual "nested_max test-2" 
                                    10 
                                    (nested_max [[10,10],[10,10,10],[10]]) ) 
p3a_test3 = TestCase (assertEqual "nested_max test-3" 
                                    (0) 
                                    (nested_max [[-1,-2,-3],[-4,0,-5],[-6,0,-7,0,-8,-9],[]]) ) 

p3b_test1 = TestCase (assertEqual "max_maybe test-1" 
                                   (Just 10) 
                                   (max_maybe [[(Just 1),(Just 2),(Just 10),(Just 3)],[(Just 4),(Just 5)],[(Just 6),(Just 10),Nothing ],[],[Nothing ]]) )
p3b_test2 = TestCase (assertEqual "max_maybe test-2" 
                                   (Just "Z") 
                                   (max_maybe [[(Just "A"),Nothing],[(Just "X"), (Just "B"), (Just "Z"),Nothing,Nothing]]) )
p3b_test3 = TestCase (assertEqual "max_maybe test-3" 
                                   (Nothing::(Maybe Int))
                                   (max_maybe [[Nothing]]) )

p3c_test1 = TestCase (assertEqual "max_numbers test-1" 
                                    (9) 
                                    (max_numbers [[StrNumber "9",IntNumber 2,IntNumber 8],[StrNumber "4",IntNumber 5],[IntNumber 6,StrNumber "7"],[],[StrNumber "8"]]) )
p3c_test2 = TestCase (assertEqual "max_numbers test-2" 
                                    (12) 
                                    (max_numbers [[StrNumber "10" , IntNumber 12],[],[StrNumber "10"],[]]) )
p3c_test3 = TestCase (assertEqual "max_numbers test-3" 
                                    (minBound::Int) 
                                    (max_numbers  [[]]) )

tests = TestList [ TestLabel "Problem 3a - test1 " p3a_test1,
                   TestLabel "Problem 3a - test2 " p3a_test2,  
                   TestLabel "Problem 3a - test3 " p3a_test3,                    
                   TestLabel "Problem 3b - test1 " p3b_test1,
                   TestLabel "Problem 3b - test2 " p3b_test2,
                   TestLabel "Problem 3b - test3 " p3b_test3,
                   TestLabel "Problem 3c - test1 " p3c_test1,
                   TestLabel "Problem 3c - test2 " p3c_test2,
                   TestLabel "Problem 3c - test3 " p3c_test3
                 ] 
                  

-- shortcut to run the tests
run = runTestTT  tests