all:
    happy -gca Pargrammar.y
    alex -g Lexgrammar.x
    ghc --make Testgrammar.hs -o Testgrammar

