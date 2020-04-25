all:
	happy Parser.y
	alex Lexer.x
	ghc --make Main.hs -o ../bin/compile

clean:
	rm Parser.hs
	rm Lexer.hs
	rm ../bin/compile 
	rm *.o
	rm *.hi
