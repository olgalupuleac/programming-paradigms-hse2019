module Yat where  -- Вспомогательная строчка, чтобы можно было использовать функции в других файлах.
import Data.List
import Data.Bifunctor
import Debug.Trace

-- В логических операциях 0 считается ложью, всё остальное - истиной.
-- При этом все логические операции могут вернуть только 0 или 1.

-- Результат вычисления Body - это результат вычисления последнего выражения.

-- Все возможные бинарные операции: умножение, деление, взятие по модулю, вычитание, сложение, <, <=, >, >=, ==, !=, логическое &&, логическое ||
data Binop = Mul | Div | Mod | Sub | Add | Lt | Le | Gt | Ge | Eq | Ne | And | Or
-- Все возможные унарные операции: отрицание числа и логическое "не".
data Unop = Neg | Not
data Expression = Number Int  -- Возвращает число
                | Reference Name  -- Возвращает значение соответствующей переменной в текущем scope
                | Assign Name Expression  -- Изменяет значение соответствующей переменной и возвращает его
                | BinaryOperation Binop Expression Expression  -- Вычисляет сначала левый операнд, потом правый, потом возвращает результат операции
                | UnaryOperation Unop Expression  -- Вычисляет операнд, потом применяет операцию
                | FunctionCall Name [Expression]  -- Вычисляет аргументы слева направа в текущем scope, потом создаёт новый scope для дочерней функции (копию своего с добавленными параметрами), возвращает результат работы функции
                | Conditional Expression Body Body  -- Вычисляет Expression, в случае истины вычисляет первый Body, в случае лжи - второй. Возвращает значение соответствующего Body.

type Name = String
type Body = [Expression]
type FunctionDefinition = (Name, [Name], Body)  -- Имя функции, имена параметров, тело функции
type State = [(String, Int)]  -- Список пар (имя переменной, значение). Новые значения дописываются в начало, а не перезаписываются
type Program = ([FunctionDefinition], Body)  -- Все объявленные функции и основное тело программы

showBinop :: Binop -> String
showBinop Mul = "*"
showBinop Div = "/"
showBinop Mod = "%"
showBinop Sub = "-"
showBinop Add = "+"
showBinop Lt  = "<"
showBinop Le  = "<="
showBinop Gt  = ">"
showBinop Ge  = ">="
showBinop Eq  = "=="
showBinop Ne  = "/="
showBinop And = "&&"
showBinop Or  = "||"

showUnop :: Unop -> String
showUnop Neg = "-"
showUnop Not = "!"

-- Выведите на экран программу. Формат вывода: TODO
showProgram :: Program -> String
showProgram = undefined

toBool :: Int -> Bool
toBool = (/=) 0

fromBool :: Bool -> Int
fromBool False = 0
fromBool True  = 1

toBinaryFunction :: Binop -> Int -> Int -> Int
toBinaryFunction Mul = (*)
toBinaryFunction Div = div
toBinaryFunction Mod = mod
toBinaryFunction Sub = (-)
toBinaryFunction Add = (+)
toBinaryFunction Lt  = (.) fromBool . (<)
toBinaryFunction Le  = (.) fromBool . (<=)
toBinaryFunction Gt  = (.) fromBool . (>)
toBinaryFunction Ge  = (.) fromBool . (>=)
toBinaryFunction Eq  = (.) fromBool . (==)
toBinaryFunction Ne  = (.) fromBool . (/=)
toBinaryFunction And = \l r -> fromBool $ toBool l && toBool r
toBinaryFunction Or  = \l r -> fromBool $ toBool l || toBool r

toUnaryFunction :: Unop -> Int -> Int
toUnaryFunction Neg = negate
toUnaryFunction Not = fromEnum . not . toBool

-- Если хотите дополнительных баллов, реализуйте
-- вспомогательные функции ниже и реализуйте evaluate через них
-- без явной передачи состояния.

type Eval a = [FunctionDefinition] -> State -> (a, State)
evaluated :: a -> Eval a
evaluated = undefined

readState :: Eval State
readState = undefined

readDefs :: Eval [FunctionDefinition]
readDefs = undefined

andThen :: Eval a -> (a -> Eval b) -> Eval b
andThen = undefined

andEvaluated :: Eval a -> (a -> b) -> Eval b
andEvaluated = undefined

evalExpressionsL :: (a -> Int -> a) -> a -> Body -> [FunctionDefinition] -> State -> (a, State)
evalExpressionsL = undefined

-- Реализуйте eval: запускает программу и возвращает её значение.
eval :: Program -> Int
eval = undefined

(/+) = BinaryOperation Add
(/*) = BinaryOperation Mul
(/-) = BinaryOperation Sub
(|||) = BinaryOperation Or
(===) = BinaryOperation Eq
iff = Conditional
(=:=) = Assign
c = Number
r = Reference
call = FunctionCall

infixl 6 /+
infixl 6 /-
infixl 7 /*
infixr 2 |||
infix 4 ===
infixr 1 =:=

program1 = ([("fib", ["a"], [iff ((r "a" === c 0) ||| (r "a" === c 1)) [c 1] [(call "fib" [(r "a" /- c 1)]) /+ (call "fib" [(r "a" /- c 2)])]])], [call "fib" [c 25]])
program2 = ([], ["a" =:= c 10, "b" =:= c 20, r "a" /+ (r "b" /* r "a")])
program3 = (
    [
        ("f", ["param"],
            [
            "a" =:= r "a" /+ c 1,
            "param" =:= r "param" /+ c 1,
            r "a" /* c 100 /+ r "b" /* c 10 /+ r "param"
            ]
        )
    ],
    [
        "a" =:= c 2,
        "b" =:= c 7,
        "res" =:= call "f" ["a" =:= c 3],
        "b" =:= r "b" /+ c 1,
        r "res" /* c 100 /+ r "b" /* c 10 /+ r "a"
    ]
 )

main = putStrLn $ showProgram program1
