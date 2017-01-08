
CFLAGS = `pkg-config --cflags glib-2.0`
LDLIBS = `pkg-config --libs glib-2.0`
all: ${CFLAGS} ${LDLIBS} parser.c lexer.c interpretator

parser.c: parser.y global.h
		bison parser.y -o parser.c
lexer.c: lexer.l global.h parser.h
		flex -l lexer.l

interpretator: lexer.o parser.o file_printer.o main.o init.o error.o symbol_table.o
		gcc -Wall -g -o interpretator ${CFLAGS} parser.c lexer.c file_printer.c main.c init.c error.c symbol_table.c ${LDLIBS} -lfl

parser.o: parser.c global.h parser.h
		cc  -c parser.c
lexer.o: lexer.c  global.h parser.h
		cc -c lexer.c
file_printer.o: file_printer.c global.h parser.h
		cc  -c file_printer.c
main.o: main.c global.h parser.h
	 	cc  -c main.c
init.o: init.c global.h parser.h
		cc -c init.c
symbol_table.o: symbol_table.c global.h parser.h
		cc  -c symbol_table.c
error.o: error.c global.h parser.h
		cc  -c error.c

clean:
	rm -rf interpretator lexer.c parser.c parser.h parser.o lexer.o file_printer.o main.o symbol_table.o init.o error.o
