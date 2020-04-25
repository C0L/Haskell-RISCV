{
module Parser where

import Lexer
}

%name parser

%tokentype { Token }
%error {parseError}

%token
  true  {TRUE}
  false {FALSE}
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
  '/='  {NEQ}
  '=='  {EQL}
  'int' {INT}

%nonassoc '=' '==' '/=' '<' '<=' if else
%left '||' '&&'
%left '+' '-'
%left '*' 
%%

Entry : true {"false"}


{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
