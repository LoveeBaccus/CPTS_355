-- CptS 355 - Lab 2 (Haskell) - Fall 2021
-- Name: Lovee Baccus
-- Collaborated with: Shira Feindburg & Josie Martin

module Lab2
     where


-- 1
{- (a) merge2 -}
-- accepts two lists and merges them together by grabbing one element from each of them and stringing them together
-- the longer list can just get appended to the end 
merge2 :: [a] -> [a] -> [a]
merge2 [] y = y
merge2 x [] = x
merge2 (x:xs) (y:ys) = x:y:merge2 xs ys


{- (b) merge2Tail -}
-- changing part a to tail recursion
merge2Tail :: [a] -> [a] -> [a]
--merge2Tail [][] = [] -- base case
merge2Tail l1 l2 = merge2TailHelper l1 l2 []
                    where
                         merge2TrailHelper [] [] acc = reverse acc                             -- we need this base case because of how we did the other ones
                         merge2TailHelper [] (y:ys) acc = merge2TailHelper ys [] (y:acc)       -- this is where we handle one list being longer than the other
                                                                                               -- you have to add the extra part to the acc befor eyou can reverse it, 
                                                                                               -- otherwise you loose the part that is longer, that is why we cons 
                         merge2TailHelper (x:xs) [] acc = merge2TailHelper [] xs (x:acc)
                         merge2TailHelper (x:xs) (y:ys) acc = merge2TailHelper xs ys (y:x:acc)


{- (c) mergeN -}
-- accepts a list of lists, and merges them all together
-- start by merging the first two into one, and then merging the next one into that new list you just made
-- repeat till there are no more lists to combine
-- we should use merge2 and foldl, but without using explicit recursion
mergeN :: [[a]] -> [a]
mergeN [] = [] -- base case, return empty 
mergeN (x:xs) = foldl merge2 x xs 


-- 2
{- (a) count -}
-- accepts a list and a target value, counts how many times the target occurs in the list
-- should not be recursive, but uses a higher order function
-- higher order functions = map, foldr/foldl or filter
-- we can use length  
count :: Eq a => a -> [a] -> Int
count v xs = length(filter (\x -> (x==v)) xs)

{-
countElem :: Eq a => [a] -> [Int]
countElem xs = map (\x -> count x xs) xs

getSqTuples :: Num b => [b] -> [(b, b)]
getSqTuples xs = map (\x -> (x,x*x)) xs
-}

eliminateDuplicates :: Eq a => [a] -> [a]
eliminateDuplicates [] = [] -- base case, if the list is empty 
eliminateDuplicates [x] = [x] -- base case, if the list onlly has one element
eliminateDuplicates (x:xs)
     |x `elem` xs =  eliminateDuplicates xs
     |otherwise = x : eliminateDuplicates xs

{- (b) histogram  -}
histogram :: Eq a => [a] -> [(a, Int)]
histogram xs = eliminateDuplicates (map (\x -> (x, count x xs)) xs)
                

-- hint: skip 3 and 4 
-- 3                
{- (a) concatAll -}




{- (b) concat2Either -}               
data AnEither  = AString String | AnInt Int
                deriving (Show, Read, Eq)




-- 4      
{-  concat2Str -}               




data Op = Add | Sub | Mul | Pow
          deriving (Show, Read, Eq)

evaluate:: Op -> Int -> Int -> Int
evaluate Add x y =  x+y
evaluate Sub   x y =  x-y
evaluate Mul x y =  x*y
evaluate Pow x y = x^y

data ExprTree a = ELEAF a | ENODE Op (ExprTree a) (ExprTree a)
                  deriving (Show, Read, Eq)

-- 5 
{- evaluateTree -}
evaluateTree :: ExprTree Int -> Int
evaluateTree (ELEAF v) = v
evaluateTree (ENODE op t1 t2) =  evaluate op (evaluateTree t1) (evaluateTree t2)


-- 6
{- printInfix -}
printInFix :: Show a => ExprTree a -> String
printInFix (ELEAF v) = show v
printInFix (ENODE op t1 t2) = "(" ++ (printInFix t1) ++ " '" ++ show op ++ "' " ++(printInFix t2) ++ ")"


--7
{- createRTree -}
data ResultTree a  = RLEAF a | RNODE a (ResultTree a) (ResultTree a)
                     deriving (Show, Read, Eq)






