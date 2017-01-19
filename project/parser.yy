%code requires{
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <vector>
  #include <string.h>
  #include <string>
  #include <cstring>
  #include <stdexcept>
  using namespace std;
  extern FILE* yyin;
  extern FILE* yyout;
  typedef std::vector<std::string> Identifiers;
  typedef std::vector<int> Indexes;
  extern int yylex();
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
	enum visibility { LOCAL, GLOBAL,ARG,TEMPORARY };
	enum standard_type { INT_TYPE, REAL_TYPE,VOID };
	enum Identifier { LOCAL_VARIABLE,GLOBAL_VARIABLE,VALUE,PROCEDURE,KEYWORD,TEMPORARY_VARIABLE,ARGUMENT };
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
  struct Procedure{
    string* name;
    int address;
  };
  struct Type {
    int standard_type;
    bool is_array;
    int first_index;
    int last_index;
  };
  struct Statement{
    int statement_type;

  };
  extern vector<string> current_identifiers_list;
  extern vector<int> current_declarations_indexes;
  extern vector<int> current_parameter_indexes;
  extern int current_procedure_index;
  extern vector<int> current_arguments_indexes;
	extern vector<Entry> entries_list;
	extern int lookup(char* name, int token_type);
	extern int find_procedure(string name, vector<int> arguments_addresses, int return_type);
  extern int find_procedure(string name, vector<int> arguments_types, vector<bool> is_array,vector<int> sizes);
  extern bool find_argument(int function_index, int argument_index, int argument_type, bool is_array, int size);
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
	  string* name;
	  Number number;
	  int address;
    struct Procedure procedure;
	  int index;
    vector<string> * identifiers;
    int standard_type;
    vector<int> * declarations_indexes;
    vector<int> * arguments_indexes;
    struct Type data_type;
    vector<Number> * expression_values;
    vector<Entry> * entries;
 }
 %code provides{
  void print_assembly(int token, YYSTYPE token_value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();

 }

%token NONE;
%token DONE 0;
%token <number> NUM;
%token <name> ID;
%token <name> IF "if";
%token <name> WHILE "while";
%token <name> THEN "then";
%token <name> ELSE "else";
%token <name> DO "do";
%token <name> BEG "begin";
%token <name> END "end";
%token <name> VAR "var";
%token <name> PROGRAM "program";
%token <name> FUN "function";
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
%token <name> START
%token <name> REAL_FUN
%token <name> INT_FUN
%token <name> PROC_CALL
%token <name> RETURN
%token <name> NEW_BLOCK
%token <name> PROC_CALL_WITH_ARGUMENTS
//%type <variable_identifier	> variable
%type <index> procedure_statement
//%type <number> expression
%type <data_type> type
%type <standard_type> standard_type
%type <index> subprogram_head
%type <entries> expression_list
%{
  int last_parameter=-1;
  bool local_scope=false;
  int compound_statements_complexity=0;
  int current_block=0;
%}
%%


program: PROGRAM ID '(' input_output ')' ';' global_declarations subprogram_declarations compound_statement '.'   {
                                                                                                                    print_assembly(DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }

;
input_output: identifier_list {
                                  current_identifiers_list.clear();
                              }
identifier_list: ID	{
                      string identifier=*$1;
                      current_identifiers_list.push_back(identifier);
                    }
                | identifier_list ',' ID	{
                                            string identifier=*$3;
                                            current_identifiers_list.push_back(identifier);
                                          }
;
global_declarations: global_declarations VAR identifier_list ':' type ';'   {
                                                                            for (string identifier: current_identifiers_list){
                                                                              int p=find_global_variable(identifier);
                                                                              if(p==-1){
                                                                                struct Type type=$5;
                                                                                insert_variable(identifier, type.standard_type,type.is_array,type.first_index,type.last_index,GLOBAL);
                                                                                printf("global variable: %s\n",identifier.c_str());
                                                                              } else {
                                                                                yyerror("Variable is already defined\n");
                                                                              }
                                                                            }
                                                                            current_identifiers_list.clear();
                                                                          }
              |                                                           { print_assembly(START,yylval); }
;
local_declarations:
                | local_declarations VAR identifier_list ':' type ';'   {
                                                                            struct Type type=$5;
                                                                            for (string identifier: current_identifiers_list){
                                                                              if (current_parameter_indexes.empty()){
                                                                                int current_parameter_index=insert_variable(identifier,type.standard_type,
                                                                                  type.is_array,type.first_index,type.last_index,LOCAL);
                                                                                current_parameter_indexes.push_back(current_parameter_index);
                                                                              }
                                                                              else{
                                                                                for (int current_parameter_index : current_parameter_indexes)
                                                                                  if (identifier.compare(entries_list.at(current_parameter_index).name)==0)
                                                                                    yyerror("Variable is already defined at this sope.\n");
                                                                                int current_parameter_index=insert_variable(identifier,type.standard_type,
                                                                                  type.is_array,type.first_index,type.last_index,LOCAL);
                                                                                current_parameter_indexes.push_back(current_parameter_index);
                                                                              }
                                                                              printf("Local variable: %s\n",identifier.c_str());
                                                                            }
                                                                            current_identifiers_list.clear();
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

subprogram_declarations:  /* empty */
                        | subprogram_declarations subprogram_declaration ';'
;


subprogram_declaration: subprogram_head
                        local_declarations
                        compound_statement  {
                                              current_procedure_index=-1;
                                              current_parameter_indexes.clear();
                                              current_arguments_indexes.clear();
                                              local_scope=false;
                                              print_assembly(RETURN,yylval);
                                             }

;

subprogram_head: FUN ID arguments ':' standard_type ';' {
                                                            string function_name=*$2;
                                                            int p=find_procedure(function_name,current_parameter_indexes,$5);
                                                            if (p==-1){
                                                              current_procedure_index=insert_procedure(function_name,true,current_parameter_indexes,$5,false,0,0);
                                                              $$=current_procedure_index;
                                                              printf("Function: %s\n",function_name.c_str());
                                                            } else {
                                                              yyerror("The function is already defined in the program.\n");
                                                            }
                                                            for (int argument_index : current_arguments_indexes)
                                                              assign_procedure_to_local_variable(argument_index,current_procedure_index);
                                                            current_identifiers_list.clear();
                                                            struct Procedure new_procedure;
                                                            new_procedure.name=new string(function_name);
                                                            new_procedure.address=entries_list.at($$).address;
                                                            yylval.procedure=new_procedure;
                                                            if ($5==INT_TYPE)
                                                              print_assembly(INT_FUN,yylval);
                                                            else if ($5=REAL_TYPE)
                                                              print_assembly(REAL_FUN,yylval);
                                                            local_scope=true;
                                                        }
                | PROC ID arguments ';'            {
                                                            string procedure_name=*$2;
                                                            int p=find_procedure(procedure_name,current_parameter_indexes,VOID);
                                                            if (p==-1){
                                                              current_procedure_index=insert_procedure(procedure_name,false,current_parameter_indexes,VOID,false,0,0);
                                                              $$=current_procedure_index;
                                                              printf("Procedure: %s\n",procedure_name.c_str());
                                                            } else
                                                              yyerror("The procedure is already defined in the program.\n");
                                                            for (int argument_index : current_arguments_indexes)
                                                              assign_procedure_to_local_variable(argument_index,current_procedure_index);
                                                            current_identifiers_list.clear();
                                                            struct Procedure new_procedure;
                                                            new_procedure.name=new string(procedure_name);
                                                            new_procedure.address=entries_list.at($$).address;
                                                            yylval.procedure=new_procedure;
                                                            print_assembly(PROC,yylval);
                                                            local_scope=true;
                                                        }

;

arguments:
           |   '(' parameter_list ')' {  }
;

parameter_list: identifier_list ':' type  {
                                              struct Type type=$3;
                                              for (string identifier : current_identifiers_list){
                                                if (current_parameter_indexes.empty()){
                                                  int current_parameter_index=insert_variable(identifier,type.standard_type,type.is_array,type.first_index,type.last_index,ARG);
                                                  current_parameter_indexes.push_back(current_parameter_index);
                                                  current_arguments_indexes.push_back(current_parameter_index);
                                                }
                                                else{
                                                  for (int current_parameter_index : current_parameter_indexes)
                                                    if (identifier.compare(entries_list.at(current_parameter_index).name)==0)
                                                      yyerror("Argument is already defined.\n");
                                                  int current_parameter_index=insert_variable(identifier,type.standard_type,type.is_array,type.first_index,type.last_index,ARG);
                                                  current_parameter_indexes.push_back(current_parameter_index);
                                                  current_arguments_indexes.push_back(current_parameter_index);
                                                }
                                                printf("Function argument: %s\n",identifier.c_str());
                                              }
                                              current_identifiers_list.clear();
                                          }
                | parameter_list ';' identifier_list ':' type {
                                                                struct Type type=$5;
                                                                for (string identifier : current_identifiers_list){
                                                                  if (current_parameter_indexes.empty()){
                                                                    int current_parameter_index=insert_variable(identifier,type.standard_type,
                                                                      type.is_array,type.first_index,type.last_index,ARG);
                                                                    current_parameter_indexes.push_back(current_parameter_index);
                                                                    current_arguments_indexes.push_back(current_parameter_index);
                                                                  }else{
                                                                    for (int current_parameter_index : current_parameter_indexes)
                                                                      if (identifier.compare(entries_list.at(current_parameter_index).name)==0)
                                                                          yyerror("Argument is already defined.\n");
                                                                      int current_parameter_index=insert_variable(identifier,type.standard_type,type.is_array,
                                                                        type.first_index,type.last_index,ARG);
                                                                      current_parameter_indexes.push_back(current_parameter_index);
                                                                      current_arguments_indexes.push_back(current_parameter_index);
                                                                    }
                                                                    printf("Function argument: %s\n",identifier.c_str());
                                                                }
                                                                current_identifiers_list.clear();
                                                              }
;
compound_statement:   BEG
                      optional_statements
                      END               { compound_statements_complexity--; }

;

optional_statements:              {
                                    if (!local_scope && compound_statements_complexity==0)
                                      print_assembly(NEW_BLOCK,yylval);
                                    compound_statements_complexity++;
                                   }
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

          | procedure_statement {
                                  struct Entry procedure=entries_list.at($1);
                                  if (procedure.arguments_count==0){
                                      string procedure_name=procedure.name;
                                      struct Procedure called_procedure;
                                      called_procedure.name=new string(procedure_name);
                                      yylval.procedure=called_procedure;
                                      print_assembly(PROC_CALL,yylval);
                                  } else {
                                    print_assembly(PROC_CALL_WITH_ARGUMENTS,yylval);
                                    yylval.entries=new vector<Entry>();
                                  }
                                }
          | compound_statement
          | IF expression THEN statement ELSE statement
          | WHILE expression DO statement

;

variable: ID	{
                  int identifier_index;
					       //int variable_index=find_variable($1);
					       //$$=variables_list[variable_index];
				}
          | ID '[' expression ']'	{
          								//int variable_index=find_variable($1);
										//$$=variable_index;
									}
;

procedure_statement: ID	{
                           string procedure_name=*$1;
							             int procedure_index=find_procedure(procedure_name,vector<int>(),VOID);
                           $$=procedure_index;
						            }
                     | ID '(' expression_list ')' {
                                                    string procedure_name=*$1;
                                                    vector<Entry> expression_results=*$3;
                                                    vector<int> arguments_types;
                                                    vector<bool> is_array;
                                                    vector<int> sizes;
                                                    for (Entry expression_result : expression_results){
                                                      switch(expression_result.token_type){
                                                        case VALUE:
                                                          arguments_types.push_back(expression_result.data_type);
                                                          is_array.push_back(false);
                                                          sizes.push_back(0);
                                                          break;
                                                        case LOCAL_VARIABLE:
                                                        case GLOBAL_VARIABLE:
                                                        case ARGUMENT:
                                                        case TEMPORARY_VARIABLE:
                                                        case PROCEDURE:
                                                            arguments_types.push_back(expression_result.data_type);
                                                            is_array.push_back(expression_result.is_array_data_type);
                                                            sizes.push_back(expression_result.last_index-expression_result.first_index);
                                                            break;
                                                      }
                                                    }
                                                    int procedure_index=find_procedure(procedure_name,arguments_types,is_array,sizes);
                                                    if (procedure_index==-1)
                                                      yyerror("Cannot find function with that name and arguments");
                                                    yylval.entries=new vector<Entry>(expression_results);

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

  }else if(token==INT_FUN) {
      string function_name=*(token_value.procedure.name);
      fprintf(yyout,"%s:\n",function_name.c_str());
      fprintf(yyout,"\t\tenter.i\t#%d\n",token_value.procedure.address);
  } else  if (token==REAL_FUN){
    string function_name=*(token_value.procedure.name);
    fprintf(yyout,"%s:\n",function_name.c_str());
    fprintf(yyout,"\t\tenter.r\t#%d\n",token_value.procedure.address);
  } else if(token==PROC){
    string procedure_name=*(token_value.procedure.name);
    fprintf(yyout,"%s:\n",procedure_name.c_str());
    fprintf(yyout,"\t\tenter\t#%d\n",token_value.procedure.address);
  }else if (token==PROC_CALL){
    string procedure_name=*(token_value.procedure.name);
    fprintf(yyout,"\t\tcall.i\t#%s",procedure_name.c_str());
  } else if (token==PROC_CALL_WITH_ARGUMENTS){
    vector<Entry> entries=*(token_value.entries);
    for (struct Entry entry: entries){
      if (entry.data_type==INT_TYPE)
        fprintf(yyout,"\t\tpush.i\t#%d",entry.address);
      else if (entry.data_type==REAL_TYPE)
        fprintf(yyout,"\t\tpush.r\t#%d",entry.address);
    }

  }else if (token==RETURN){
    fprintf(yyout,"\t\tleave\n\t\treturn\n");
  }else if(token==NEW_BLOCK){
    fprintf(yyout,"lab%d:\n",current_block);
  }else if (token==START){
    fprintf(yyout,"\t\tjump.i\t#lab0\n");
  }else if (token==DONE){
    fprintf(yyout,"%s","\t\texit\n");
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
