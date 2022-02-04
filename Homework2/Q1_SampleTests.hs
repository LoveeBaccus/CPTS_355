{-Haskell HW2-Q1 HUnit test cases-}

module Q1_SampleTests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

                        
p1_test1 = TestCase (assertEqual "groupbyNTail-test1" [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15]] (groupbyNTail [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] 4) )  
p1_test2 = TestCase (assertEqual "groupbyNTail-test2" ["abcde","fghij","klmno","pqrst","uwxyz","012"]  (groupbyNTail "abcdefghijklmnopqrstuwxyz012" 5) ) 

tests = TestList [ TestLabel "Problem 1 - test1 " p1_test1,
                   TestLabel "Problem 1 - test2 " p1_test2
                 ] 
                  

-- shortcut to run the tests
run = runTestTT  tests