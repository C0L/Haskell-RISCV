module Comp where

import Parser
import ASTtypes
import Text.Printf

type Bytes = Int 

-- scope list 

compMain :: Expression -> Bytes -> String
compMain exp sp = case exp of 
  (Prog exp)                        -> defHeader ++ (compMain sp exp)
  (Main exp)                        -> "main:\n" ++ prologue ++ (compMain (sp + 16) exp)
  (IfExp (BinOp bop b0 b1) e1)      -> case bop of 
                                          Le  -> "\tblt\n"    -- Branch less than
                                          Lt  -> "\tble\n"    -- Branch less than or equal
                                          Ne  -> "\tbne\n"    -- Branch not equal
                                          Eq  -> "\tbeq\n"    -- Branch equal
  (DeclareInt id e0)                -> 
  (EvalInt exp)                     -> show exp
  (BinOp bop e0 e1)                 -> (compBop bop (compMain e0 sp) (compMain e1 sp))
  (RetV exp)                        -> epilogue ++ (return (compMain exp sp) sp)



allocInt :: String -> Int -> String
allocInt id val = "\tli\ta0,%s\n"

--dellocInt :: String 

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
