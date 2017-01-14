%defines "parser.h"

%code requires{
  #include "symbol.h" 
  #include <stdio.h>
  #include <stdlib.h>
 
  FILE* yyin;
  FILE* yyout;
  struct Number {
  	enum { INT, DOUBLE } type;
  	union {
  		double real;
  		int integer;
  	}
  };
}
%union {
	  struct Number number;
	  int token;
	  char * string;
	  char * type;
	  GPtrArray * identifiers;	
	  struct entry identifier;
	  struct variable variable_identifier;
	  int index;
 }
%token NONE;
%token DONE 0;
%token <number> NUM;
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
%token <string>  FUN "function";
%token <string> PROC "procedure";
%token <string> ARR "array";
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
%token VARIABLE
%token FUNCTION
%token PROCEDURE
%token ARRAY
%token KEYWORD
%type <entry> variable
%type <procedure> procedure_statement
%type <number> expression
%type <identifiers> identifier_list
%{
	identifier_list=g_ptr_array_new();
%}

%%


program: PROGRAM ID '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.'   {
                                                                                                                    print_assembly(yyin,DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }

;

identifier_list: ID	{ g_ptr_array_add($$,$1); }
                | identifier_list ',' ID	{ g_ptr_array_add($$,$3); }
;
declarations:
                | declarations VAR identifier_list ':' type ';'
;
type: standard_type	{
						int data_type_index=insert_data_type($1);
					}
      | ARR '[' NUM ".." NUM ']' OF standard_type
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

subprogram_head: FUN ID arguments ':' standard_type ';'
                | PROC ID arguments ';' '\n'

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

statement: variable ASSIGNOP expression		{ 
												int variable_index=find_variable($1);
												if (strcmp(variables[variable_index].type,"integer")==0)
													if (strcmp(variables[variable_index].type,yylval.type)==0)
														variables[variable_index].intval=$3;
													else 
														variables[variable_index].intval=(int)$3;
												else if (strcmp(variables[variable_index].type,"real")==0)
													if (strcmp(variables[variable_index].type,yylval.type)==0)
														variables[variable_index].realval=$3;
													else 
														variables[variable_index].realval=(double)$3;
												print_assembly(yyin,ASSIGNOP,yylval.number.type);
											}
;											
          | procedure_statement
          | compound_statement
          | IF expression THEN statement ELSE statement
          | WHILE expression DO statement

;

variable: ID	{ 
					int variable_index=find_variable($1);
					$$=variable_index;
				}
          | ID '[' expression ']'	{
          								int variable_index=find_variable($1);
										$$=variable_index;
									}
;

procedure_statement: ID	{ 
							int procedure_index=find_procedure($1);
							$$=procedures_list[procedure_index];
						}
                     | ID '(' expression_list ')' { 
													int procedure_index=find_procedure($1);
													$$=procedures_list[procedure_index];
												  }

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
        |  ID '(' expression_list ')'  
                
        | NUM 
        | '(' expression ')'
        | NOT factor
;
%%

FILE* open_pascal_file(char * filename){
  yyin=fopen(filename, "r");
}

void close_pascal_file(){
  fclose(yyin);
}
