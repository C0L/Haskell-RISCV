{
module Lexer (alexScanTokens, Token(..)) where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$eol   = [\n]

tokens :- 
  $white+  ;
  $digit+  {\s -> NUM (read s)}

  true     {\s -> TRUE}
  false    {\s -> FALSE}

  if       {\s -> IF}
  else     {\s -> ELSE}

  \(       {\s -> LPAREN}
  \)       {\s -> RPAREN}

  \{       {\s -> OBRACE}
  \}       {\s -> CBRACE}

  \==      {\s -> EQL}
  \/=      {\s -> NEQ}
  \<       {\s -> LESS}
  \<=      {\s -> LEQ}

  \=       {\s -> EQB}
  \+       {\s -> PLUS}
  \-       {\s -> MINUS}
  \*       {\s -> MUL}

  "&&"     {\s -> AND}
  "||"     {\s -> OR}

  ";"      {\s -> EOL}

  int      {\s -> INT}

  $alpha [$alpha $digit \_ \']* {\s -> VAR s }

{

data Token
  = TRUE 
  | FALSE
  | IF
  | ELSE 
  | LPAREN
  | RPAREN
  | OBRACE
  | CBRACE 
  | NUM Int
  | VAR String
  | EOL
  | AND
  | OR
  | MUL
  | MINUS
  | PLUS
  | EQB
  | LEQ
  | LESS
  | NEQ
  | EQL
  | INT
  deriving (Eq,Show)

}
