-- CptS 355 - Spring 2022 -- Homework1 - Haskell
-- Name:Lovee Baccus 11604341
-- Collaborators: 

module HW1
     where

-- P1 - list_diff 15%
-- takes in two lists
-- if the current item does not exist in the other list, add it to the output
-- I forgot elem was a function whoops

list_diff :: Eq a => [a] -> [a] -> [a]
list_diff l1 l2 = (listDifHelper l1 l2) ++ (listDifHelper l2 l1)
     where
          listDifHelper [] l3 = []
          listDifHelper (x:xs) l3
               | x `elem` l3 = listDifHelper xs l3
               | otherwise = x : listDifHelper xs l3

-- P2  replace  15%
-- takes a list, a target, a replacement, and number of replacements to do
-- t can be used as a counter, so if t == 0, then we replaced enough
     -- so when we do the recursive call, we want to decrement t
replace :: (Num t, Eq t, Eq a) => [a] -> a -> a -> t -> [a]
replace [] v1 v2 n = [] -- if the list is empty, we don't do anything
replace l1 v1 v2 0 = l1 -- if n is zero, that means we have done all of the replacements
replace (x:xs) v1 v2 n 
     | (x == v1) = v2 : replace xs v1 v2 (n-1)    -- if we found the target, cons the replacement, and make the recursive call
                                                  -- since we made a replacement, we decrement n 
     | otherwise = x : replace xs v1 v2 n         -- since we dont want to replace, we just cons x again and do not decrement n

-- P3  max_date 10%
-- I think starting with the helper function is going to be ideal
-- helper function should just compare two tuples, and return the one that is the max
-- (Month, Day, Year)
-- I had to add in the Num types to make line 39 work, I'm not sure why
max_date :: (Num a1, Num a2, Num a3, Ord a1, Ord a2, Ord a3) => [(a2, a3, a1)] -> (a2, a3, a1)
max_date [] = (0,0,0) -- not sure what to return here
max_date [x] = x
max_date (x:xs) = max_date_helper x (max_date xs)
     where
          max_date_helper (a,b,c) (x,y,z)
               | c > z = (a,b,c)
               | z > c = (x,y,z)
               | a > x = (a,b,c)
               | x > a = (x,y,z)
               | b > y = (a,b,c)
               | y > b = (x,y,z)
               | otherwise = (a,b,c)

-- P4  num_paths  10%
-- similar to the maze problem we did in 122 lab I think 
-- I always feel like the code isn't doing enough, but thats because the recursion is doing the bulk of the work 
-- takes in the dimensions of the grid, m and n 
-- outputs the number of different paths we could take 
num_paths :: (Eq a, Num a) => a -> a -> a
num_paths 1 n = 1 -- base case, if there is only one option, we only have one path
num_paths m 1 = 1 -- base case, but flipped
num_paths m n = num_paths (m - 1) n + num_paths m (n - 1) -- we want to consider the options for the columns and rows, so we want to add them 

-- P5  (a) find_courses 10%
-- input is a list of tuples where the tuple is ("Class Name", ["Languages"]) and the target language
-- to look through the sublist of the languages, we will need a helper function I think
-- probably using `elem` 
-- output is a list of the classes that use the target language
find_courses :: Eq t1 => [(a, [t1])] -> t1 -> [a]
find_courses [] t1 = [] -- if the classes list is empty, we can return empty 
find_courses ((x, y):xs) t1 = if (t1 `elem` y) then (x : find_courses xs t1) else (find_courses xs t1)

-- I don't know why the gaurds weren't working here?
--   | t1 `elem` y = x : find_courses xs t1 -- if t1 `elem` y = add x to the output list and go to the next call
--   | otherwise = find_courses xs t1 -- otherwise = just go to the next call


-- P5  (b) max_count  15%
-- input -> takes a list of classes and their languages [(class, [languages])]
-- output -> the class that has the most languages as a tuple (class, num of languages) 
-- definitely need a helper function for this one 
-- I think the helper can return a tuple in the form of (class, num of lan)
     -- and then we can do something similar to max date where we just keep comparing them 
     -- the way I have it now, it isn't going to work because the helper is returning (string, int) and the function wants (string, List)
     -- so I think I either need to add another layer of helper function that converts that, or change my approach
     -- max_count_helper will keep returning till there is one element left
     -- maybe jave a base case where there is one element?? IDK if that will work tho 
     -- that didn't work completely because the recursive case doesn't type match 
-- lenght is a property of lists I think, so we can just go <length x> or something 

-- first thing to tackle is traversing through the main list
max_count :: [(a1, [a2])] -> (a1, Int)
max_count [] = ("",0) -- base case
max_count [(a,b)] = (a, length b)
max_count ((a,b):xs) = max_count_helper (a, b) ( max_count xs) -- this return the tuple in the input format, so we need to change it to length 
                    where
                         max_count_helper (a, b) (z, y)
                              | length b > length y = (a, b)
                              | length y > length b = (z, y)
                              | otherwise = (a, b)

-- P6  split_at_duplicate -- 15%
-- we will probably use a buffer where we copy the list till we find a dup 
-- then when we find a duplicate we can clear the buffer to start a new list
-- we will def need a helper function
     -- I think the helper function will have the buffer, and return the smaller list
-- when the helper spits out the smaller list, it will become an element in the output list 
split_at_duplicate :: Eq a => [a] -> [[a]] 
split_at_duplicate [] = [] -- if we get an empty list, we return an empty list 
split_at_duplicate (x:xs) = split_at_duplicate_helper x buf 