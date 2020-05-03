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
  | Gt
  | Ge
  | And
  | Or
  deriving (Eq, Ord, Show)


data Expression
  = BinOp BinaryOperator Expression Expression
  | Asgn String Expression
  | IfExp Expression Expression 
  | EvalVar String
  | IntLiteral Int
  | DeclareInt String Int 
  | Main Expression 
  | LnBrk Expression Expression 
  | RetV Expression
  | Prog Expression
  deriving (Eq, Ord, Show)


