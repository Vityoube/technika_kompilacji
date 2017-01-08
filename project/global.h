#define _POSIX_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define BSIZE 128
extern int yylex();
extern FILE* open_pascal_file(char * filename);
extern void close_pascal_file();
extern FILE* yyin;
extern FILE* yyout;
struct entry {
  int token;
  char* name;
};
struct value {
  char * name;
  char * data_type;
  int intval;
  double realval;
};
struct variable {
  char * name;
  char * data_type;
  int intval;
  double realval;
};
struct array {
  char * name;
  char * data_type;
  int first_index;
  int last_index;
};
struct procedure {
  char** argument_type;
  char * name;
  int arguments_count;
};
struct function {
  int arguments_count;
  char** arguments_type;
  char * return_type;
  int last_call_result;
} ;
extern struct entry keywords[];
extern struct value values[];
extern struct variable variables[];
extern struct array arrays[];
extern struct procedure procedures[];
extern struct function functions[];
extern int lookup(char s[]);
extern int insert (char s[], int tok);
extern void init();
extern void yyerror(char const * s);
extern int yyparse(void);
