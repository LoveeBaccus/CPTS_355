{-  To run the tests type "run" at the Haskell prompt.  -} 

module P6_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- split_at_duplicate tests
p6_test1 = TestCase (assertEqual "(split_at_duplicate-test1)"  
                                 [[1,2,3,1],[1,4,5],[5],[5,6,7,6],[6,8,9],[9]] 
                                 (split_at_duplicate [1,2,3,1,1,4,5,5,5,6,7,6,6,8,9,9] ) )
p6_test2 = TestCase (assertEqual "(split_at_duplicate-test2)" 
                                 [[10],[10],[10],[10],[10],[10],[10],[10]]  
                                 (split_at_duplicate [10,10,10,10,10,10,10,10]) ) 
p6_test3 = TestCase (assertEqual "(split_at_duplicate-test3)"  
                                 [[1,2,3,4,5,3,4,5,6,7,8]] 
                                 (split_at_duplicate [1,2,3,4,5,3,4,5,6,7,8] ) )
p6_test4 = TestCase (assertEqual "(split_at_duplicate-test4)"  
                                 []  
                                 (split_at_duplicate ([]::[Int]) ) ) 

tests = TestList [                                     
                   TestLabel "Problem 6- test1 " p6_test1, 
                   TestLabel "Problem 6- test2 " p6_test2,
                   TestLabel "Problem 6- test3 " p6_test3, 
                   TestLabel "Problem 6- test4 " p6_test4
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests