-- CptS 355 - Spring 2022 -- Homework2 - Haskell
-- Name:
-- Collaborators: 
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

module HW2
     where

eliminateDuplicates :: Eq a => [a] -> [a]
eliminateDuplicates [] = [] -- base case, if the list is empty 
eliminateDuplicates [x] = [x] -- base case, if the list onlly has one element
eliminateDuplicates (x:xs)
     |x `elem` xs =  eliminateDuplicates xs
     |otherwise = x : eliminateDuplicates xs -- if its unique then we add it to the list so it will take the last occurance of the duplicate 


-- P1 - commons, commons_tail, and commons_all 

-- takes two lists, if an elements is in both, adds it to the output list 
-- should not have any duplicates
-- order doesnt matter
-- we can use elem 
-- similar to HW 1, but that was the elemnts that weren't duplicates, and we kept all the duplicates in the output
-- I think we can go through one list instead of both, because it has to be in both lists to work
-- if x `elem` l2 = x:commons xs l2 -- this doesnt account for duplicates
-- we could add a buf parameter and use compound logic, but then idk how we would do pt 2
-- helper function? instead of tail recursion 
-- (a) commons – 5%
commons :: Eq a => [a] -> [a] -> [a]
commons [] [] = [] -- base case, empty lists return empty lists
commons [] l2 = [] -- base case, if one is empty then the elemts can't appear in both 
commons l1 [] = []  
commons l1 l2 = eliminateDuplicates( listDifHelper l1 l2)       
     where
          listDifHelper [] l3 = []
          listDifHelper (x:xs) l3
               | x `elem` l3 = x:listDifHelper xs l3
               | otherwise = listDifHelper xs l3

-- should similar to what I have above, but with a helper function that uses a buffer I think 
-- I think it will be a lot cleaner to use filter for this instead of how I did part a with the helper function
-- (b) commons_tail –  9%
-- commons l1 l2 = eliminateDuplicates( filter (\x -> x `elem` l2) l1 )  
commons_tail :: Eq a => [a] -> [a] -> [a]
commons_tail [] [] = [] -- base case, empty lists return empty lists
commons_tail [] l2 = [] -- base case, if one is empty then the elemts can't appear in both 
commons_tail l1 [] = []
commons_tail l1 l2 = commons_tail_helper l1 l2 []
                    where
                         commons_tail_helper [] [] buf = reverse buf
                         commons_tail_helper l1 [] buf = reverse buf
                         commons_tail_helper [] l2 buf = reverse buf
                         commons_tail_helper (x:xs) l2 buf = if (x `elem` l2) && (x `notElem` buf) then commons_tail_helper xs l2 (x:buf) else commons_tail_helper xs l2 buf

-- (c) commons_all –  3%
-- takes a list of lists
-- returns an element to the output list iff the element exists in all of the sublists
-- use fold and commons to implement
commons_all :: Eq a => [[a]] -> [a]
commons_all [] = []
commons_all (x:xs) = foldl commons x xs
------------------------------------------------------
-- P2  find_courses and max_count 

-- takes a list of target classes
-- of those classes, return the common elements from their languages lists
-- we will want to run commons_all on each target's list value, which is the snd touple 
-- to access the snd elemnt of the touple, we can use a few things... a helper function 
-- thought I had it but then I was using recursion in the helper :|
-- (a) find_languages – 10%
find_languages::(Eq a1, Eq a2) => [(a2, [a1])] -> [a2] -> [a1]
find_languages [] [] = []
find_languages l1 [] = []
find_languages [] l2 = []
find_languages l1 l2 = commons_all (map snd (filter ((`elem` l2).fst) l1))

-- commons_all needs to have a list of lists, so we can't just use the second element of the touple, we need to format it 
-- I think using filter we can have the op be an anon func that spits out the snd element of the touple?? that might be janky tho
-- we need to see if they are one of the target classes before we return the languages list, so I will have to add another function to check that
                                             -- for each element in l1, take the fst and run elem against l2
                                             -- this will produce the list of the touples that are in the target 
                                        -- map snd is saying for each of the elemtns in the list that filter spit out,
                                        -- we want to create a new list that is just the second part of the touple
                                        -- the ((`elem` l2).fst) is the hardest part to read but thats because of how the filter func works I think

     
