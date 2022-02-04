-- CptS 355 - Fall 2021 -- Homework1 - Haskell
-- Name:Lovee Baccus
-- Collaborators: Josie Martin and Shira Feinburg

module HW1
     where

-- Q1 everyOther
-- the function is accepting a list and returning a list w/ every other element removed
everyOther :: [a] -> [a]
everyOther [] = [] -- base case, if the list is empty 
everyOther [x] = [x] -- base case, if the list onlly has one element
     -- the x part retains the first element, the y part discards the seconds one
     -- the x : part is where it is getting attached to the new list we are returning
everyOther (x:y:xs) = x : everyOther xs -- recursive call, saying keep this part and then do it again with the xs

-- Q2(a) eliminateDuplicates
-- the function is accepting Eq because we need to be able to check for equality
-- it returns a list
eliminateDuplicates :: Eq a => [a] -> [a]
eliminateDuplicates [] = [] -- base case, if the list is empty 
eliminateDuplicates [x] = [x] -- base case, if the list onlly has one element
eliminateDuplicates (x:xs)
     |x `elem` xs =  eliminateDuplicates xs
     |otherwise = x : eliminateDuplicates xs

-- Q2(b) matchingSeconds
-- accepts a list of tuples and a target value, returns a list where the target is found
matchingSeconds :: Eq t => t -> [(t,a)] -> [a]
matchingSeconds t [] = [] --the list is empty but ou still need to have the target variable
matchingSeconds t (x:xs)
     | t == fst x = snd x : matchingSeconds t xs
     |otherwise = matchingSeconds t xs


-- Q2(c) clusterCommon
-- accepts a list of touples
-- if the first element is not unique, it gets grouped
     -- the first element is the "key" and we group them with the keys
-- once we have them all combined, we wanna return the new list of combined touples
clusterCommon :: (Eq t, Eq a) => [(t,a)] -> [(t,[a])]
clusterCommon [] = []
clusterCommon iL = eliminateDuplicates (clusterCommon' iL)
     where 
          clusterCommon' [] = []
          clusterCommon' ((a,b):xs) = (a,matchingSeconds a iL) : clusterCommon' xs
-- Q3 maxNumCases
-- accepts a touple representing each contries' data - the first element is the country, the second is a list of data
-- the second element of data, is a touple itself, and is month and number of new cases
-- we want to look at a month, and return which country had the most new cases that month
     -- we are returning the number of cases that country had, not the name of the country
maxNumCases :: (Num p, Ord p, Eq t) => [(a,[(t,p)])] -> t -> p
maxNumCases [] _ = 0 -- returns 0 if the list is empty
maxNumCases iL month = maxNumCasesHelper iL month  0 --creating the helper function and creating the "basket" to catch the output of the helper function
                    where maxNumCasesHelper [] month maxCases = maxCases --if the list is empty, return the current max
                          maxNumCasesHelper ((county, cases): xs) month maxCases = maxNumCasesHelper xs month (monthMaxHelper cases month `max` maxCases)--creating the basket for the max to go into
                                                                                where monthMaxHelper [] _ = 0
                                                                                      monthMaxHelper ((curMonth, numCases):xs ) month
                                                                                          |curMonth == month = numCases 
                                                                                          |otherwise = monthMaxHelper xs month

-- anytime you want a value its gotta be returned from a helper function

-- Q4 groupIntoLists
-- accepts one list, reorganizes it, and then puts it in the other list of lists
groupIntoLists :: [a] -> [[a]]
groupIntoLists [] = []
groupIntoLists iL = groupIntoListsHelper iL 1 []
                    where groupIntoListsHelper[] n buf = [reverse buf]
                          groupIntoListsHelper (x:xs) n buf | length buf >= n = reverse buf:groupIntoListsHelper xs (n+1) [x] -- this part keeps chopping it up keeping track of what size we are at
                                                            | otherwise = groupIntoListsHelper xs n (x:buf) -- this part adds the leftover bits 

-- Q5 getSlice 
-- accepts a list and the delimeters for the list
-- returns the chunk that is in between the two delimeters
getSlice :: Eq a => (a,a) -> [a] -> [a]
getSlice _ [] = []
getSlice (first, last) iL = getSliceHelper (first,last) iL [] False 
                         where getSliceHelper first [] buf _ = reverse buf
                               getSliceHelper (first, last) (x:xs) buf True = if x == last then reverse buf else getSliceHelper (first, last) xs (x:buf) True -- we found the end deliminator so we flip the flag to true to stop the recursion
                               getSliceHelper (first, last) (x:xs) buf False = if x == first then getSliceHelper (first, last) xs buf True else getSliceHelper (first, last) xs buf False

-- push everything onto the buffer until you find the first instance of the last delimeter
-- then discard the rest of the string and flip it 
-- we can then go through that list till we find the first delimeter, and discard everything after that -- it would be before the delimeter if we hadn't pulled a switcha roo
-- reverse it again becuase you had the first at the end
-- finding the first instance of the last delimeter, then we keep pushing everything into the buffer until we find the first delimeter
-- at that point it would be backwards, so 