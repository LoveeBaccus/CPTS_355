module HW2
     where

{- 1. groupbyNTail - 10%-}
-- in general to make something tail recursive, we add an extra parameter to keep track of whatever would have been left on the stack 
-- in this case we need two buffers - one for whatever is in the temperary, small list, and then the leftover bits that still need to be processed
-- first attempt forgot to reverse the buffer
-- second attempt I reversed the outer list, but the sublists were still backwards
-- third attempt I forgot to add the reverse in the base case as well -- everytime we return the buf it needs to be flipped
groupbyNTail :: [a] -> Int -> [[a]]
groupbyNTail l1 n = reverse (groupHelper l1 [] []) -- unlike the given example, we have an extra list 
                    where 
                         groupHelper [] buf acc = reverse buf:acc                         -- if l1 is empty, we just wanna return the buf as is (if there was a random leftover part)
                         groupHelper (x:xs) buf acc                                       -- if l1 isn't empty then we gotta process it more
                              | length buf == n = groupHelper xs [x] (reverse buf:acc)    -- we filled up the sub list, so we clear the buf and put x in it to start again for the next loop
                              | otherwise = groupHelper xs (x:buf) acc                     -- if the sublist isn't full, we want to add the current item to it

-----------------------------------------------------------

{- 2.  elemAll and stopsAt  -  20% -}

{- (a)  elemAll - 10%-}
-- please don't include the myCatsLog list in your solution file. 

-- I think we can use filter with elem to get rid of the items that aren't targets 
-- we need to seperate each element of the target list and call elem for each element because elem only checks a single value 
-- then we can check for equality between the two lists??  because filter is going to take anything that doesnt match out, we can just check the length 
-- does filter remove duplicates?? like what if l2 had multiple instances of the targets 
-- look at count from lab 2
-- filter (\x -> (elem x l2)) l1 

elemAll :: Eq a => [a] -> [a] -> Bool 
elemAll [] _ = False -- if either list is empty we can just return false (I think) 
elemAll _ [] = False 
elemAll l1 l2 = length (filter (\x -> (elem x l2)) l1) == length l1

{- (b) stopsAt - 10%-}
buses = [ ("Wheat",["Chinook", "Orchard", "Valley", "Maple","Aspen", "TerreView", "Clay", "Dismores", "Martin", "Bishop", "Walmart", "PorchLight", "Campus"]),
          ("Silver",["TransferStation", "PorchLight", "Stadium", "Bishop","Walmart", "Shopco", "RockeyWay"]),
          ("Blue",["TransferStation", "State", "Larry", "TerreView","Grand", "TacoBell", "Chinook", "Library"]),
          ("Gray",["TransferStation", "Wawawai", "Main", "Sunnyside","Crestview", "CityHall", "Stadium", "Colorado"])
        ]

-- buses is [(a,[a])]
-- stops is just [a]
-- in order to use our elemAll, we need to break down the buses into the the tuples to access the list
-- map would apply elemAll and return a list 
-- I think we need to use filter, but I am not sure if we use filter or map first 
stopsAt ::Eq a => [a] -> [(a,[a])] -> [a] -- we need to have the Eq part to be able to use our elemAll
-- we can use filter on buses, to filter out any route touples that don't work
-- once we have a pared down list that only has route touples that meet our condition, we can use map to just retain the route Name
-- we just want to return a list of route names
stopsAt stops buses = map (fst) (filter (\x -> elemAll stops (snd x)) buses)
-----------------------------------------------------------

{- 3. isBigger and applyRange - 25% -}

-- define the Timestamp datatype
-- mont, day, year
-- mont, day, year, hour, min
data Timestamp =  DATE (Int,Int,Int) |  DATETIME (Int,Int,Int,Int,Int) 
                  deriving (Show, Eq)

{- (a)  isBigger - 15% -}
-- is first value bigger than second?
-- first attempt 
-- I could try to figure out the better way, or I could just brute force it
-- first attempt, I checked it backwards -- we need to check the year feild first
-- second attempt I did the day before the month like a fool even though I just fixed that mistake 
isBigger :: Timestamp -> Timestamp -> Bool
isBigger (DATE(a,b,c)) (DATE(x,y,z))    | c > z = True      -- year
                                        | c < z = False 
                                        | a > x = True      -- month
                                        | a < x = False
                                        | b > y = True      -- day
                                        | otherwise = False 

isBigger (DATE(a,b,c)) (DATETIME(x,y,z,w,v)) | c > z = True      -- year
                                             | c < z = False 
                                             | a > x = True      -- month
                                             | a < x = False
                                             | b > y = True  
                                             | b < y = False    -- day
                                             | otherwise = False

isBigger (DATETIME(a,b,c,d,e)) (DATE(x,y,z)) | c > z = True      -- year
                                             | c < z = False 
                                             | a > x = True      -- month
                                             | a < x = False
                                             | b > y = True  
                                             | b < y = False    -- day
                                             | otherwise = False

-- DATETIME : mont, day, year, hour, min
isBigger (DATETIME(a,b,c,d,e)) (DATETIME(x,y,z,w,v))   | c > z = True      -- year
                                                       | c < z = False 
                                                       | a > x = True      -- month
                                                       | a < x = False
                                                       | b > y = True  
                                                       | b < y = False    -- day
                                                       | d > w = True     -- hour
                                                       | d < w = False 
                                                       | e > v = True      -- min
                                                       | otherwise = False
{- (b) applyRange - 10% -}
-- first attempt failed two test cases
-- I had the parameters backwards so I just had to do a little switch a roo
applyRange :: (Timestamp,Timestamp) -> [Timestamp] -> [Timestamp]
applyRange a l1 = filter (\x-> isBigger x (fst a) && isBigger (snd a) x) l1

-----------------------------------------------------------
{-4 - foldTree, createRTree, fastSearch  - 35%-}

--define Tree and RTree data types
data Tree a = LEAF a | NODE a (Tree a) (Tree a)
               deriving (Show,  Eq, Ord)

data RTree a = RLEAF a | RNODE a (a,a) (RTree a) (RTree a)
                    deriving (Show, Eq, Ord)

{- (a) foldTree - 8% -}
-- basically a modified TreeMap from the lecture slides 
foldTree :: (t -> t -> t) -> Tree t -> t
foldTree op (LEAF x) = x
foldTree op (NODE x tree1 tree2) = op x (op (foldTree op tree1) (foldTree op tree2))

{- (b) createRTree - 12% -}

{- (c) fastSearch - 15% -}

-------------------------------------------------------------------

{- Tree Examples 5% -}
-- include your tree examples in the test file. 

{-Testing your tree functions - 5%-}


