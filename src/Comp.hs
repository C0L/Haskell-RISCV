module Comp where

import Parser
import Lexer
import ASTtypes
import Text.Printf

type Bytes = Int 
type Offset = Int
type ID = String

compMain :: Expression -> [Token] -> String
compMain exp toks = (defHeader (stackSpace toks 0)) ++ (compExp exp [])


-- NEED AN ADD SCOPE FUNCTIOION THAT CAN ALSO CALL ON LINE BREAKS
compExp :: Expression -> [(Offset, ID)] -> String
compExp exp scope = case exp of 
  (Prog e0)                         -> compExp e0 scope
  (Main e0)                         -> "main:\n" ++ prologue ++ (compExp e0 scope)
  (IfExp (BinOp bop b0 b1) e0)      -> case bop of 
                                          Le  -> "\tblt\n"    -- Branch less than
                                          Lt  -> "\tble\n"    -- Branch less than or equal
                                          Ne  -> "\tbne\n"    -- Branch not equal
                                          Eq  -> "\tbeq\n"    -- Branch equal
  (DeclareInt id e0)                -> "INTEGER DECLARED"
  (EvalInt e0)                      -> show e0
  (BinOp bop e0 e1)                 -> (compBop bop (compExp e0 scope) (compExp e1 scope))
  (RetV e0)                         -> epilogue ++ (funcRet (compExp e0 scope))


-- Save the corresponding address of the int with its name for further lookup
addSSInt :: [(Offset, ID)] -> ID -> [(Offset, ID)] 
addSSInt vars id = vars ++ [((fst (last vars)), id)]


funcRet :: String -> String
funcRet rv = printf  "\tli\ta0,%s\n\
                      \\tjr\tra\n" rv

defHeader :: Bytes -> String
defHeader stackSize =  printf  "\t.equ\tFP_OFFSET,-16\n\
                                \\t.equ\tLOCAL_VARS,-%d\n\
                                \\t.text\n\
                                \\t.align\t1\n\
                                \\t.global\t.main\n" stackSize

-- fp should be s0
-- 8 bytes for the FP byte integer, 8 per other int 
-- Add x many bytes for the local vars where 8 bytes is 1 int
-- Add 16 bytes more for the fp and the ra of the caller
-- Store the frame pointer at 8 - (16+x)
-- Store the rerturn address at 16 - (16+x)
-- Add 16 + x bytes to the stack point and make this the new frame pointer
prologue :: String  
prologue =  "\taddi\tsp,sp,LOCAL_VARS\n\
             \\taddi\tsp,sp,FP_OFFSET\n\
             \\tsw\tfp,8(sp)\n\
             \\tsw\tra,16(sp)\n\
             \\taddi\tfp,sp,LOCAL_VARS\n\
             \\taddi\tfp,sp,FP_OFFSET\n"

epilogue :: String  -- Restore registers and stack pointer
epilogue = printf  "\tlw\tfp,8(sp)\n\
                    \\tlw\tra,16(sp)\n\
                    \\taddi\tsp,sp,-LOCAL_VARS\n\
                    \\taddi\tsp,sp,-FP_OFFSET\n"


compBop :: BinaryOperator -> String -> String -> String
compBop exp b0 b1 = case exp of 
  (Eq) -> error "TODO"

stackSpace :: [Token] -> Bytes -> Bytes
stackSpace [] stackSize     = stackSize
stackSpace (x:xs) stackSize = case x of 
  INT       -> stackSpace xs (stackSize + 8) 
  otherwise -> stackSpace xs stackSize
