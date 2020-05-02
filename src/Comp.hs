module Comp where

import Parser
import Lexer
import ASTtypes
import Text.Printf

type RegUse = Bool
type Bytes = Int 
type Offset = Int
type ID = String
type ASM = String
type Scope = [(Offset,ID)]
type RegSpace = [(String, RegUse)]
type ProgData = (Scope, RegSpace, ASM)

--Check if correct stack space value is found
compMain :: Expression -> [Token] -> ASM
compMain exp toks = (defHeader sSpace) ++ res
  where 
    sSpace           = stackSpace toks 0
    (scope, rs, res) = (compExp exp [] [])

-- Store associated register in the scope var??
-- Reset these values after a if or func
-- Unsafe IO to generate random string???
-- NEED AN ADD SCOPE FUNCTIOION THAT CAN ALSO CALL ON LINE BREAKS
compExp :: Expression -> Scope -> RegSpace -> ProgData
compExp exp scope rs = case exp of 
  (Prog e0)                         -> compExp e0 scope rs

  (Main e0)                         -> let (nScope, nRs, asm) = (compExp e0 scope rs) 
                                       in (scope, rs, "main:\n" ++ prologue ++ asm)

  (IfExp (BinOp bop b0 b1) e0)      -> case bop of 
                                          Le  -> (scope, rs, "\tblt\n")    -- Branch less than FILLER
                                          --Lt  -> "\tble\n"    -- Branch less than or equal
                                          --Ne  -> "\tbne\n"    -- Branch not equal
                                          --Eq  -> "\tbeq\n"    -- Branch equal

  (DeclareInt id e0)                -> addInteger (scope, rs) id e0

  (IntLiteral e0)                   -> (scope, rs, show e0)

  (EvalVar e0)                      -> (scope, rs, "PLACEHOLDER") --retStack e0 scope load value from stack into a reg

  (BinOp bop e0 e1)                 -> (scope, rs, "PLACEHOLDER") --(compBop bop (compExp e0 scope rs) (compExp e1 scope rs))

  (RetV e0)                         -> let (nScope, nRs, asm) = (compExp e0 scope rs)
                                       in (scope, rs, (funcRet asm epilogue))

  (LnBrk e0 e1)                     -> let (s0, r0, asm0) = (compExp e0 scope rs) 
                                           (s1, r1, asm1) = (compExp e1 s0 r0)      -- Eval next line with new scope
                                       in (s1, r1, asm0 ++ asm1)

  -- Add line breakages here for more sophisticated scope usage



-- Start the first value above the fp and ra, all later storage locations are based off this
addInteger :: (Scope, RegSpace) -> ID -> Int -> ProgData
addInteger ([],rs) id val = ([(16, id)], rs, (storeStack val 16))
addInteger (sc,rs) id val = ([(nAddress, id)] ++ sc, rs, storeStack val nAddress)
  where 
    nAddress = (fst (head sc)) + 8



-- Potentially add tyoes and pass that in here
storeStack :: Int -> Bytes -> ASM
storeStack val add = printf "\tli\tx5,0x%x\n\
                            \\tsw\tx5,%d(sp)\n" val add

retStack :: ID -> Scope -> ASM
retStack id []     = error "Major issue, var not in scope" 
retStack id (x:xs) = if id == (snd x) 
                     then printf "\t" -- NEED TO ADD ASSEMBLY TO PUT VALUE IN RIGHT VARIABLE
                     else retStack id xs


funcRet :: String -> ASM -> ASM
funcRet rv epi = printf  "\tli\ta0,%s\n\
                          \%s\
                          \\tjr\tra\n" rv epi

defHeader :: Bytes -> ASM
defHeader stackSize =  printf  "\t.equ\tFP_OFFSET,-16\n\
                                \\t.equ\tLOCAL_VARS,-%d\n\
                                \\t.text\n\
                                \\t.align\t1\n\
                                \\t.global\t.main\n" stackSize
-- Get the next open register
--freeRegister :: RegSpace -> String -> RegSpace
--freeRegister  


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
             
             -- addi\tfp,sp,LOCAL_VARS\n\
             -- addi\tfp,sp,FP_OFFSET\n

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
