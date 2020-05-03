{
module Parser (parseExpr, parseTokens) where

import Lexer
import ASTtypes
import Control.Monad.Except

}

%name parser  

%tokentype { Token }
%monad { Except String } { (>>=) } { return }
%error { parseError }

%token
  if    {IF}
  else  {ELSE}
  '('   {LPAREN}
  ')'   {RPAREN}  
  '{'   {OBRACE}
  '}'   {CBRACE}  
  NUM   {NUM $$}
  VAR   {VAR $$}
  ';'   {EOL}
  '&&'  {AND}
  '||'  {OR}
  '*'   {MUL}
  '-'   {MINUS}
  '+'   {PLUS}
  '='   {EQB}
  '<='  {LEQ}
  '<'   {LESS}
  '>'   {GREAT}
  '>='  {GEQ}
  '!='  {NEQ}
  '=='  {EQL}
  'int' {INT}
  'main'   {MAIN}
  'return' {RET} 

%nonassoc '=' '==' '!=' '<' '<=' '>=' '>' if else
%left '||' '&&'
%left '+' '-'
%left '*' 
%%

Func : 'int' 'main' '(' ')' '{' Div '}'     {Main $6}
     | Div                                  {$1} 

Div : Typs ';' Div                          {LnBrk $1 $3}
    | Typs ';'                              {$1}
    | Typs                                  {$1}

Typs : 'int' VAR '=' NUM                    {DeclareInt $2 $4}
     | Vals                                 {$1}


Vals : NUM                                  {IntLiteral $1}
     | VAR                                  {EvalVar $1}
     | VAR '=' Vals                         {Asgn $1 $3}
     | Cond                                 {$1}

Cond : if '(' Func ')' '{' Func '}'             {IfExp $3 $6}
     | if '(' Func ')' '{' Func '}' Div         {LnBrk (IfExp $3 $6) $8}
     | if '(' Func ')' '{' Func '}' Elses       {}
     | if '(' Func ')' '{' Func '}' Elses Div   {LnBrk (IfElExp $3) $5}
     | BinOps                                   {$1}

BinOps : Func '*' Func                      {BinOp Mul $1 $3}
       | Func '+' Func                      {BinOp Plus $1 $3}
       | Func '-' Func                      {BinOp Minus $1 $3}
       | Func '<' Func                      {BinOp Lt $1 $3} 
       | Func '<=' Func                     {BinOp Le $1 $3} 
       | Func '>' Func                      {BinOp Gt $1 $3} 
       | Func '>=' Func                     {BinOp Ge $1 $3} 
       | Func '==' Func                     {BinOp Eq $1 $3} 
       | Func '!=' Func                     {BinOp Ne $1 $3} 
       | Func '&&' Func                     {BinOp And $1 $3} 
       | Func '||' Func                     {BinOp Or $1 $3}
       | Paren                              {$1}

Paren : '(' Func ')'                        {$2}
      | Ret                                 {$1}

Else : ELSE '{' Func '}'
     | ELSE IF '(' Func ')' '{' Func '}' 

Ret : 'return' Vals ';'                     {RetV $2}


{
parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError [] = throwError "Unexpected end of Input"

parseExpr :: String -> Either String Expression 
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  parser tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens

makeClause :: [Else]

}
