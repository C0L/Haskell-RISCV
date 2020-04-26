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
  '!='  {NEQ}
  '=='  {EQL}
  'int' {INT}

%nonassoc '=' '==' '!=' '<' '<=' if else
%left '||' '&&'
%left '+' '-'
%left '*' 
%%

TopLevel : Vals                             {$1}
         | Cond                             {$1}
         | Paren                            {$1}
         | Typs                             {$1}
         | BinOps                           {$1}

BinOps : TopLevel '*' TopLevel              {BinOp Mul $1 $3}
       | TopLevel '+' TopLevel              {BinOp Plus $1 $3}
       | TopLevel '-' TopLevel              {BinOp Minus $1 $3}
       | TopLevel '<' TopLevel              {BinOp Lt $1 $3} 
       | TopLevel '<=' TopLevel             {BinOp Le $1 $3} 
       | TopLevel '==' TopLevel             {BinOp Eq $1 $3} 
       | TopLevel '!=' TopLevel             {BinOp Ne $1 $3} 
       | TopLevel '&&' TopLevel             {BinOp And $1 $3} 
       | TopLevel '||' TopLevel             {BinOp Or $1 $3}

Vals : NUM                                  {EvalInt $1}
     | VAR                                  {EvalVar $1}

Paren : '(' TopLevel ')'                    {$2}

Cond : if '(' TopLevel ')' '{' TopLevel '}' {IfExp $3 $6}

Typs : 'int' VAR '=' NUM ';'                {DeclareInt $2 $4}

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

}
