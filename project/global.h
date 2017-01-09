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
  struct variable arguments[];
  struct variable local_variables[];
  int last_function_call_int_result;
  double last_function_call_double_result;
  char * name;
  int arguments_count;
};
struct function {
  struct variable arguments[];
  struct variable local_variables[];
  char * return_type;
  int arguments_count;
  int return_int_value;
  double return_double_value;
} ;
extern struct entry dictionary[];
extern struct value values[];
extern struct variable variables[];
extern struct array arrays[];
extern struct procedure procedures[];
extern struct function functions[];
extern int lookup(char s[]);
extern int insert (char s[], int tok);
extern int find_value(char name[]);
extern int find_variable(char name[]);
extern int find_array(char name[]);
extern int find_procedure(char name[]);
extern int find_function(char name[]);
extern int insert_value(char* type, int intval, double realval);
extern int insert_variable(char name[], char* data_type, int intval, double realval);
extern int insert_array(char[] name, char data_type[], int first_index, int last_index);
extern int insert_procedure(char[] name, char * arguments[], char * arguments_type[]);
extern int insert_function(char[] name, char * arguments[], char * arguments_type[], char* return_type, int last_call_result);
extern void init();
extern void yyerror(char const * s);
extern int yyparse(void);
