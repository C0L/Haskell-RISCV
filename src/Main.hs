module Main where
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
