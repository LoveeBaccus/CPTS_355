{-  To run the tests type "run" at the Haskell prompt.  -} 

module P1_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- list_diff tests
p1_test1 = TestCase (assertEqual "list_diff-test1" 
                                 (sort [1,6,1,8,7,8])
                                 (sort $ list_diff [1,6,1,3,4,3,5] [3,8,5,4,7,4,8]) )
p1_test2 = TestCase (assertEqual "list_diff-test2" 
                                 (sort ".mshhmnsin!")
                                 (sort $ list_diff "We care about our world." "We care most about the humans in our world!") ) 
p1_test3 = TestCase (assertEqual "list_diff-test3" 
                                 []  
                                 (list_diff ["alpha","gamma","beta","pi","theta"]  ["pi", "gamma","alpha","pi","beta","theta"]) ) 
 
tests = TestList [ TestLabel "Problem 1- test1 " p1_test1,
                   TestLabel "Problem 1- test2 " p1_test2,  
                   TestLabel "Problem 1- test3 " p1_test3                   
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests