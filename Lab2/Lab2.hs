-- CptS 355 - Lab 2 (Haskell) - Spring 2022
-- Name: Lovee Baccus
-- Collaborated with: 
-- TO DO: # 3, 4, 7 (as test prep not for credit)

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
-- tail recusrion is when there is nothing being done before or after the recursive call, the recursion does ALL the work
-- because we can't use cons like we did in the previous, we have to add a parameter to cons to 
merge2Tail :: [a] -> [a] -> [a]
-- merge2Tail [][] = [] -- base case -- we don't need this one because the helper function will take care of it
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
-- foldl will return the list using the combining function, and the input 
-- because we use merge2 it will merge the lists
mergeN :: [[a]] -> [a]
mergeN [] = [] -- base case, return empty 
mergeN (x:xs) = foldl merge2 x xs -- I think merge2 x is the op function, and then becuase of currying xs is applies to both merge and the fold part kind of??


-- 2
{- (a) count -}
-- accepts a list and a target value, counts how many times the target occurs in the list
-- should not be recursive, but uses a higher order function
-- higher order functions = map, foldr/foldl or filter
-- filter will return a list of all the elements that meet the condition statement, which is why we can do length of that call
-- we can use length  
count :: Eq a => a -> [a] -> Int
count v xs = length(filter (\x -> (x==v)) xs)

{-
-- map will return a list of the output of the operation function
-- because we are using each element of the input list as the target for Count, this is basically doing the histogram part
-- I'm not actually using this function, I just had it here for reference because I use the same logic in the histogram function
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
     |otherwise = x : eliminateDuplicates xs -- if its unique then we add it to the list so it will take the last occurance of the duplicate 

{- (b) histogram  -}
histogram :: Eq a => [a] -> [(a, Int)]
histogram xs = eliminateDuplicates (map (\x -> (x, count x xs)) xs)   -- the part without eliminateDuplicates is counting how many occurances of each element
                                                                      -- once we have the count of everything, we don't want it to in the histogram multiple times
                                                                      -- the list that is resulting would be like the y axis of a histogram, so it wouldn't be super helpful without the original list too

                

-- hint: skip 3 and 4 
-- 3                
{- (a) concatAll -}
-- use map and fold, but no recursion
-- i think it would be similar to merdeN, but we would use map with a copy function i think?




{- (b) concat2Either -}               
data AnEither  = AString String | AnInt Int
                deriving (Show, Read, Eq)




-- 4      
{-  concat2Str -}               




data Op = Add | Sub | Mul | Pow
          deriving (Show, Read, Eq)

-- this is just defining our normal stuff with the ExprTree syntax because we want to be able to use the data type easily
evaluate:: Op -> Int -> Int -> Int
evaluate Add x y =  x+y
evaluate Sub x y =  x-y
evaluate Mul x y =  x*y
evaluate Pow x y = x^y

data ExprTree a = ELEAF a | ENODE Op (ExprTree a) (ExprTree a)
                  deriving (Show, Read, Eq)

-- 5 
-- it will process the whole tree from bottom up, so its like read in order for a binary tree where the roots are the op
{- evaluateTree -}
evaluateTree :: ExprTree Int -> Int
evaluateTree (ELEAF v) = v
evaluateTree (ENODE op t1 t2) =  evaluate op (evaluateTree t1) (evaluateTree t2)


-- 6
{- printInfix -}
-- basically print in order, but it 'shows' the op word for readability
printInFix :: Show a => ExprTree a -> String
printInFix (ELEAF v) = show v
printInFix (ENODE op t1 t2) = "(" ++ (printInFix t1) ++ " '" ++ show op ++ "' " ++(printInFix t2) ++ ")"


--7
{- createRTree -}
data ResultTree a  = RLEAF a | RNODE a (ResultTree a) (ResultTree a)
                     deriving (Show, Read, Eq)

-- takes a tree that has the ops in the roots, and replaces the op with the solution of that operation
-- in order traversal but then replacing the subroot

