
%code requires{
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <vector>
  #include <string.h>
  #include "symbol_table.h" 
  extern FILE* yyin;
  extern FILE* yyout;
  struct Number {
  	enum { INT, DOUBLE } type;
  	union {
  		double real;
  		int integer;
  	};
  };
  void yyerror(char const * s);
  int yyparse(void);
  extern int yylex(void);
  extern FILE* yyin;
  extern FILE* yyout;
  extern char* open_assembly_file();  
}
%union {
	  struct Number number;
	  int token;
	  char * string;
	  char * type;  	
	  int index;
 }
 %{
  static void print_assembly(FILE * file, int type, YYSTYPE value);
  #define BSIZE 128
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();
 %}
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
//%type <variable_identifier	> variable
//%type <procedure> procedure_statement
//%type <number> expression
//%type <identifiers> identifier_list
//%type <data_type_struct> type

%%


program: PROGRAM ID '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.'   {
                                                                                                                    print_assembly(yyin,DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }

;

identifier_list: ID	{  }
                | identifier_list ',' ID	{  }
;
declarations:
                | declarations VAR identifier_list ':' type ';'
;
type: standard_type	{
						//$$=insert_data_type($1);
					}
      | ARR '[' NUM ".." NUM ']' OF standard_type	{
      													//$$=insert_array_data_type($8,$3,$5);
      												}
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
												//int variable_index=find_variable($1);
												//if (strcmp(variables[variable_index].type,"integer")==0)
													//if (strcmp(variables[variable_index].type,yylval.type)==0)
														//variables[variable_index].intval=$3;
													//else 
													//	variables[variable_index].intval=(int)$3;
												//else if (strcmp(variables[variable_index].type,"real")==0)
												//	if (strcmp(variables[variable_index].type,yylval.type)==0)
													//	variables[variable_index].realval=$3;
													//else 
														//variables[variable_index].realval=(double)$3;
												//print_assembly(yyin,ASSIGNOP,yylval.number.type);
											}
;											
          | procedure_statement
          | compound_statement
          | IF expression THEN statement ELSE statement
          | WHILE expression DO statement

;

variable: ID	{ 
					//int variable_index=find_variable($1);
					//$$=variables_list[variable_index];
				}
          | ID '[' expression ']'	{
          								//int variable_index=find_variable($1);
										//$$=variable_index;
									}
;

procedure_statement: ID	{ 
							//int procedure_index=find_procedure($1);
							//$$=procedures_list[procedure_index];
						}
                     | ID '(' expression_list ')' { 
													//int procedure_index=find_procedure($1);
													//$$=procedures_list[procedure_index];
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



int main(int argc, char* argv[]){
  init();
  open_pascal_file(argv[1]);
  yyparse();
  close_pascal_file();
}

static void print_assembly(FILE* file, int type, YYSTYPE value){
  int fd;
  char path[255];
  fd=fileno(yyin);
  sprintf(path, "/proc/self/fd/%d", fd);
  char filename[255];
  memset(filename, 0, sizeof(filename));
  readlink(path,filename,sizeof(filename)-1);
  char assembly_file[255];
  memset(assembly_file, 0, sizeof(assembly_file));
  strncpy(assembly_file,filename,strlen(filename)-4);
  strcat(assembly_file,".asm");
  FILE* output=fopen(assembly_file,"wb");
  if (type==NUM){

  }else if (type==DONE){
    fprintf(output,"%s","\texit\n");
  }
}


FILE* open_pascal_file(char * filename){
  yyin=fopen(filename, "r");
}

void close_pascal_file(){
  fclose(yyin);
}

void yyerror(char const * s){
  printf("Error: %s",s);
}
