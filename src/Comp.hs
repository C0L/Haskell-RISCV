module Comp where

import Parser
import ASTtypes
import Text.Printf

-- scope list 
--Right (Main (RetV (EvalInt 1)))

compMain :: Expression -> String
compMain exp = case exp of 
  (Prog exp)                        -> defHeader ++ (compMain exp)
  (Main exp)                        -> "main:\n" ++ (compMain exp)
  (IfExp (BinOp bop b0 b1) e1)      -> case bop of 
                                          Le  -> "\tblt\n"    -- Branch less than
                                          Lt  -> "\tble\n"    -- Branch less than or equal
                                          Ne  -> "\tbne\n"    -- Branch not equal
                                          Eq  -> "\tbeq\n"    -- Branch equal
  (DeclareInt id e0)                -> "DECLARATION"
  (EvalInt exp)                     -> show exp
  (BinOp bop e0 e1)                 -> (compBop bop (compMain e0) (compMain e1))
  (RetV exp)                        -> printf "\tli\ta0,%s\n\tret\n" (compMain exp)                -- Return


defHeader :: String
defHeader = "\t.text\n\t.align\t1\n\t.global\t.main\n"


compBop :: BinaryOperator -> String -> String -> String
compBop exp b0 b1 = case exp of 
  (Eq) -> error "TODO"
