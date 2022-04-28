{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW1Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import 2022HW1

-- P1. list_diff tests

 
-- P2. replace tests


-- P3. max_date tests                                  


-- P4. num_paths tests                                  

                                                           
-- P5. (a) and (b)

-- find_courses tests 

-- max_count tests  (one test is sufficient)



-- split_at_duplicate tests


-- add the test cases you created to the below list. 
tests = TestList [ 
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests