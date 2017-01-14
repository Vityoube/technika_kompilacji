#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE* yyin;
extern FILE* yyout;
extern char* open_assembly_file();
extern void print_assembly(FILE *, int, YYSTYPE);
#define YYPRINT (File, Type, Value) print_assembly(File, Type, Value);

#define BSIZE 128
extern int yylex();
extern FILE* open_pascal_file(char * filename);
extern void close_pascal_file();

extern int lookup(char name[],int type);
extern int insert (char name[], int tok, int token_type);
extern int insert_data_type(char standard_type[]);
extern int insert_array_data_type(char standard_type[],int first_index, int last_index);
extern int find_value(char name[]);
extern int find_variable(char name[]);
extern int find_array(char name[]);
extern int find_procedure(char name[]);
extern int find_function(char name[]);
extern int insert_value(char* type, int intval, double realval);
extern int insert_variable(char name[], char* type);
extern int insert_array(char name[], char type[], int first_index, int last_index);
extern int insert_procedure(char name[]);
extern int insert_function(char name[], char* return_type);
extern void init();
extern void yyerror(char const * s);
extern int yyparse(void);
extern int insert_function_arguments(char function_name[],GPtrArray* arguments,char type[]);
extern int insert_procedure_arguments(char procedure_name[],GPtrArray* arguments,char type[]);
extern int insert_function_local_variables(char function_name[],GPtrArray * variables,char type[]);
extern int insert_procedure_local_variables(char procedure_name[],GPtrArray* variables,char type[]);
extern double function_return_double_value(char function_name[], double return_double_value);
extern int function_return_int_value(char function_name[], int return_int_value);

