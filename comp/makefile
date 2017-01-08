all: parser.c lexer.c comp

CFLAGS=-Wall

parser.c: parser.y
	bison parser.y -o parser.c -l -d -y
comp:  main.o init.o emitter.o lexer.o parser.o error.o symbol.o
	cc -g -Wall parser.c main.c init.c emitter.c lexer.c error.c symbol.c -o comp -lfl

parser.o: parser.c global.h parser.h
	cc -c parser.c
main.o: main.c global.h
	cc -c main.c
init.o: init.c global.h
	cc -c init.c 
emitter.o: emitter.c global.h
	cc -c emitter.c
error.o: error.c global.h
	cc -c error.c
lexer.o: lexer.c global.h 
	cc -c lexer.c
lexer.c: lexer.l
	flex lexer.l


symbol.o: symbol.c global.h
	cc -c symbol.c
.PRECIOUS: comp
.PHONY : comp
.EXPORT_ALL_VARIABLES: 1
clean:
	rm comp lexer.c main.o init.o emitter.o lexer.o parser.o error.o symbol.o parser.c parser.h
.PRECIOUS: main.o
