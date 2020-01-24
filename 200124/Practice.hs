--------------------------------------
-- 1. Определение собственных типов --
--------------------------------------

-- Определение Bool в стандартной библиотеке языка:
-- data Bool = False | True
--   ^ имя  ^ значения

-- Тип фигуры
-- data Shape a = Circle (Point a) a | Rectangle (Point a) (Point a)
--                  ^ центр     ^ радиус          ^ противоположные углы

-- Это мы научились класть в фигуры содержимое с помощью конструкторов
-- Circle :: Float -> Float -> Float -> Shape
-- Rectangle :: Float -> Float -> Float -> Float -> Shape

-- surface :: (Num a) => Shape a -> a
-- surface (Circle _ r) = 3 * r ^ 2
-- surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- Научились извлекать содержимое с помощью pattern matching

-- Упражнения:
-- * Определить тип Point для декартовых координат и переписать Circle и Rectangle с его использованием
-- data Pair a b = Pair a b
-- type Point a = Pair a a 


-- * Порефакторить surface

-------------------------------
-- 2. Параметризованные типы --
-------------------------------

-- Определение Maybe в стандартной библиотеке языка
-- data Maybe a = Nothing | Just a
--   ^ конструктор типа с одним параметром

-- Упражнения:
-- * Какой тип у 
--   - Just 5
--   - Just "Hi 5"
--   - Nothing
-- * Переписать Point как параметризованный тип

-------------------------
-- 3. Рекурсивные типы --
-------------------------

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read)  
data Tree' a = Empty | N a [Tree' a] deriving (Show, Read) 
--                                ^ выражаем тип через себя

tree :: Tree' Int
tree = N 0 [N 1 [Empty, Empty]]

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

-- обходим и модифицируем дерево
-- treeInsert :: (Ord a, Num a) => a -> b -> Tree a -> Tree a

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a  = Node a (treeInsert x left) right
    | x > a  = Node a left (treeInsert x right)

-- обходим дерево
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a  = treeElem x left
    | x > a  = treeElem x right

treeErase :: (Ord a) => a -> Tree a -> Tree a
treeErase 
 
-- Упражнения:
-- * Бесконечное дерево

-------------------------------------------------
-- 4. AST (абстрактные синтаксические деревья) --
-------------------------------------------------

data Expr = Tru | Fls | Not Expr | And Expr Expr | Or Expr Expr | If Expr Expr Expr deriving Show

ast :: Expr 
ast = If (Tru `Or` Fls) (Not Tru `And` Fls) (If Tru Tru Tru)

-- exec :: Expr -> Bool
-- exec Tru = True
-- exec Fls = False
-- exec (Not e) = not (exec e)
-- exec (l `And` r) = exec l && exec r
-- exec (l `Or` r) = exec l || exec r
-- exec (If e t f)
--     | exec e = exec t
--     | otherwise = exec f 

-- toHaskell :: Expr -> String
-- toHaskell Tru = "(True)"
-- toHaskell Fls = "(False)"
-- toHaskell (Not e) = "(not " ++ toHaskell e ++ ")"
-- toHaskell (l `And` r) = "(" ++ toHaskell l ++ " && " ++ toHaskell r ++ ")"
-- toHaskell (l `Or` r)  = "(" ++ toHaskell l ++ " || " ++ toHaskell r ++ ")"
-- toHaskell (If e t f)  = "(if " ++ toHaskell e ++ " then " ++ toHaskell t ++ " else " ++ toHaskell f ++ ")"

data Assign = Assign String Expr 
data Return = Return String

-- Псевдонимы
type Code = ([Assign], Return)
type Scope = [(String, Bool)]

(=:=) = Assign
infixr 1 =:=

-- code :: Code
-- code = (["x" =:= Tru,
--          "y" =:= Fls,
--          "z" =:= If (Not (Var "y")) (Var "x") (Fls)], 
--          Return "z")

-- execCode :: Code -> Maybe Bool
-- execCode (as, Return r) = lookup r (execAssigns as [])
--     -- изменяемые значения
--     where execAssigns :: [Assign] -> Scope -> Scope
--           execAssigns = undefined 

main :: IO ()
main = return ()
