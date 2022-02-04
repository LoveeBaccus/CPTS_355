{-Haskell HW2-Q3 HUnit test cases-}

module Q3_SampleTests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

p3a_test1 = TestCase (assertEqual "isBigger-test1" (True) (isBigger (DATE (5,20,2021)) (DATE (5,15,2021)) )) 
p3a_test2 = TestCase (assertEqual "isBigger-test2" (True) (isBigger (DATE (6,10,2021)) (DATE (5,15,2021)) ))
p3a_test3 = TestCase (assertEqual "isBigger-test3" (True) (isBigger (DATETIME (6,10,2021,19,30)) (DATETIME (6,10,2021,19,10)) ))
p3a_test4 = TestCase (assertEqual "isBigger-test4" (False) (isBigger (DATETIME (6,9,2021,19,30)) (DATETIME (6,10,2021,11,10)) ))
p3a_test5 = TestCase (assertEqual "isBigger-test5" (False) (isBigger (DATETIME (6,10,2021,11,10)) (DATETIME (6,10,2021,11,10)) ))
p3a_test6 = TestCase (assertEqual "isBigger-test6" (True) (isBigger (DATE (6,10,2021)) (DATETIME (6,9,2021,11,10)) ))
p3a_test7 = TestCase (assertEqual "isBigger-test7" (False) (isBigger (DATE (6,10,2021)) (DATETIME (6,10,2021,11,10)) ))
p3a_test8 = TestCase (assertEqual "isBigger-test8" (False) (isBigger (DATETIME (6,10,2021,11,10)) (DATE (6,10,2021)) ))

datelist = [DATE(5,28,2021), DATETIME(6,1,2021,14,15), DATE(6,22,2021), DATE(6,1,2021), DATETIME(6,21,2021,15,20), 
            DATETIME(5,21,2020,14,40), DATE (5,20,2021), DATETIME (6,9,2021,19,30), DATETIME (6,10,2021,11,10)]

p3b_test1 = TestCase (assertEqual "applyRange-test1" 
                                  ([DATE (5,28,2021),DATETIME (6,1,2021,14,15),DATE (6,1,2021),DATETIME (6,21,2021,15,20),DATETIME (6,9,2021,19,30),DATETIME (6,10,2021,11,10)]) 
                                  (applyRange (DATE(5,20,2021) , DATETIME(6,21,2021,19,00)) datelist ) ) 
p3b_test2 = TestCase (assertEqual "applyRange-test2" 
                                  ([DATE (6,22,2021),DATETIME (6,21,2021,15,20),DATETIME (6,9,2021,19,30),DATETIME (6,10,2021,11,10)]) 
                                  (applyRange (DATETIME(6,1,2021,14,20) , DATE(6,25,2021)) datelist) ) 


tests = TestList [ TestLabel "Problem 3a - test1 " p3a_test1,
                   TestLabel "Problem 3a - test2 " p3a_test2,  
                   TestLabel "Problem 3a - test3 " p3a_test3, 
                   TestLabel "Problem 3a - test4 " p3a_test4, 
                   TestLabel "Problem 3a - test5 " p3a_test5, 
                   TestLabel "Problem 3a - test6 " p3a_test6, 
                   TestLabel "Problem 3a - test7 " p3a_test7, 
                   TestLabel "Problem 3a - test8 " p3a_test8, 
                   
                   TestLabel "Problem 3b - test1 " p3b_test1,
                   TestLabel "Problem 3b - test2 " p3b_test2 
                                     
                 ] 
                  

-- shortcut to run the tests
run = runTestTT  tests