--import Prelude hiding (tail, take, drop)

-- 1. head' возвращает первый элемент непустого списка
head' :: [a] -> a
head' (x:_) = x
-- 2. tail' возвращает список без первого элемента, для пустого - пустой
tail' :: [a] -> [a]
tail' = undefined
-- 3. take' возвращает первые n >= 0 элементов исходного списка

take' :: Int -> [a] -> [a]
take' 0 xs = []
take' n (x:xs) = x : take' (n - 1) xs

drop' :: Int -> [a] -> [a]
drop' 0 xs = xs
drop' n (_:xs) = drop' (n - 1) xs

-- 4. filter' возвращает список из элементов, для которых f возвращает True
filter' :: (a -> Bool) -> [a] -> [a]
filter' f (x:xs) 
   | match       = x : filter' f xs
   | otherwise = filter' f xs
   where match = f x
{-
filter' f (x:xs) 
   | f x       = x : filter' f xs
   | otherwise = filter' f xs
-}

filter' _ _ = []

-- 5. concat' принимает список списков и возвращает один список из тех же элементов
concat' :: [[a]] -> [a]
concat' xs = [y | x <- xs, y <- x]

--concat' ((y:ys) : xs) = y : concat' ys : xs

-- 6. Maybe
-- Maybe a - это специальный тип данных, который может принимать либо
-- значение Nothing, либо значение Just x, где x --- значение типа a.
-- Его удобно использовать для сообщения об ошибке.

-- Даны функции tryHead и tryTail, реализованные следующим образом
-- >>> tryHead []
-- Nothing
-- >>> tryHead ["hello"]
-- Just "hello"
-- >>> tryHead [1, 2, 3]
-- Just 1
tryHead :: [a] -> Maybe a
tryHead (x:_) = Just x
tryHead _     = Nothing

--
-- >>> tryTail []
-- Nothing
-- >>> tryTail ["hello"]
-- Just []
-- >>> :t tryTail ["hello"]
-- tryTail ["hello"] :: [[Char]]
-- >>> tryTail [1, 2, 3]
-- Just 1
tryTail :: [a] -> Maybe [a]
tryTail (_:xs) = Just xs
tryTail _      = Nothing

-- Также предоставлен пример функции, которая возвращает второй элемент
-- списка или Nothing, если второго элемента в списке нет.
--
-- >>> secondElement []
-- Nothing
-- >>> secondElement "a"
-- Nothing
-- >>> secondElement "ab"
-- Just 'b'
secondElement :: [a] -> Maybe a
secondElement xs = case tryTail xs of
                     Just a  -> tryHead a
                     _       -> Nothing

-- Используя функции tryHead и tryTail, а также сопоставление с
-- образцом (pattern matching) только для Maybe (но не для списков) реализуйте функцию thirdElement, возвращающую Maybe третий элемент списка.
thirdElement :: [a] -> Maybe a
-- Так не надо, лучше придумать что-то поизящнее
thirdElement xs = case tryTail xs of
                     Just a -> case tryTail a of
                                   Just b  -> tryHead b
                                   Nothing -> Nothing
                     Nothing -> Nothing 

-- 7. Напишите функцию, которая считает число списков, в которых чётное число единичек.
evenNumberOfOnes :: [[Int]] -> Int
--evenNumberOfOnes xs = length [1 | l <- xs, even $ length $ filter (==1) l]
--evenNumberOfOnes = length . filter (even . length . filter (==1))
--evenNumberOfOnes xs = length $ filter (even . length . filter (==1)) xs
-- Если совсем "тупо", то так
evenNumberOfOnes xs = length (filter (\x -> even (length (filter (==1) x))) xs)
-- \x -> ... -- это синтаксис лямбд, то есть анонимных функций
-- Например, \x -> x + 10
