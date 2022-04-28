-- CptS 355 - Lab 1 (Haskell) - Spring 2022
-- Name: Lovee Baccus 11604341
-- Collaborated with: n/a 

module Lab1
     where

-- 1.insert 
insert :: (Eq t1, Num t1) => t1 -> t2 -> [t2] -> [t2]
insert 0 item iL = item : iL
insert n item [] = []
insert n item iL = (head iL) : insert (n - 1) item (tail iL)

-- 2. insertEvery
-- insertEvery :: (Eq t, Num t) => t -> a -> [a] -> [a]


insertEvery n a iL = insertEveryHelper n a iL n
     where
          insertEveryHelper 0 a [] on = [a]
          insertEveryHelper n a [] on = []
          insertEveryHelper n a (x:xs) on = x : insertEveryHelper (n - 1) a xs on

-- 3. getSales
getSales :: (Num p, Eq t) => t -> [(t,p)] -> p 
getSales x [] = 0
getSales x ((a,b):xs) 
  | x==a = b+(getSales x xs)
  | otherwise =  getSales x xs
                                                  
-- 4. sumSales
sumSales :: (Num p) => String -> String -> [(String, [(String,p)])] -> p
sumSales name day saleLog = sumSalesHelper name day saleLog 0
  where
    sumSalesHelper name day [] n = n
    sumSalesHelper name day (x:xs) n 
      | (fst x) == name = sumSalesHelper name day xs (n + getSales day (snd x)) 
      | otherwise = sumSalesHelper name day xs n