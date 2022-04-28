module P1_HW2tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

p1a_test1 = TestCase (assertEqual "commons test-1" 
                                   (sort [2,5,8])  
                                   (sort (commons [2,2,5,6,6,8,9] [1,3,2,2,4,4,5,7,8,10])) ) 
p1a_test2 = TestCase (assertEqual "commons test-2" 
                                    (sort [5,8])  
                                    (sort (commons [5,6,7,8,9] [8,8,10,10,11,12,5])) ) 
p1a_test3 = TestCase (assertEqual "commons test-3" 
                                    []  
                                    (commons ["a","b","d"] ["c","e","f","g"]) ) 

p1b_test1 = TestCase (assertEqual "commons_tail test-1" 
                                    (sort [2,5,8])  
                                    (sort (commons_tail [2,2,5,6,6,8,9] [1,3,2,2,4,4,5,7,8,10])) ) 
p1b_test2 = TestCase (assertEqual "commons_tail test-2" 
                                    (sort [5,8])  
                                    (sort (commons_tail [5,6,7,8,9] [8,8,10,10,11,12,5])) ) 
p1b_test3 = TestCase (assertEqual "commons_tail test-3" 
                                    []  
                                    (commons_tail ["a","b","d"] ["c","e","f","g"]) ) 

p1c_test1 = TestCase (assertEqual "commons_all test-1" 
                                    (sort [5])  
                                    (sort (commons_all [[1,3,3,4,5,5,6],[3,4,5],[4,4,5,6],[3,5,6,6,7,8]])) )
p1c_test2 = TestCase (assertEqual "commons_all test-2" 
                                    []  
                                    (sort (commons_all [[3,4],[-3,-4,3,4],[-3,-4,5,6]])) )
p1c_test3 = TestCase (assertEqual "commons_all test-3" 
                                    []  (sort (commons_all [[3,4,5,5,6],[4,5,6],[],[3,4,5]])) )

tests = TestList [ TestLabel "Problem 1a - test1 " p1a_test1,
                   TestLabel "Problem 1a - test2 " p1a_test2,
                   TestLabel "Problem 1a - test3 " p1a_test3,                   
                   TestLabel "Problem 1b - test1 " p1b_test1,
                   TestLabel "Problem 1b - test2 " p1b_test2,                   
                   TestLabel "Problem 1b - test3 " p1b_test3,                                      
                   TestLabel "Problem 1c - test1 " p1c_test1,
                   TestLabel "Problem 1c - test2 " p1c_test2,
                   TestLabel "Problem 1c - test3 " p1c_test3
                 ] 

-- shortcut to run the tests
run = runTestTT  tests