{-  To run the tests type "run" at the Haskell prompt.  -} 

module P5_HW1tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1
                                                   
-- find_courses and max_count tests 

-- make sure that the below list is not defined in HW1.hs
progLanguages =
     [ ("CptS121" , ["C"]),
     ("CptS122" , ["C++"]),
     ("CptS223" , ["C++"]),
     ("CptS233" , ["Java"]),
     ("CptS321" , ["C#"]),
     ("CptS322" , ["Python","JavaScript"]),
     ("CptS355" , ["Haskell", "Python", "PostScript", "Java"]),
     ("CptS360" , ["C"]),
     ("CptS370" , ["Java"]),
     ("CptS315" , ["Python"]),
     ("CptS411" , ["C", "C++"]),
     ("CptS451" , ["Python", "C#", "SQL"]),
     ("CptS475" , ["Python", "R"])
     ]
                                
p5a_test1 = TestCase (assertEqual "(find_courses-test1)" 
                                  ["CptS322","CptS355","CptS315","CptS451","CptS475"] 
                                  (find_courses progLanguages "Python") ) 
p5a_test2 = TestCase (assertEqual "(find_courses-test2)" 
                                  ["CptS122","CptS223","CptS411"]
                                  (find_courses progLanguages "C++") )                             
p5a_test3 = TestCase (assertEqual "(find_courses-test3)" 
                                  []
                                  (find_courses progLanguages "Go") )                           


--p5b_test1 = TestCase (assertEqual "(max_count-test1)" 
--                                   ("CptS355",4)
--                                   (max_count progLanguages) ) 
tests = TestList [                                      
                   TestLabel "Problem 5a- test1 " p5a_test1, 
                   TestLabel "Problem 5a- test2 " p5a_test2,
                   TestLabel "Problem 5a- test3 " p5a_test3 
                   --TestLabel "Problem 5b- test1 " p5b_test1
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests