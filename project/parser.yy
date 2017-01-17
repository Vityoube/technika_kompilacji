
%code requires{
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <vector>
  #include <string.h>
  #include <string>
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
  FILE* open_assembly_file();
  #define BSIZE 128
	using namespace std;
	enum visibility { LOCAL, GLOBAL };
	enum standard_type { INT_TYPE, REAL_TYPE,VOID };
	enum Identifier { LOCAL_VARIABLE,GLOBAL_VARIABLE,VALUE,PROCEDURE,KEYWORD };
	struct Entry{
	  string name;
	  int token;
	  int token_type;
    bool is_array_data_type;
	  int first_index;
	  int last_index;
    int data_type;
 	  vector<Number> values;
    vector<int> arguments_indexes;
    int arguments_count;
	  bool is_function;
    int address;
    int local_variable_function_index;
	};
  struct Type {
    int standard_type;
    bool is_array;
    int first_index;
    int last_index;
  };

	extern vector<Entry> entries_list;
	extern int lookup(char* name, int token_type);
	extern int find_procedure(string name, vector<int> arguments_addresses, int return_type);
	extern int find_global_variable(string name);
	extern int find_local_variable(string name, int function_index);
  extern int insert(string name, int token, int token_type);
	extern int insert_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index, int visibility);
	extern void assign_procedure_to_local_variable(int variable_index, int procedure_index);
	extern int insert_procedure(string procedure_name,bool is_function, vector<int> arguments_addresses,
		int standard_return_type, bool is_array_return_type, int first_index, int last_index
		);
	extern void init();
}
%union {
	  int token;
	  int token_type;
	  char * name;
	  Number number;
	  int address;
	  int index;
    char * identifiers[1000];
    int standard_type;
    int declarations_index[1000];
    int arguments_indexes[1000];
    struct Type data_type;
 }
 %code provides{
  void print_assembly(int token, YYSTYPE token_value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();
 }
%{
    int last_identifier=0;
    int current_procedure_index=-1;
%}
%token NONE;
%token DONE 0;
%token <number> NUM;
%token <name> ID;
%token <name> IF "if";
%token <name> THEN "then";
%token <name> ELSE "else";
%token <name> WHILE "while";
%token <name> DO "do";
%token <name> BEG "begin";
%token <name> END "end";
%token <name> VAR "var";
%token <name> PROGRAM "program";
%token <name>  FUN "function";
%token <name> PROC "procedure";
%token <name> ARR "array";
%token <name> OF "of";
%token <name> INTEGER "integer";
%token <name> REAL "real";
%token <name> NOT "not";
%token <name> OR "or";
%token <name> SIGN;
%token <name> ASSIGNOP;
%token <name> MULOP;
%token <name> RELOP;
%token <name> '(' ')' ';' '.' '[' ']' ':' '\n'
%token <name> LAB0
//%type <variable_identifier	> variable
//%type <procedure> procedure_statement
//%type <number> expression
%type <identifiers> identifier_list
%type <data_type> type
%type <standard_type> standard_type
%type <index> subprogram_head

%%


program: PROGRAM ID '(' identifier_list ')' ';' global_declarations subprogram_declarations compound_statement '.'   {
                                                                                                                    print_assembly(yyin,DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }

;

identifier_list: ID	{
                      memset($$[last_identifier],0,strlen($1));
                      strcpy($$[last_identifier],$1);
                      last_identifier++;
                    }
                | identifier_list ',' ID	{
                                            memset($$[last_identifier],0,strlen($3));
                                            strcpy($$[last_identifier],$3);
                                            last_identifier++;
                                            print_assembly()
                                          }
;
global_declarations:
                | global_declarations VAR identifier_list ':' type ';'   {
                                                                            for (int i=0;i<last_identifier;i++){
                                                                              string identifier($3[i]);
                                                                              int p=find_global_variable(identifier);
                                                                              if(p==-1){
                                                                                struct Type type=$5;
                                                                                $<declarations_index>$[i]=insert_variable(identifier, type.standard_type,type.is_array,type.first_index,type.last_index,GLOBAL);
                                                                                printf("global variable: %s",entries_list.at($<declarations_index>$[i]).name);
                                                                              } else {
                                                                                yyerror("Variable %d is already defined.",identifier);
                                                                              }

                                                                            }
                                                                            memset(&(yylval.identifiers[0]),0,sizeof(yylval.identifiers));
                                                                            last_identifier=0;
                                                                          }
;
local_declarations:
                | local_declarations VAR identifier_list ':' type ';'   {
                                                                            for (int i=0;i<last_identifier;i++){
                                                                              string identifier($3[i]);
                                                                              int p=find_local_variable(identifier, current_procedure_index);
                                                                              if (p==-1){
                                                                                struct Type type=$5;
                                                                                $<declarations_index>$[i]=insert_variable(identifier, type.standard_type,type.is_array,type.first_index,type.last_index,LOCAL);
                                                                                assign_procedure_to_local_variable($<declarations_index>$[i],current_procedure_index);
                                                                                printf("local variable: %s",entries_list.at($<declarations_index>$[i]).name);
                                                                              } else {
                                                                                yyerror("Variable %d is already defined at this scope.",identifier);
                                                                              }
                                                                            }
                                                                            memset(&(yylval.identifiers[0]),0,sizeof(yylval.identifiers));
                                                                            last_identifier=0;
                                                                          }
type: standard_type	{
						            struct Type type;
                        type.standard_type=$1;
                        type.is_array=false;
                        type.first_index=0;
                        type.last_index=0;
                        $$=type;
					          }
      | ARR '[' NUM ".." NUM ']' OF standard_type	{
                                                      struct Type type;
                                                      type.standard_type=$8;
                                                      type.is_array=true;
                                                      struct Number first_index_NUM=$3;
                                                      struct Number last_index_NUM=$5;
                                                      type.first_index=first_index_NUM.integer;
                                                      type.last_index=last_index_NUM.integer;
                                                      $$=type;
      												                    }
;

standard_type: INTEGER  { $$=INT_TYPE;  }
               | REAL   { $$=REAL_TYPE; }
;

subprogram_declarations:
                        | subprogram_declarations subprogram_declaration ';'

;


subprogram_declaration: subprogram_head
                        local_declarations
                        compound_statement

;

subprogram_head: FUN ID arguments ':' standard_type ';' {
                                                            string function_name($2);
                                                            vector<int> arguments_indexes;
                                                            for (int i=0;i<last_identifier;i++){
                                                              arguments_indexes.push_back($3[i]);
                                                            }
                                                            int p=find_procedure(function_name,arguments_indexes,$5);
                                                            if (p==-1){
                                                              current_function_index=insert_procedure(function_name,true,arguments_indexes,$5,false,0,0);
                                                            } else {
                                                              yyerror("The function is already defined in the program.")
                                                            }
                                                            memset(&(yylval.identifiers[0]),0,sizeof(yylval.identifiers));
                                                            last_identifier=0;

                                                        }
                | PROC ID arguments ';' '\n'            {
                                                            string procedure_name($2);
                                                            vector<int> arguments_indexes;
                                                            for (int i=0;i<last_identifier;i++)
                                                              arguments_indexes.push_back($3[i]);
                                                            int p=find_procedure(procedure_name,arguments_indexes,VOID);
                                                            if (p==-1)
                                                              current_function_index=insert_procedure(procedure_name,false,arguments_indexes,VOID,false,0,0);
                                                            else
                                                              yyerror("The procedure is already defined in the program.");
                                                            memset(&(yylval.identifiers[0]),0,sizeof(yylval.identifiers));
                                                            last_identifier=0;
                                                        }

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
  open_assembly_file();
  yyparse();
  close_pascal_file();
}

void print_assembly(int token, YYSTYPE token_value){

  if (token==NUM){

  }else if (token==LAB0){
    fprintf(yyout,"%s","\tjump.i\t\n");
  }else if (token==DONE){
    fprintf(yyout,"%s","\texit\n");
  }
}


FILE* open_pascal_file(char * filename){
  yyin=fopen(filename, "r");
}

FILE* open_assembly_file(){
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
  yyout=fopen(assembly_file,"wb");
}

void close_pascal_file(){
  fclose(yyin);
}

void yyerror(char const * s){
  printf("Error: %s",s);
  throw invalid_argument(s);
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
