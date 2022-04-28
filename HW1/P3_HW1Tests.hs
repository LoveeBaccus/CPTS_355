{-  To run the tests type "run" at the Haskell prompt.  -} 

module P3_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- max_date tests                                  
p3_test1 = TestCase (assertEqual "max_date-test1" 
                                  (2,1,2022)
                                  (max_date [(12,1, 2021),(11, 30, 2021),(2,1,2022),(1,5,2021),(12,15,2021),(2,1,2022),(12, 1, 2021),(1,5,2022)]) ) 
p3_test2 = TestCase (assertEqual "max_date-test2" 
                                  (1,26,2022)   
                                  (max_date [(11, 26, 2021),(1, 26, 2022), (1, 27, 2021),(1, 26, 2022), (1, 27, 2021),(11, 26, 2021)]) ) 
p3_test3 = TestCase (assertEqual "max_date-test3" 
                                  (11,30,2021)  
                                  (max_date [(11, 30, 2021)]) ) 

tests = TestList [ 
                   TestLabel "Problem 3- test1 " p3_test1, 
                   TestLabel "Problem 3- test2 " p3_test2, 
                   TestLabel "Problem 3- test3 " p3_test3                                       
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests