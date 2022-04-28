module P4_HW2tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

-- Sample Tree Integer examples given in the assignment prompt; make sure to provide your own tree examples in HW2Tests.hs file.
-- Your trees should have minimum 4 levels. 
t1 =  NODE 
         "Computer" 
         (NODE "of" (LEAF "School")(NODE 
                                      "Engineering" 
                                      (LEAF "Electrical") 
                                      (LEAF "and"))) 
          (LEAF "Science")

t2 = NODE 1 (NODE 2 (NODE 3 (LEAF 4) (LEAF 5)) (LEAF 6)) (NODE 7 (LEAF 8) (LEAF 9))
t3  = NODE 8 (NODE 2 (NODE 3 (LEAF 2) (LEAF 5)) (LEAF 1)) (NODE 1 (LEAF 8) (LEAF 5))

left = NODE 1 (NODE 2 (NODE 3 (LEAF 4) (LEAF 5)) (LEAF 6)) (NODE 7 (LEAF 8) (LEAF 9))
right = NODE 1 (NODE 2 (LEAF 3) (LEAF 6)) (NODE 7 (NODE 8 (LEAF 10) (LEAF 11)) (LEAF 9))

l1 = LEAF "1"
l2 = LEAF "2"
l3 = LEAF "3"
l4 = LEAF "4"
n1 = NODE "5" l1 l2
n2 = NODE "6" n1 l3
t4 = NODE "7" n2 l4

-----------------------------------------------------------     

p4a_test1 = TestCase (assertEqual "tree_scan test-1"  
                                   ["School","of","Electrical","Engineering","and","Computer","Science"] 
                                   (tree_scan t1) ) 
p4a_test2 = TestCase (assertEqual "tree_scan test-2" 
                                   [4,3,5,2,6,1,8,7,9] 
                                   (tree_scan t2) ) 
{-
p4b_test1 = TestCase (assertEqual "tree_search test-1" 
                                   3 
                                   (tree_search t3 1) ) 
p4b_test2 = TestCase (assertEqual "tree_search test-2" 
                                   1 
                                   (tree_search t3 8) )
p4b_test3 = TestCase (assertEqual "tree_search test-3" 
                                   (-1) 
                                   (tree_search t3 4) )
-}
addedTree = NODE 2 (NODE 4 (NODE 6 (LEAF 4) (LEAF 5)) (LEAF 12)) (NODE 14 (NODE 16 (LEAF 10) (LEAF 11)) (LEAF 18))
p4c_test1 = TestCase (assertEqual "merge_trees test-1" 
                                   addedTree  
                                   (merge_trees left right) ) 


tests = TestList [ TestLabel "Problem 4a - test1 " p4a_test1,
                   TestLabel "Problem 4a - test2 " p4a_test2,
                   --TestLabel "Problem 4b - test1 " p4b_test1,
                   --TestLabel "Problem 4b - test2 " p4b_test2,
                   --TestLabel "Problem 4b - test3 " p4b_test3,
                   TestLabel "Problem 4c - test1 " p4c_test1
                 ] 
                  

-- shortcut to run the tests
run = runTestTT  tests