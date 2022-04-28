-- CptS 355 - Spring 2022 -- Homework1 - Haskell
-- Name:Lovee Baccus 11604341
-- Collaborators: 

module HW1
     where

-- P1 - list_diff 15%
-- takes in two lists
-- if the current item does not exist in the other list, add it to the output
-- I think the helper function might use map or filter or something to search the second list most effectively
-- I forgot elem was a function whoops

list_diff :: Eq a => [a] -> [a] -> [a]
list_diff l1 l2 = (listDifHelper l1 l2) ++ (listDifHelper l2 l1)
     where
          listDifHelper [] l2 = []
          listDifHelper (x:xs) l2
               | x 'elem' xs = listDifHelper xs l2
               | otherwise = x: listDifHelper xs l2