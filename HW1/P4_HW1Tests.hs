{-  To run the tests type "run" at the Haskell prompt.  -} 

module P4_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1
-- num_paths tests                                  
p4_test1 = TestCase (assertEqual "num_paths-test1" 
                                  10  
                                  (num_paths 4 3) ) 
p4_test2 = TestCase (assertEqual "num_paths-test2" 
                                  330 
                                  (num_paths 5 8) ) 
p4_test3 = TestCase (assertEqual "num_paths-test3" 
                                  24310 
                                  (num_paths 9 10) ) 
p4_test4 = TestCase (assertEqual "num_paths-test3" 
                                  1 
                                  (num_paths 1 1000) ) 
                                                           

tests = TestList [                                      
                   TestLabel "Problem 4- test1 " p4_test1, 
                   TestLabel "Problem 4- test2 " p4_test2,
                   TestLabel "Problem 4- test3 " p4_test3, 
                   TestLabel "Problem 4- test4 " p4_test4
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests