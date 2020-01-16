import Prelude hiding (head, tail, take, drop)

-- 1. head' возвращает первый элемент непустого списка
head' :: [a] -> a
head' = undefined
-- 2. (*) tail' возвращает список без первого элемента, для пустого - пустой
tail' :: [a] -> [a]
tail' = undefined
-- 3. take' возвращает первые n >= 0 элементов исходного списка
take' :: Int -> [a] -> [a]
take' = undefined
-- 4. filter' возвращает список из элементов, для которых f возвращает True
filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = undefined 

-- 5. Maybe
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
thirdElement xs = undefined

-- 6. Напишите функцию, которая считает число списков, в которых чётное число единичек.
evenNumberOfOnes :: [[Int]] -> Int
evenNumberOfOnes xs = undefined
