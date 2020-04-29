module Comp where

import Parser
import ASTtypes
import Text.Printf

type Bytes = Int 
type String = ID

compMain :: Expression -> [(Bytes, ID)] -> String
compMain exp vars = case exp of 
  (Prog e0)                         -> defHeader ++ (compMain e0 vars)
  (Main e0)                         -> "main:\n" ++ prologue ++ (compMain exp vars)
  (IfExp (BinOp bop b0 b1) e0)      -> case bop of 
                                          Le  -> "\tblt\n"    -- Branch less than
                                          Lt  -> "\tble\n"    -- Branch less than or equal
                                          Ne  -> "\tbne\n"    -- Branch not equal
                                          Eq  -> "\tbeq\n"    -- Branch equal
  (DeclareInt id e0)                -> (allocInt e0) ++ (compMain e0 (addSSInt vars id))
  (EvalInt e0)                      -> show exp
  (BinOp bop e0 e1)                 -> (compBop bop (compMain e0 vars) (compMain e1 vars))
  (RetV e0)                         -> epilogue ++ (return (compMain exp vars))


-- Save the corresponding address of the int with its name for further lookup
addSSInt :: [(Bytes, ID)] -> ID -> [(Bytes, ID)] 
addSSInt vars id = vars:((fst (last vars)), id)

-- Make space on the stack for the new integer
allocInt :: Int -> String
allocInt val = "\taddi\tsp,sp,-4\n \
                \ "



dellocInt :: [(Bytes, ID)] -> String

return :: Int -> String
return rv = printf "\tli\ta0,%s\n \
                   \ \tret\n" rv

defHeader :: String
defHeader = "\t.text\n \
            \ \t.align\t1\n \
            \ \t.global\t.main\n"


prologue :: String  -- Make space on stack and save reg state
prologue = "\taddi\tsp,sp,16\n \
           \ \tad\tra, 0(sp)\n"


epilogue :: String  -- Restore registers and stack pointer
epilogue sp = printf "\tld\tra,0(sp)\n \     
                     \ \taddi\tsp,sp,-16\n"


compBop :: BinaryOperator -> String -> String -> String
compBop exp b0 b1 = case exp of 
  (Eq) -> error "TODO"
