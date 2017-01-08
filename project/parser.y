%defines "parser.h"

%union {
  int integer;
  double real;
  char * string;
}

%{
  #include "global.h"
  #include <glib.h>
  extern void print_assembly(FILE *, int, YYSTYPE);
  extern char* open_assembly_file();
  #define YYPRINT (File, Type, Value) print_assembly(File, Type, Value);
  extern int canWriteToSymtable=1;

%}
%token <integer> NONE;
%token <integer> DONE 0;
%token <integer> NUM;
%token <string> ID;
%token <string> IF "if";
%token <string> THEN "then";
%token <string> ELSE "else";
%token <string> WHILE "while";
%token <string> DO "do";
%token <string> BEG "begin";
%token <string> END "end";
%token <string> VAR "var";
%token <string> PROGRAM "program";
%token <string>  FUNCTION "function";
%token <string> PROCEDURE "procedure";
%token <string> ARRAY "array";
%token <string> OF "of";
%token <string> INTEGER "integer";
%token <string> REAL "real";
%token <string> NOT "not";
%token <string> OR "or";
%token <string> SIGN;
%token <string> ASSIGNOP;
%token <string> MULOP;
%token <string> RELOP;
%token <string> '(' ')' ';' '.' '[' ']' ':' '\n'

%%

program: PROGRAM ID '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.'   {
                                                                                                                        print_assembly(yyin,DONE,yylval);
                                                                                                                        YYACCEPT;
                                                                                                                    }

;

identifier_list: ID
                | identifier_list ',' ID
;
declarations:
                | declarations VAR identifier_list ':' type ';'
;
type: standard_type
      | ARRAY '[' NUM ".." NUM ']' OF standard_type
;

standard_type: INTEGER
               | REAL
;

subprogram_declarations:
                        | subprogram_declarations subprogram_declaration ';'

;


subprogram_declaration: subprogram_head
                        declarations
                        compound_statement

;

subprogram_head: FUNCTION ID arguments ':' standard_type ';'
                | PROCEDURE ID arguments ';' '\n'

;

arguments: '(' parameter_list ')'
           |
;

parameter_list: identifier_list ':' type
                | parameter_list ';' identifier_list ':' type
;

compound_statement: BEG
                    optional_statements
                    END

;

optional_statements:
                    | statement_list
;
statement_list: statement
                | statement_list ';' statement

;

statement: variable ASSIGNOP expression
          | procedure_statement
          | compound_statement
          | IF expression THEN statement ELSE statement
          | WHILE expression DO statement

;

variable: ID
          | ID '[' expression ']'

;

procedure_statement: ID
                     | ID '(' expression_list ')'

;

expression_list: expression
                | expression_list ',' expression
;

expression: simple_expression
            | simple_expression RELOP simple_expression

;

simple_expression: term
                  | SIGN term
                  | simple_expression SIGN term
                  | simple_expression OR term

;

term: factor
      | term MULOP factor

;

factor: variable
        |  ID '(' expression_list ')'  {
                print_assembly(yyin,ID,yylval);
            }
        | NUM {
                /*print_assembly(yyin,ID,yylval);*/
            }
        | '(' expression ')'
        | NOT factor
;
%%
