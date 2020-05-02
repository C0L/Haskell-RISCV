module Comp where

import Parser
import Lexer
import ASTtypes
import Text.Printf
import Text.Read

type Bytes = Int 
type Offset = Int
type ID = String
type Reg = String
type ASM = String
type Scope = [(Offset,ID)]
type ProgData = (Scope, ASM)


--Check if correct stack space value is found
compMain :: Expression -> [Token] -> ASM
compMain exp toks = (defHeader sSpace) ++ res
  where 
    sSpace       = stackSpace toks 0
    (scope, res) = (compExp exp "x5" [])

-- Store associated register in the scope var??
-- Reset these values after a if or func
-- Unsafe IO to generate random string???
-- NEED AN ADD SCOPE FUNCTIOION THAT CAN ALSO CALL ON LINE BREAKS
compExp :: Expression -> Reg -> Scope -> ProgData
compExp exp reg scope = case exp of 
  (Prog e0)                         -> compExp e0 reg scope 

  (Main e0)                         -> let (nScope, asm) = (compExp e0 reg scope) 
                                       in (scope, "main:\n" ++ prologue ++ asm)

  (IfExp (BinOp bop b0 b1) e0)      -> case bop of 
                                          Le  -> (scope, "\tblt\n")    -- Branch less than FILLER
                                          --Lt  -> "\tble\n"    -- Branch less than or equal
                                          --Ne  -> "\tbne\n"    -- Branch not equal
                                          --Eq  -> "\tbeq\n"    -- Branch equal

  (DeclareInt id e0)                -> addInteger scope id e0

  (IntLiteral e0)                   -> (scope, loadLiteral reg e0)

  (EvalVar e0)                      -> (scope, retrieveStack reg e0 scope) -- Load var into general purpose reg

  (BinOp bop e0 e1)                 -> (scope, "PLACEHOLDER") --(compBop bop (compExp e0 scope rs) (compExp e1 scope rs))

  (LnBrk e0 e1)                     -> let (s0, asm0) = (compExp e0 reg scope) 
                                           (s1, asm1) = (compExp e1 reg s0)      -- Eval next line with new scope
                                       in  (s1, asm0 ++ asm1)


  (RetV e0)                         -> let (nScope, asm) = (compExp e0 "a0" scope)
                                       in (scope, asm ++ epilogue ++ funcRet)



-- Start the first value above the fp and ra, all later storage locations are based off this
addInteger :: Scope -> ID -> Int -> ProgData
addInteger [] id val = ([(16, id)], (storeStack val 16))
addInteger sc id val = ([(nAddress, id)] ++ sc, storeStack val nAddress)
  where 
    nAddress = (fst (head sc)) + 8


-- Potentially add tyoes and pass that in here
storeStack :: Int -> Bytes -> ASM
storeStack val add = printf "\tli\tx5,0x%x\n\
                            \\tsw\tx5,%d(sp)\n" val add


retrieveStack :: Reg -> ID -> Scope -> ASM
retrieveStack reg id []     = error "Major issue, var not in scope" 
retrieveStack reg id (x:xs) = if id == (snd x) 
                              then printf "\tlw\t%s,%d(sp)\n" reg (fst x) 
                              else retrieveStack reg id xs


loadLiteral :: Reg -> Int -> ASM
loadLiteral reg val = printf "\tli\t%s,%d\n" reg val


funcRet :: ASM
funcRet = "\tjr\tra\n" 


defHeader :: Bytes -> ASM
defHeader stackSize =  printf  "\t.equ\tFP_OFFSET,-16\n\
                                \\t.equ\tLOCAL_VARS,-%d\n\
                                \\t.text\n\
                                \\t.align\t1\n\
                                \\t.globl\tmain\n" stackSize

-- fp should be s0
-- 8 bytes for the FP byte integer, 8 per other int 
-- Add x many bytes for the local vars where 8 bytes is 1 int
-- Add 16 bytes more for the fp and the ra of the caller
-- Store the frame pointer at 0 - (16+x)
-- Store the rerturn address at 8 - (16+x)
-- I beleive this is where the var storage starts
-- Add 16 + x bytes to the stack point and make this the new frame pointer
prologue :: ASM
prologue =  "\taddi\tsp,sp,LOCAL_VARS\n\
             \\taddi\tsp,sp,FP_OFFSET\n\
             \\tsw\tfp,0(sp)\n\
             \\tsw\tra,8(sp)\n"

epilogue :: ASM    -- Restore registers and stack pointer
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