-- this one we are using the languages as the target
-- so, if we find the target, then we add that class to the list of classes that use that language, and stick that list in a touple
-- so the ouput is a list of touples in the form (target language, [classes that use that language])
-- we take the given input list, and the targets in a list, and then spit out the list of output touples

-- for each element in the target list, we want to find all the classes that use that element
     -- for a class to use that element, it means that element exists in the list of languages
     -- aka, that element is in the snd elemnt of the touple, becuase that is a list 

-- very similar to last semester stopsAt stops buses = map (fst) (filter (\x -> elemAll stops (snd x)) buses)
-- that is using map to just returnt the first element of the touple tho, and we want to
-- (b) find_courses – 12%
--find_courses :: Eq t1 => [(a, [t1])] -> [t1] -> [(t1,[a])]
--find_courses classes target = 
     
------------------------------------------------------
-- P3  nested_max, max_maybe, and max_numbers
-- no recursion but use map, and foldl or foldr 
-- (a) nested_max - 2%
nested_max :: [[Int]] -> Int
nested_max [] = minBound 
nested_max l1 = foldr max minBound (map (foldr (max) minBound ) l1) 

-- (b) max_maybe - 8%
max_maybe :: Ord a => [[Maybe a]] -> Maybe a
max_maybe [] = Nothing 
max_maybe l1 = foldr max Nothing (map (foldr (max) Nothing ) l1)

-- (c) max_numbers - 8%
data Numbers = StrNumber String | IntNumber Int
 deriving (Show, Read, Eq)

getInt x = read x::Int

toInt :: Numbers -> Int
toInt (StrNumber s) = read s
toInt (IntNumber i) = i

-- I needed to add another layer of map to helper function, because I wanted the output to be a nested list 
-- and then the getInt function needed to check for both cases, of str or int 
max_numbers :: [[Numbers]] -> Int
max_numbers [] = minBound 
max_numbers l1 = foldr max minBound (map (foldr (max) minBound ) (convert_Helper l1))
     where convert_Helper l1 = map (map toInt) l1

------------------------------------------------------
-- P4  tree_scan, tree_search, merge_trees
data Tree a = LEAF a | NODE a (Tree a) (Tree a)
 deriving (Show, Read, Eq)

-- (a) tree_scan 5%
-- in order traversal
-- takes the tree and generates a list of the values
tree_scan :: Tree a -> [a]
tree_scan (LEAF x) = [x]
tree_scan (NODE x t1 t2) = (tree_scan t1) ++ (tree_scan (LEAF x)) ++ (tree_scan t2)

{-
-- (b) tree_search 12%
-- I think we will use a helper function to check for equality and keep track of the layer in a parameter
tree_search :: (Ord p, Num p, Eq a) => Tree a -> a -> p
tree_search (LEAF _) a = -1
tree_search (LEAF x) a 
     |a == x = 1
tree_search (NODE x t1 t2) a = (tree_search t1 a) (tree_search (LEAF x) a) (tree_search t2 a)
-}
     
-- (c) merge_trees  14%
-- takes two trees, and adds their corresponding nodes together
-- so we traverse the two trees, add the elements, and then put that element in the output tree
-- if there is only one element to add, then we just copy it over
-- so it can kind of be a modified scan, with some extra stuff
merge_trees :: Num a => Tree a -> Tree a -> Tree a
merge_trees (LEAF x1)(LEAF x2) = LEAF ( x1 + x2) -- we are at the bottom of the tree, and we have two leaves to add
merge_trees (LEAF x1) (NODE x2 left right) = NODE (x1 + x2) left right -- we have one leaf, but one more layer in the other tree
merge_trees (NODE x1 left right) (LEAF x2) = NODE (x1 + x2) left right -- same thing but the flippity flip flop
merge_trees (NODE x1 left1 right1) (NODE x2 left2 right2) = NODE (x1 + x2) (merge_trees left1 left2) (merge_trees right1 right2)

