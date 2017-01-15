
all:  parser.cpp parser.hpp lexer.cpp interpretator

parser.cpp parser.hpp: parser.yy symbol_table.h
		bison --debug -d -t -o parser.cpp parser.yy 
lexer.cpp: lexer.ll parser.hpp
		flex -l -o lexer.cpp lexer.ll

interpretator: parser.o lexer.o symbol_table.o 
		g++ -Wall -g symbol_table.cpp parser.cpp lexer.cpp -o interpretator  -lfl -lm

parser.o: parser.cpp parser.hpp
		g++ -c parser.cpp
lexer.o: lexer.cpp parser.hpp
		g++ -c lexer.cpp
symbol_table.o: symbol_table.cpp symbol_table.h
		g++ -c symbol_table.cpp
clean:
	rm -rf interpretator lexer.cpp parser.cpp parser.hpp parser.o lexer.o symbol_table.o
