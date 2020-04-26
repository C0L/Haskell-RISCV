module Comp where

import Parser
import ASTtypes


-- IfExp (BinOp Eq (EvalVar "x") (EvalInt 1)) (DeclareInt "x" 2)

compMain :: Expression -> String
compMain exp = case exp of 
  (IfExp (BinOp bop b0 b1) e1)      -> case bop of 
                                          Le  -> "\tBLT\n"    -- Branch less than
                                          Lt  -> "\tBLE\n"    -- Branch less than or equal
                                          Ne  -> "\tBNE\n"    -- Branch not equal
                                          Eq  -> "\tBEQ\n"    -- Branch equal
  (DeclareInt id e0)                -> "DECLARATION"
  (BinOp bop e0 e1)                 -> (compBop bop (compMain e0) (compMain e1))


compBop :: BinaryOperator -> String -> String -> String
compBop exp b0 b1 = case exp of 
  (Eq) -> error "TODO"
