import Data.Char
import Prelude hiding (sum, concat, foldr)

-- 1) Выделение функции высшего порядка.
-- Функция sum' считает сумму чисел в списке при помощи функции sum''.
-- Функция sum'' x xs считает сумму чисел в списке xs плюс x.
-- Реализуйте функцию sum'', не используя стандартные функции высшего порядка.
--
-- >>> sum'' 10 [2, 3]
-- 5
sum' :: [Int] -> Int
sum' = sum'' 0

sum'' :: Int -> [Int] -> Int
sum'' ini xs = undefined

-- Функция concat' принимает на вход список строк и возвращает конкатенацию
-- этих строк. Она использует функцию concat'', которая дополнительно
-- принимает начальное значение, которое дописывается в конец.
-- Реализуйте функцию concat''.
--
-- >>> concat'' "c" ["a", "b"]
-- "abc"
concat' :: [String] -> String
concat' = concat'' ""

concat'' :: String -> [String] -> String
concat'' ini xs = undefined

-- Функция hash' принимает на вход строку s и считает полиномиальный
-- хэш от строки по формуле hash' s_0...s_{n - 1} =
--  s_0 + p * s_1 + ... + p^{n - 1} * s_{n - 1}, где p - константа
-- (в данном случае, 17).
-- Функция hash' использует функцию hash'', которая принимает на вход
-- начальное значение хэша и строку. Реализуйте функцию hash''.
--
-- >>> hash'' 10 "BA"
-- 4077
-- >>> (ord 'A') + (ord 'B') * p + 10 * p ^ 2
-- 4077
p :: Int
p = 17

hash' :: String -> Int
hash' = hash'' 0

hash'' :: Int -> String -> Int
hash'' ini s = undefined

-- Выделите общую логику предыдущих функций и реализуйте функцию высшего порядка foldr'.
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f ini xs = undefined

-- Реализуйте функцию map' (которая делает то же самое, что обычный map)
-- через функцию foldr'.
map' :: (a -> b) -> [a] -> [b]
map' f xs = undefined

-- 2) Maybe
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
-- образцом (pattern matching) только для Maybe (но не для списков) реализуйте:

-- Функцию thirdElementOfSecondList, которая принимает на вход список 
-- списков, и возвращает третий элемент второго списка или Nothing, если 
-- второго списка или третьего элемента в нём не существует.
--
-- >>> thirdElementOfSecondList []
-- Nothing
-- >>> thirdElementOfSecondList ["abcd"]
-- Nothing
-- >>> thirdElementOfSecondList [[], [1, 2], [3, 4]]
-- Nothing
-- >>> thirdElementOfSecondList [["a"], ["b", "c", "d"]]
-- Just "d"
thirdElementOfSecondList :: [[a]] -> Maybe a
thirdElementOfSecondList xs = undefined

-- Функцию fifthElement, которая возвращает пятый элемент списка или Nothing,
-- если пятого элемента в списке нет.
-- >>> fifthElement []
-- Nothing
-- >>> fifthElement "abcd"
-- Nothing
-- >>> fifthElement [1, 2, 3, 4, 5]
-- Just 5
fifthElement :: [a] -> Maybe a
fifthElement xs = undefined

-- Выделите общую логику в оператор -->.
(-->) :: Maybe a -> (a -> Maybe b) -> Maybe b
(-->) ma f = undefined


-- 3) Несколько упражнений
-- Реализуйте функцию nubBy', которая принимает на вход функцию для сравнения 
-- элементов на равенство и список элементов, 
-- и возвращает список из тех же элементов без повторений. Важно сохранить 
-- порядок, в котором элементы встречались впервые.
-- Запрещено использовать стандартные функции, которые решают эту задачу
--
-- >>> nubBy' (==) []
-- []
-- >>> nubBy' (==) "abaacbad"
-- "abcd"
-- nubBy' (\x y -> x + y == 10) [2, 3, 5, 7, 8, 2]
-- [2, 3, 5, 2]
nubBy' :: (a -> a -> Bool) -> [a] -> [a]
nubBy' eq xs = undefined

-- Реализуйте функцию quickSort, которая принимает на вход список, и 
-- возвращает список, в котором элементы отсортированы при помощи быстрой 
-- сортировки.
-- Рандом или быстрый partition использовать не нужно.
-- Ord a => означает, что для элементов списка можно использовать знаки 
-- сравнения (>, <, ==, etc)
--
-- >>> quickSort' []
-- []
-- >>> quickSort' [2, 3, 1, 2]
-- [1, 2, 2, 3]
-- >>> quickSort' "babca"
-- "aabbc"
quickSort' :: Ord a => [a] -> [a]
quickSort' xs = undefined

-- Найдите суммарную длину списков, в которых чётное количество элементов 
-- имеют квадрат больше 100.
--
-- >>> weird' []
-- 0
-- >>> weird' [[1, 2, 3], [4, 5], [1, 2, 11]]
-- 5
-- >>> weird' [[1, 11, 12], [9, 10, 20]]
-- 3
weird':: [[Int]] -> Int
weird' xs = undefined


-- 4) grep
-- Нужно реализовать несколько вариаций grep'а.
-- Вместо файлов на вход будет подаваться список из структур File,
-- содержащих в себе имя файла и его содержимое.
-- (Можно считать, что File -- это typedef для кортежа из двух строк).
type File = (String, String)

-- Функция grep' принимает на вход подстроку, список файлов, а также функции 
-- match, принимающую подстроку и строчку, в которой ищем, и возвращающую, 
-- есть ли совпадение, и format, принимающую на вход имя файла и список
-- подходящих для файла строк, и
-- возвращающую список отформатированных строк. Функция grep' должна вернуть
-- список
-- окончательно отформатированных строк.
grep' :: String -> [File] -> (String -> String -> Bool) -> (String -> [String]
 -> [String]) -> [String]
grep' needle files match format = undefined

-- При помощи этой функции реализуйте:
-- Вариант, когда ищется подстрока и нужно просто вернуть список подходящих 
-- строк.
--
-- grepSubstringNoFilename "b" [("a.txt", "a\nb")]
-- ["b"]
-- >>> grepSubstringNoFilename "c" [("a.txt", "a\na"), ("b.txt", "b\nbab\nc"),
-- ("c.txt", "ccccc")]
-- ["c", "ccccc"]
grepSubstringNoFilename :: String -> [File] -> [String]
grepSubstringNoFilename needle files = undefined
 
-- Вариант, когда ищется точное совпадение и нужно ко всем подходящим строкам
-- дописать имя файла через ":".
--
-- grepExactMatchWithFilename "b" [("a.txt", "a\nb")]
-- ["a.txt:b"]
-- >>> grepExactMatchWithFilename "c" [("a.txt", "a\na"), ("b.txt", "b\nbab\nc"),
-- ("c.txt", "c\nccccc")]
-- ["b.txt:c", "c.txt:c"]
grepExactMatchWithFilename :: String -> [File] -> [String]
grepExactMatchWithFilename needle files = undefined
