{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW2Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

------------------------------------------------------
-- INCLUDE YOUR TREE EXAMPLES HERE
t1 =  NODE 
         "Lovee" 
         (NODE "Baccus" (LEAF "is")(NODE 
                                      "not" 
                                      (LEAF "good") 
                                      (LEAF "at"))) 
          (LEAF "Haskell")

t2 = NODE 17 (NODE 20 (NODE (-4) (LEAF 0) (LEAF (-9))) (LEAF 90)) (NODE 2 (LEAF 8) (LEAF 9))

------------------------------------------------------

-- P1 - commons, commons_tail, and commons_all 
-- (a) commons tests
p1a_test1 = TestCase (assertEqual "commons test-1" 
                                   (sort [-1,0,2])  
                                   (sort (commons [-1,-1,-1,0,2,3,4,5] [-1,0,2,7,8,9])) ) 
p1a_test2 = TestCase (assertEqual "commons test-2" 
                                    (sort [])  
                                    (sort (commons [] [8,8,10,10,11,12,5])) ) 
p1a_test3 = TestCase (assertEqual "commons test-3" 
                                    ["L", "O"]  
                                    (commons ["L","O","V"] ["E","E","L","O"]) )

-- (b) commons_tail tests
p1b_test1 = TestCase (assertEqual "commons_tail test-1" 
                                    (sort [])  
                                    (sort (commons_tail [1,2,3,4] [5,6,7,8])) ) 
p1b_test2 = TestCase (assertEqual "commons_tail test-2" 
                                    (sort [1])  
                                    (sort (commons_tail [1,1,1,1,1] [1,1,1,1])) ) 
p1b_test3 = TestCase (assertEqual "commons_tail test-3" 
                                    ["o"]  
                                    (commons_tail ["l","o","v", "e","e"] ["m","o","n","a"]) ) 

-- (c) commons_all tests
p1c_test1 = TestCase (assertEqual "commons_all test-1" 
                                    (sort [3])  
                                    (sort (commons_all [[1,2,3],[3,4,5],[6,7,3,8,9],[1,4,6,3,7]])) )
p1c_test2 = TestCase (assertEqual "commons_all test-2" 
                                    [-3]  
                                    (sort (commons_all [[-1,-2,-3],[-3,-4,10,14],[-3,-4,5,6]])) )
p1c_test3 = TestCase (assertEqual "commons_all test-3" 
                                    (sort [])  
                                    (sort (commons_all [[3,4,5,5,6],[4,5,6],[],[3,4,5]])) )

------------------------------------------------------
-- P2  find_courses and max_count 
progLanguages =
     [ ("Lovee" , ["Camping", "Basketball", "Comp Sci", "Nails"]),
     ("Morgan" , ["Nails", "Comp Sci", "Taxes", "Playing with Scout"]),
     ("Austin" , ["Comp Sci", "Basketball", "Video Games"]),
     ("Scout" , ["Playing with Scout"]),
     ("Mama" , ["Nails", "Basketball", "WSU Football"]),
     ("Dad" , ["Camping", "Basketball", "WSU Football", "Microsoft", "Motorcycles"]),
     ("Flapjack" , ["Biting Morgan's Nose"])
     ]

-- (a) find_languages tests
p2a_test1 = TestCase (assertEqual "find_languages test-1" 
                                    (["Comp Sci"])  
                                    (find_languages progLanguages ["Lovee", "Austin", "Morgan"]) )
p2a_test2 = TestCase (assertEqual "find_languages test-2" 
                                    ([])  
                                    (find_languages progLanguages ["Morgan", "Scout", "Flapjack"]) )
p2a_test3 = TestCase (assertEqual "find_languages test-3" 
                                    (["Basketball"])  
                                    (find_languages progLanguages ["Lovee", "Austin", "Dad"]) )
{-
-- (b) find_courses tests
-- Sakire's Tests, not modified yet
p2b_test1 = TestCase (assertEqual "find_courses test-1" 
                                    ([("Python",["CptS322","CptS355","CptS315","CptS451","CptS475"]),("C",["CptS121","CptS360","CptS411"]),("C++",["CptS122","CptS223","CptS411"])])  
                                    (find_courses progLanguages ["Python","C","C++"]) )
p2b_test2 = TestCase (assertEqual "find_courses test-2" 
                                    ([("Java",["CptS233","CptS321","CptS355","CptS370","CptS451"]),("Go",[]),("R",["CptS475"])])  
                                    (find_courses progLanguages ["Java","Go","R"]) )
-}
------------------------------------------------------
-- P3  nested_max, max_maybe, and max_numbers
-- (a) nested_max tests
p3a_test1 = TestCase (assertEqual "nested_max test-1" 
                                    6 
                                    (nested_max [[-2,-3,-45],[4,5],[6]]) ) 
p3a_test2 = TestCase (assertEqual "nested_max test-2" 
                                    10 
                                    (nested_max [[],[],[10]]) ) 
p3a_test3 = TestCase (assertEqual "nested_max test-3" 
                                    0 
                                    (nested_max [[-12,-23,-34],[-45,0,-55],[-63,0,-74,0,-86,-97]]) ) 

-- (b) max_maybe tests
p3b_test1 = TestCase (assertEqual "max_maybe test-1" 
                                   (Just 55) 
                                   (max_maybe [[(Just 1),(Just 2),(Just 3)],[(Just 44),(Just 55)],[Nothing ],[],[Nothing ]]) )
p3b_test2 = TestCase (assertEqual "max_maybe test-2" 
                                   (Just "x") 
                                   (max_maybe [[(Just "a"),Nothing],[(Just "x"), (Just "B"), (Just "Z"),Nothing,Nothing]]) )
p3b_test3 = TestCase (assertEqual "max_maybe test-3" 
                                   (Nothing::(Maybe Int))
                                   (max_maybe [[Nothing]]) )

-- (c) max_numbers tests
-- Sakire's Tests, not modified yet
p3c_test1 = TestCase (assertEqual "max_numbers test-1" 
                                    (72) 
                                    (max_numbers [[StrNumber "-1",IntNumber 2,IntNumber 24],[StrNumber "0",IntNumber 5],[IntNumber 6,StrNumber "72"],[],[StrNumber "8"]]) )
p3c_test2 = TestCase (assertEqual "max_numbers test-2" 
                                    (10) 
                                    (max_numbers [[],[],[StrNumber "10"],[]]) )
p3c_test3 = TestCase (assertEqual "max_numbers test-3" 
                                    (minBound::Int) 
                                    (max_numbers  [[]]) )

------------------------------------------------------
-- P4  tree_scan, tree_search, merge_trees
-- (a) tree_scan tests
-- Sakire's Tests, not modified yet
p4a_test1 = TestCase (assertEqual "tree_scan test-1"  
                                   ["is","Baccus","good","not","at","Lovee","Haskell"] 
                                   (tree_scan t1) ) 

p4a_test2 = TestCase (assertEqual "tree_scan test-2" 
                                   [0,-4,-9,20,90,17,8,2,9] 
                                   (tree_scan t2) )
-- (b) tree_search tests
-- Sakire's Tests, not modified yet

-- (c) merge_trees  tests
left = NODE 1 (NODE 2 (NODE 3 (LEAF 4) (LEAF 5)) (LEAF 6)) (NODE 7 (LEAF 8) (LEAF 9))
right = NODE 1 (NODE 2 (LEAF 3) (LEAF 6)) (NODE 7 (NODE 8 (LEAF 10) (LEAF 11)) (LEAF 9))

addedTree = NODE 2 (NODE 4 (NODE 6 (LEAF 4) (LEAF 5)) (LEAF 12)) (NODE 14 (NODE 16 (LEAF 10) (LEAF 11)) (LEAF 18))
p4c_test1 = TestCase (assertEqual "merge_trees test-1" 
                                   addedTree  
                                   (merge_trees left right) ) 
 
------------------------------------------------------

-- add the test cases you created to the below list. 
tests = TestList [ TestLabel "Problem 1a - test1 " p1a_test1,
                   TestLabel "Problem 1a - test2 " p1a_test2,
                   TestLabel "Problem 1a - test3 " p1a_test3,                   
                   TestLabel "Problem 1b - test1 " p1b_test1,
                   TestLabel "Problem 1b - test2 " p1b_test2,                   
                   TestLabel "Problem 1b - test3 " p1b_test3,                                      
                   TestLabel "Problem 1c - test1 " p1c_test1,
                   TestLabel "Problem 1c - test2 " p1c_test2,
                   TestLabel "Problem 1c - test3 " p1c_test3,
                   TestLabel "Problem 2a  - test1 " p2a_test1,
                   TestLabel "Problem 2a  - test2 " p2a_test2,  
                   TestLabel "Problem 2a  - test3 " p2a_test3,
                   --TestLabel "Problem 2b  - test1 " p2b_test1,
                   --TestLabel "Problem 2b  - test2 " p2b_test2,
                   TestLabel "Problem 3a - test1 " p3a_test1,
                   TestLabel "Problem 3a - test2 " p3a_test2,  
                   TestLabel "Problem 3a - test3 " p3a_test3,                    
                   TestLabel "Problem 3b - test1 " p3b_test1,
                   TestLabel "Problem 3b - test2 " p3b_test2,
                   TestLabel "Problem 3b - test3 " p3b_test3,
                   TestLabel "Problem 3c - test1 " p3c_test1,
                   TestLabel "Problem 3c - test2 " p3c_test2,
                   TestLabel "Problem 3c - test3 " p3c_test3,
                   TestLabel "Problem 4a - test1 " p4a_test1,
                   TestLabel "Problem 4a - test2 " p4a_test2,
                   --TestLabel "Problem 4b - test1 " p4b_test1,
                   --TestLabel "Problem 4b - test2 " p4b_test2,
                   --TestLabel "Problem 4b - test3 " p4b_test3,
                   TestLabel "Problem 4c - test1 " p4c_test1
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests