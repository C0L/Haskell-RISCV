module ASTtypes where

data BinaryOperator
  = Plus
  | Minus
  | Mul
  | Div
  | Eq
  | Ne
  | Lt
  | Le
  | And
  | Or
  deriving (Eq, Ord, Show)


data Expression
  = BinOp BinaryOperator Expression Expression
  | IfExp Expression Expression 
  | EvalVar String
  | EvalInt Int
  | DeclareInt String Int 
  deriving (Eq, Ord, Show)


