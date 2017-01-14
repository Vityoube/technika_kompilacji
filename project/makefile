
CFLAGS = `pkg-config --cflags glib-2.0`
LDLIBS = `pkg-config --libs glib-2.0`
all:  parser.c lexer.c interpretator

parser.c: parser.y symbol.h
		bison  parser.y -o parser.c
lexer.c: lexer.l global.h
		flex -l lexer.l

interpretator: parser.o lexer.o  main.o init.o error.o symbol_table.o file_printer.o
		gcc -Wall -g ${CFLAGS}  parser.c lexer.c main.c init.c error.c symbol_table.c  file_printer.c ${LDLIBS}  -o interpretator  -lfl -lm

parser.o: parser.c parser.h
		cc  -c ${CFLAGS} parser.c
lexer.o: lexer.c  global.h parser.h
		cc -c ${CFLAGS}  lexer.c
main.o: main.c global.h
	 	cc  -c ${CFLAGS} main.c
init.o: init.c global.h
		cc -c ${CFLAGS} init.c
error.o: error.c global.h
		cc  -c ${CFLAGS} error.c
symbol_table.o: symbol_table.c global.h
		cc  -c ${CFLAGS} symbol_table.c
file_printer.o: file_printer.c global.h
		cc  -c ${CFLAGS} file_printer.c
clean:
	rm -rf interpretator lexer.c parser.c parser.h parser.o lexer.o file_printer.o main.o symbol_table.o init.o error.o
