module Main where
import Parser
import Lexer

main = do
  fileStr <- getContents
  let out = parser $ alexScanTokens fileStr
  putStr out
