{-# OPTIONS_GHC -w #-}
module Parser (parseExpr, parseTokens) where

import Lexer
import ASTtypes
import Control.Monad.Except
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.11

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,260) ([10240,16390,1,0,1,0,8,31744,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,1576,320,0,0,0,0,0,8193,10240,16390,1,63424,0,0,0,32768,0,32,0,49408,247,25216,5120,35328,20481,10240,16390,40961,24,32773,98,20,394,80,1576,320,6304,1280,25216,5120,35328,20481,10240,16390,1,1984,0,7936,0,31744,0,61440,1,0,1,0,4,0,0,0,448,0,1792,0,0,0,31760,15,0,0,256,0,8192,0,0,0,0,0,0,2,0,8,0,394,80,1576,320,1024,0,4096,991,35328,20481,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Func","Div","Typs","Vals","Cond","BinOps","Paren","Ret","if","else","'('","')'","'{'","'}'","NUM","VAR","';'","'&&'","'||'","'*'","'-'","'+'","'='","'<='","'<'","'!='","'=='","'int'","'main'","'return'","%eof"]
        bit_start = st * 34
        bit_end = (st + 1) * 34
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..33]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (12) = happyShift action_11
action_0 (14) = happyShift action_12
action_0 (18) = happyShift action_13
action_0 (19) = happyShift action_14
action_0 (31) = happyShift action_15
action_0 (33) = happyShift action_16
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (6) = happyGoto action_5
action_0 (7) = happyGoto action_6
action_0 (8) = happyGoto action_7
action_0 (9) = happyGoto action_8
action_0 (10) = happyGoto action_9
action_0 (11) = happyGoto action_10
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (31) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (32) = happyShift action_20
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (21) = happyShift action_24
action_3 (22) = happyShift action_25
action_3 (23) = happyShift action_26
action_3 (24) = happyShift action_27
action_3 (25) = happyShift action_28
action_3 (27) = happyShift action_29
action_3 (28) = happyShift action_30
action_3 (29) = happyShift action_31
action_3 (30) = happyShift action_32
action_3 (34) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (20) = happyShift action_23
action_5 _ = happyReduce_5

action_6 _ = happyReduce_7

action_7 _ = happyReduce_10

action_8 _ = happyReduce_13

action_9 _ = happyReduce_23

action_10 _ = happyReduce_25

action_11 (14) = happyShift action_22
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (12) = happyShift action_11
action_12 (14) = happyShift action_12
action_12 (18) = happyShift action_13
action_12 (19) = happyShift action_14
action_12 (31) = happyShift action_15
action_12 (33) = happyShift action_16
action_12 (4) = happyGoto action_21
action_12 (5) = happyGoto action_4
action_12 (6) = happyGoto action_5
action_12 (7) = happyGoto action_6
action_12 (8) = happyGoto action_7
action_12 (9) = happyGoto action_8
action_12 (10) = happyGoto action_9
action_12 (11) = happyGoto action_10
action_12 _ = happyFail (happyExpListPerState 12)

action_13 _ = happyReduce_8

action_14 _ = happyReduce_9

action_15 (19) = happyShift action_19
action_15 (32) = happyShift action_20
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (12) = happyShift action_11
action_16 (14) = happyShift action_12
action_16 (18) = happyShift action_13
action_16 (19) = happyShift action_14
action_16 (31) = happyShift action_15
action_16 (33) = happyShift action_16
action_16 (4) = happyGoto action_17
action_16 (5) = happyGoto action_4
action_16 (6) = happyGoto action_5
action_16 (7) = happyGoto action_18
action_16 (8) = happyGoto action_7
action_16 (9) = happyGoto action_8
action_16 (10) = happyGoto action_9
action_16 (11) = happyGoto action_10
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (21) = happyShift action_24
action_17 (22) = happyShift action_25
action_17 (23) = happyShift action_26
action_17 (24) = happyShift action_27
action_17 (25) = happyShift action_28
action_17 (27) = happyShift action_29
action_17 (28) = happyShift action_30
action_17 (29) = happyShift action_31
action_17 (30) = happyShift action_32
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (20) = happyShift action_47
action_18 _ = happyReduce_7

action_19 (26) = happyShift action_46
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (14) = happyShift action_45
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (15) = happyShift action_44
action_21 (21) = happyShift action_24
action_21 (22) = happyShift action_25
action_21 (23) = happyShift action_26
action_21 (24) = happyShift action_27
action_21 (25) = happyShift action_28
action_21 (27) = happyShift action_29
action_21 (28) = happyShift action_30
action_21 (29) = happyShift action_31
action_21 (30) = happyShift action_32
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (12) = happyShift action_11
action_22 (14) = happyShift action_12
action_22 (18) = happyShift action_13
action_22 (19) = happyShift action_14
action_22 (31) = happyShift action_15
action_22 (33) = happyShift action_16
action_22 (4) = happyGoto action_43
action_22 (5) = happyGoto action_4
action_22 (6) = happyGoto action_5
action_22 (7) = happyGoto action_6
action_22 (8) = happyGoto action_7
action_22 (9) = happyGoto action_8
action_22 (10) = happyGoto action_9
action_22 (11) = happyGoto action_10
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (12) = happyShift action_11
action_23 (14) = happyShift action_12
action_23 (18) = happyShift action_13
action_23 (19) = happyShift action_14
action_23 (31) = happyShift action_15
action_23 (33) = happyShift action_16
action_23 (4) = happyGoto action_17
action_23 (5) = happyGoto action_42
action_23 (6) = happyGoto action_5
action_23 (7) = happyGoto action_6
action_23 (8) = happyGoto action_7
action_23 (9) = happyGoto action_8
action_23 (10) = happyGoto action_9
action_23 (11) = happyGoto action_10
action_23 _ = happyReduce_4

action_24 (12) = happyShift action_11
action_24 (14) = happyShift action_12
action_24 (18) = happyShift action_13
action_24 (19) = happyShift action_14
action_24 (31) = happyShift action_15
action_24 (33) = happyShift action_16
action_24 (4) = happyGoto action_41
action_24 (5) = happyGoto action_4
action_24 (6) = happyGoto action_5
action_24 (7) = happyGoto action_6
action_24 (8) = happyGoto action_7
action_24 (9) = happyGoto action_8
action_24 (10) = happyGoto action_9
action_24 (11) = happyGoto action_10
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (12) = happyShift action_11
action_25 (14) = happyShift action_12
action_25 (18) = happyShift action_13
action_25 (19) = happyShift action_14
action_25 (31) = happyShift action_15
action_25 (33) = happyShift action_16
action_25 (4) = happyGoto action_40
action_25 (5) = happyGoto action_4
action_25 (6) = happyGoto action_5
action_25 (7) = happyGoto action_6
action_25 (8) = happyGoto action_7
action_25 (9) = happyGoto action_8
action_25 (10) = happyGoto action_9
action_25 (11) = happyGoto action_10
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (12) = happyShift action_11
action_26 (14) = happyShift action_12
action_26 (18) = happyShift action_13
action_26 (19) = happyShift action_14
action_26 (31) = happyShift action_15
action_26 (33) = happyShift action_16
action_26 (4) = happyGoto action_39
action_26 (5) = happyGoto action_4
action_26 (6) = happyGoto action_5
action_26 (7) = happyGoto action_6
action_26 (8) = happyGoto action_7
action_26 (9) = happyGoto action_8
action_26 (10) = happyGoto action_9
action_26 (11) = happyGoto action_10
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (12) = happyShift action_11
action_27 (14) = happyShift action_12
action_27 (18) = happyShift action_13
action_27 (19) = happyShift action_14
action_27 (31) = happyShift action_15
action_27 (33) = happyShift action_16
action_27 (4) = happyGoto action_38
action_27 (5) = happyGoto action_4
action_27 (6) = happyGoto action_5
action_27 (7) = happyGoto action_6
action_27 (8) = happyGoto action_7
action_27 (9) = happyGoto action_8
action_27 (10) = happyGoto action_9
action_27 (11) = happyGoto action_10
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (12) = happyShift action_11
action_28 (14) = happyShift action_12
action_28 (18) = happyShift action_13
action_28 (19) = happyShift action_14
action_28 (31) = happyShift action_15
action_28 (33) = happyShift action_16
action_28 (4) = happyGoto action_37
action_28 (5) = happyGoto action_4
action_28 (6) = happyGoto action_5
action_28 (7) = happyGoto action_6
action_28 (8) = happyGoto action_7
action_28 (9) = happyGoto action_8
action_28 (10) = happyGoto action_9
action_28 (11) = happyGoto action_10
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (12) = happyShift action_11
action_29 (14) = happyShift action_12
action_29 (18) = happyShift action_13
action_29 (19) = happyShift action_14
action_29 (31) = happyShift action_15
action_29 (33) = happyShift action_16
action_29 (4) = happyGoto action_36
action_29 (5) = happyGoto action_4
action_29 (6) = happyGoto action_5
action_29 (7) = happyGoto action_6
action_29 (8) = happyGoto action_7
action_29 (9) = happyGoto action_8
action_29 (10) = happyGoto action_9
action_29 (11) = happyGoto action_10
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (12) = happyShift action_11
action_30 (14) = happyShift action_12
action_30 (18) = happyShift action_13
action_30 (19) = happyShift action_14
action_30 (31) = happyShift action_15
action_30 (33) = happyShift action_16
action_30 (4) = happyGoto action_35
action_30 (5) = happyGoto action_4
action_30 (6) = happyGoto action_5
action_30 (7) = happyGoto action_6
action_30 (8) = happyGoto action_7
action_30 (9) = happyGoto action_8
action_30 (10) = happyGoto action_9
action_30 (11) = happyGoto action_10
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (12) = happyShift action_11
action_31 (14) = happyShift action_12
action_31 (18) = happyShift action_13
action_31 (19) = happyShift action_14
action_31 (31) = happyShift action_15
action_31 (33) = happyShift action_16
action_31 (4) = happyGoto action_34
action_31 (5) = happyGoto action_4
action_31 (6) = happyGoto action_5
action_31 (7) = happyGoto action_6
action_31 (8) = happyGoto action_7
action_31 (9) = happyGoto action_8
action_31 (10) = happyGoto action_9
action_31 (11) = happyGoto action_10
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (12) = happyShift action_11
action_32 (14) = happyShift action_12
action_32 (18) = happyShift action_13
action_32 (19) = happyShift action_14
action_32 (31) = happyShift action_15
action_32 (33) = happyShift action_16
action_32 (4) = happyGoto action_33
action_32 (5) = happyGoto action_4
action_32 (6) = happyGoto action_5
action_32 (7) = happyGoto action_6
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_10
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (21) = happyShift action_24
action_33 (22) = happyShift action_25
action_33 (23) = happyShift action_26
action_33 (24) = happyShift action_27
action_33 (25) = happyShift action_28
action_33 (27) = happyFail []
action_33 (28) = happyFail []
action_33 (29) = happyFail []
action_33 (30) = happyFail []
action_33 _ = happyReduce_19

action_34 (21) = happyShift action_24
action_34 (22) = happyShift action_25
action_34 (23) = happyShift action_26
action_34 (24) = happyShift action_27
action_34 (25) = happyShift action_28
action_34 (27) = happyFail []
action_34 (28) = happyFail []
action_34 (29) = happyFail []
action_34 (30) = happyFail []
action_34 _ = happyReduce_20

action_35 (21) = happyShift action_24
action_35 (22) = happyShift action_25
action_35 (23) = happyShift action_26
action_35 (24) = happyShift action_27
action_35 (25) = happyShift action_28
action_35 (27) = happyFail []
action_35 (28) = happyFail []
action_35 (29) = happyFail []
action_35 (30) = happyFail []
action_35 _ = happyReduce_17

action_36 (21) = happyShift action_24
action_36 (22) = happyShift action_25
action_36 (23) = happyShift action_26
action_36 (24) = happyShift action_27
action_36 (25) = happyShift action_28
action_36 (27) = happyFail []
action_36 (28) = happyFail []
action_36 (29) = happyFail []
action_36 (30) = happyFail []
action_36 _ = happyReduce_18

action_37 (23) = happyShift action_26
action_37 _ = happyReduce_15

action_38 (23) = happyShift action_26
action_38 _ = happyReduce_16

action_39 _ = happyReduce_14

action_40 (23) = happyShift action_26
action_40 (24) = happyShift action_27
action_40 (25) = happyShift action_28
action_40 _ = happyReduce_22

action_41 (23) = happyShift action_26
action_41 (24) = happyShift action_27
action_41 (25) = happyShift action_28
action_41 _ = happyReduce_21

action_42 (21) = happyReduce_3
action_42 (22) = happyReduce_3
action_42 (23) = happyReduce_3
action_42 (24) = happyReduce_3
action_42 (25) = happyReduce_3
action_42 (27) = happyReduce_3
action_42 (28) = happyReduce_3
action_42 (29) = happyReduce_3
action_42 (30) = happyReduce_3
action_42 _ = happyReduce_3

action_43 (15) = happyShift action_50
action_43 (21) = happyShift action_24
action_43 (22) = happyShift action_25
action_43 (23) = happyShift action_26
action_43 (24) = happyShift action_27
action_43 (25) = happyShift action_28
action_43 (27) = happyShift action_29
action_43 (28) = happyShift action_30
action_43 (29) = happyShift action_31
action_43 (30) = happyShift action_32
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_24

action_45 (15) = happyShift action_49
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (18) = happyShift action_48
action_46 _ = happyFail (happyExpListPerState 46)

action_47 _ = happyReduce_26

action_48 _ = happyReduce_6

action_49 (16) = happyShift action_52
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (16) = happyShift action_51
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (12) = happyShift action_11
action_51 (14) = happyShift action_12
action_51 (18) = happyShift action_13
action_51 (19) = happyShift action_14
action_51 (31) = happyShift action_15
action_51 (33) = happyShift action_16
action_51 (4) = happyGoto action_54
action_51 (5) = happyGoto action_4
action_51 (6) = happyGoto action_5
action_51 (7) = happyGoto action_6
action_51 (8) = happyGoto action_7
action_51 (9) = happyGoto action_8
action_51 (10) = happyGoto action_9
action_51 (11) = happyGoto action_10
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (12) = happyShift action_11
action_52 (14) = happyShift action_12
action_52 (18) = happyShift action_13
action_52 (19) = happyShift action_14
action_52 (31) = happyShift action_15
action_52 (33) = happyShift action_16
action_52 (4) = happyGoto action_17
action_52 (5) = happyGoto action_53
action_52 (6) = happyGoto action_5
action_52 (7) = happyGoto action_6
action_52 (8) = happyGoto action_7
action_52 (9) = happyGoto action_8
action_52 (10) = happyGoto action_9
action_52 (11) = happyGoto action_10
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (17) = happyShift action_56
action_53 _ = happyReduce_2

action_54 (17) = happyShift action_55
action_54 (21) = happyShift action_24
action_54 (22) = happyShift action_25
action_54 (23) = happyShift action_26
action_54 (24) = happyShift action_27
action_54 (25) = happyShift action_28
action_54 (27) = happyShift action_29
action_54 (28) = happyShift action_30
action_54 (29) = happyShift action_31
action_54 (30) = happyShift action_32
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (12) = happyShift action_11
action_55 (14) = happyShift action_12
action_55 (18) = happyShift action_13
action_55 (19) = happyShift action_14
action_55 (31) = happyShift action_15
action_55 (33) = happyShift action_16
action_55 (4) = happyGoto action_17
action_55 (5) = happyGoto action_57
action_55 (6) = happyGoto action_5
action_55 (7) = happyGoto action_6
action_55 (8) = happyGoto action_7
action_55 (9) = happyGoto action_8
action_55 (10) = happyGoto action_9
action_55 (11) = happyGoto action_10
action_55 _ = happyReduce_11

action_56 _ = happyReduce_1

action_57 (21) = happyReduce_12
action_57 (22) = happyReduce_12
action_57 (23) = happyReduce_12
action_57 (24) = happyReduce_12
action_57 (25) = happyReduce_12
action_57 (27) = happyReduce_12
action_57 (28) = happyReduce_12
action_57 (29) = happyReduce_12
action_57 (30) = happyReduce_12
action_57 _ = happyReduce_12

happyReduce_1 = happyReduce 7 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Main happy_var_6
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (LnBrk happy_var_1 happy_var_3
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happyReduce 4 6 happyReduction_6
happyReduction_6 ((HappyTerminal (NUM happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VAR happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DeclareInt happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyTerminal (NUM happy_var_1))
	 =  HappyAbsSyn7
		 (EvalInt happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyTerminal (VAR happy_var_1))
	 =  HappyAbsSyn7
		 (EvalVar happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happyReduce 7 8 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (IfExp happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 8 8 happyReduction_12
happyReduction_12 ((HappyAbsSyn5  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (LnBrk (IfExp happy_var_3 happy_var_6) happy_var_8
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  9 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Mul happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  9 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Plus happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  9 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Minus happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  9 happyReduction_17
happyReduction_17 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Lt happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  9 happyReduction_18
happyReduction_18 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Le happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  9 happyReduction_19
happyReduction_19 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Eq happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Ne happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  9 happyReduction_21
happyReduction_21 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp And happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  9 happyReduction_22
happyReduction_22 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Or happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  9 happyReduction_23
happyReduction_23 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  10 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  10 happyReduction_25
happyReduction_25 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  11 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (RetV happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 34 34 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	IF -> cont 12;
	ELSE -> cont 13;
	LPAREN -> cont 14;
	RPAREN -> cont 15;
	OBRACE -> cont 16;
	CBRACE -> cont 17;
	NUM happy_dollar_dollar -> cont 18;
	VAR happy_dollar_dollar -> cont 19;
	EOL -> cont 20;
	AND -> cont 21;
	OR -> cont 22;
	MUL -> cont 23;
	MINUS -> cont 24;
	PLUS -> cont 25;
	EQB -> cont 26;
	LEQ -> cont 27;
	LESS -> cont 28;
	NEQ -> cont 29;
	EQL -> cont 30;
	INT -> cont 31;
	MAIN -> cont 32;
	RET -> cont 33;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 34 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Except String a -> (a -> Except String b) -> Except String b
happyThen = ((>>=))
happyReturn :: () => a -> Except String a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Except String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Except String a
happyError' = (\(tokens, _) -> parseError tokens)
parser tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError [] = throwError "Unexpected end of Input"

parseExpr :: String -> Either String Expression 
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  parser tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8336_0/ghc_2.h" #-}
































































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
