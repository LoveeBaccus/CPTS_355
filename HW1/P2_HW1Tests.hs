{-  To run the tests type "run" at the Haskell prompt.  -} 

module P2_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1


-- replace tests
p2_test1 = TestCase (assertEqual "replace-test1" 
                                  "CptS 322 is offered at 2:55pm"
                                  (replace "CptS 355 is offered at 5:55pm" '5' '2' 3) ) 
p2_test2 = TestCase (assertEqual "replace-test2" 
                                  [(0,0),(2,20),(3,30),(0,0),(4,40)] 
                                  (replace [(1,10),(2,20),(3,30),(1,10),(4,40)] (1,10) (0,0) 2) ) 
p2_test3 = TestCase (assertEqual "replace-test3" 
                                  [1,1,2,1,2,3,1,2,3,40,1,2,3,40,5]  
                                  (replace [1,1,2,1,2,3,1,2,3,4,1,2,3,4,5] 4 40 3) ) 

tests = TestList [                  
                   TestLabel "Problem 2- test1 " p2_test1,
                   TestLabel "Problem 2- test2 " p2_test2,  
                   TestLabel "Problem 2- test3 " p2_test3
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests