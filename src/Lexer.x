{
{-# LANGUAGE FlexibleContexts #-}

module Lexer (scanTokens, Token(..)) where

import Control.Monad.Except

}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$eol   = [\n]

tokens :- 
  $white+  ;
  $eol+    ;
  $digit+  {\s -> NUM (read s)}

  if       {\s -> IF}
  else     {\s -> ELSE}

  \(       {\s -> LPAREN}
  \)       {\s -> RPAREN}

  \{       {\s -> OBRACE}
  \}       {\s -> CBRACE}

  \==      {\s -> EQL}
  \!=      {\s -> NEQ}
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
  main     {\s -> MAIN}

  return   {\s -> RET}

  $alpha [$alpha $digit \_ \']* {\s -> VAR s }

{

data Token
  = IF
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
  | MAIN
  | RET
  deriving (Eq,Show)

scanTokens :: String -> Except String [Token]
scanTokens str = go ('\n',[],str) where 
  go inp@(_,_bs,str) =
    case alexScan inp 0 of
     AlexEOF -> return []
     AlexError _ -> throwError "Invalid lexeme."
     AlexSkip  inp' len     -> go inp'
     AlexToken inp' len act -> do
      res <- go inp'
      let rest = act (take len str)
      return (rest : res)
}
