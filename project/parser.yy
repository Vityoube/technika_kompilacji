
%code requires{
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <vector>
  #include <string.h>
  #include <string>
  #include "symbol_table.h" 
  extern FILE* yyin;
  extern FILE* yyout;
 
  
  struct Number {
  	int type;
  	union {
  		double real;
  		int integer;
  	};
  };
  extern void yyerror(char const * s);
  int yyparse(void);
  extern int yylex(void);
  extern FILE* yyin;
  extern FILE* yyout;
  extern char* open_assembly_file(); 
  #define BSIZE 128
	using namespace std;
	enum visibility { LOCAL, GLOBAL };
	enum standard_type { INT_TYPE, REAL_TYPE };
	enum Identifier { LOCAL_VARIABLE,GLOBAL_VARIABLE,PROCEDURE, ARRAY,KEYWORD };
	struct Entry{
	  string name;
	  int token;
	  int token_type;
	};
	struct Value{
	  int standard_type;
	  int intval;
	  double realval;
	};
	struct Variable{
	  string variable_name;
	  int standard_type;
	  bool is_array;
	  vector<Value> values;
	  int visibility;
	  string function_name;
	};
	
	struct Procedure {
	  string procedure_name;
	  vector<Variable> arguments;
	  vector <Variable> local_variables;
	  int arguments_count;
	  int standard_return_type;
	  bool is_array_return_type;
	  bool is_function;
	  int first_index;
	  int last_index;
	  vector<Value> return_values;
	};
	
	extern vector<Entry> entries_list;
	extern vector<Value> values_list;
	extern vector<Variable> variables_list;
	extern vector<Procedure> procedures_list;
	extern int lookup(char* name,int type);
	extern int insert (string name, int tok, int token_type);
	extern int find_local_variable(string name);
	extern int find_global_variable(string name);
	extern int find_procedure(char name[]);
	extern int find_function(char name[]);
	extern int insert_global_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index);
	extern int insert_local_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index,
			string function_name);
	extern int insert_procedure(string procedure_name,bool is_function, vector<Variable> arguments,
			int standard_return_type, bool is_array_return_type, int first_index, int last_index
			);
	extern void init();
}
%union {
	  int token;
	  char * string;
	  char * type;
	  struct Val {
	  	int standard_type;
	  	int intval;
	  	double realval;
	  } value;
	  struct Var {
	  	char * name;
	  	int standard_type;
	  	struct Val values[1000];
	  	int visibility;
	  	char * function_name;
	  } var;
	  struct Proc {
	  	int last_function_call_int_result;
	    double last_function_call_double_result;
	    char * name;
	    struct Var arguments[1000];
	    struct Var local_variables[1000];
	    int arguments_count;
	    int standard_return_type;
	    bool is_array_return_type;
	    struct Val return_values[1000];	
	  } proc;
	  struct Identifier{
	  	char * name;
		int standard_data_type;
		bool is_array;
		int first_index;
		int last_index;
		} identifier;
	  struct Identifier identifiers_list[1000]; 	
	  int index;
 }
 %code provides{
  void print_assembly(FILE * file, int type, YYSTYPE value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();
 }
 %{
 	int last_identifier=0; 
 %}
%token NONE;
%token DONE 0;
%token <value> NUM;
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

void print_assembly(FILE* file, int type, YYSTYPE value){
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

struct Entry keywords_dictionary[]={
  {"if", IF},
  {"then",THEN},
  {"else",ELSE},
  {"while",WHILE},
  {"do",DO},
  {"var",VAR},
  {"program",PROGRAM},
  {"function",FUN},
  {"procedure",PROC},
  {"array",ARR},
  {"of",OF},
  {"integer",INTEGER},
  {"real",REAL},
  {"not",NOT},
  {"or",OR},
  {"begin",BEG},
  {"end",END},
  {":=",ASSIGNOP},
  {"+",SIGN},{"-",SIGN},
  {"*",MULOP},{"/",MULOP},{"div",MULOP},{"mod",MULOP},
  {"=",RELOP},{"<>",RELOP},{"<=",RELOP},{"<",RELOP},{"=>",RELOP},{">",RELOP}
};

void init(){
  struct Entry *p;
  for (p=keywords_dictionary;p->token;p++)
    insert(p->name,p->token,KEYWORD);
}
