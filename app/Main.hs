module Main where

import ASTtypes
import Parser
import Lexer
import Comp


main :: IO ()
main = do
  input <- getContents
  let tokens = parseTokens input 
  putStrLn ("Tokens: " ++ show tokens)
  let ast = parseExpr input
  putStrLn ("Syntax: " ++ show ast)
  case ast of
    Left err -> do 
      putStrLn "Parse Error" 
      print err
    Right ps -> do
      let toks = case tokens of (Right t) -> t
      let asm = compMain (Prog ps) toks
      putStrLn("Asm: \n" ++ asm)
