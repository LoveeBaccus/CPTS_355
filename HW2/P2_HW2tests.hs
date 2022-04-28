module P2_HW2tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

---------------------------------------------------------
{-Test input for find_languages and find_courses-}
progLanguages =
     [ ("CptS121" , ["C"]),
     ("CptS122" , ["C++"]),
     ("CptS223" , ["C++"]),
     ("CptS233" , ["Java"]),
     ("CptS321" , ["C#","Java"]),
     ("CptS322" , ["Python","JavaScript"]),
     ("CptS355" , ["Haskell", "Python", "PostScript", "Java"]),
     ("CptS360" , ["C"]),
     ("CptS370" , ["Java"]),
     ("CptS315" , ["Python"]),
     ("CptS411" , ["C", "C++"]),
     ("CptS451" , ["Python", "C#", "SQL","Java"]),
     ("CptS475" , ["Python", "R"])
     ]
-----------------------------------------------------------     

p2a_test1 = TestCase (assertEqual "find_languages test-1" 
                                    (["Java"])  
                                    (find_languages progLanguages ["CptS451", "CptS321", "CptS355"]) )
p2a_test2 = TestCase (assertEqual "find_languages test-2" 
                                    ([])  
                                    (find_languages progLanguages ["CptS451", "CptS321", "CptS355","CptS411"]) )
p2a_test3 = TestCase (assertEqual "find_languages test-3" 
                                    (["Python"])  
                                    (find_languages progLanguages ["CptS451", "CptS322", "CptS355","CptS475"]) )

--p2b_test1 = TestCase (assertEqual "find_courses test-1" 
  --                                  ([("Python",["CptS322","CptS355","CptS315","CptS451","CptS475"]),("C",["CptS121","CptS360","CptS411"]),("C++",["CptS122","CptS223","CptS411"])])  
    --                                (find_courses progLanguages ["Python","C","C++"]) )
--p2b_test2 = TestCase (assertEqual "find_courses test-2" 
  --                                  ([("Java",["CptS233","CptS321","CptS355","CptS370","CptS451"]),("Go",[]),("R",["CptS475"])])  
    --                                (find_courses progLanguages ["Java","Go","R"]) )

tests = TestList [ TestLabel "Problem 2a  - test1 " p2a_test1,
                   TestLabel "Problem 2a  - test2 " p2a_test2,  
                   TestLabel "Problem 2a  - test3 " p2a_test3
                   --TestLabel "Problem 2b  - test1 " p2b_test1,
                   --TestLabel "Problem 2b  - test2 " p2b_test2
                 ] 
                  

-- shortcut to run the tests
run = runTestTT  tests