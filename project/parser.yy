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
  enum assign_types { CONSTANT_ASSIGN, VARIABLE_ASSIGN };
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
    vector<int> addresses;
    int local_variable_function_index;
    int current_array_index;
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
  struct Token_Identifier {
    string * name;
    int token;
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
  struct Entry convert_entry(struct Entry entry);
  struct Entry  convert_entries(struct Entry entry1, struct Entry entry2);
}
%code provides{
  void print_assembly(int token, YYSTYPE token_value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();

 }
%union {
	  int token;
	  int token_type;
	  string* name;
	  struct Number number;
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
    struct Entry * entry;
    struct Mov {
      int assign_type;
      struct Entry * entry_to_assign;
      struct Entry * assigned_entry;
      vector<int> * assigned_entry_indexes;
      vector<int> * entry_to_assign_indexes;
    } mov;
    struct Mulop {
      struct Entry * entry1;
      struct Entry * entry2;
      struct Entry * result;
    } mulop;
    struct IntToReal {
      struct Entry * entry_to_convert;
      struct Entry * converted_entry;
    } int_to_real;
    struct RealToInt {
      struct Entry * entry_to_convert;
      struct Entry * converted_entry;
    } real_to_int;
    struct Or {
      struct Entry * entry1;
      struct Entry * entry2;
      struct Entry * result;
    } Or;
    struct Add{
      struct Entry * entry1;
      struct Entry * entry2;
      struct Entry * result;
    } add;
    struct Sub{
      struct Entry * entry1;
      struct Entry * entry2;
      struct Entry * result;
    } sub;
    struct  Function_Call{
      vector<Entry> * entries;
      struct Entry * entry;
    } function_call;
     struct Token_Identifier token_identifier;
     struct Jl {
       struct Entry * entry1;
       struct Entry * entry2;
     } jl;
     struct Je {
       struct Entry * entry1;
       struct Entry * entry2;
     } je;
     struct Write{
       struct Entry * entry_to_write;
     } write;
     struct Read {
       struct Entry * entry_to_read;
     } read;
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
%token <token_identifier> SIGN;
%token <token_identifier> ASSIGNOP;
%token <token_identifier> MULOP;
%token <token_identifier> RELOP;
%token <name> '(' ')' ';' '.' '[' ']' ':' '\n'
%token <name> START
%token <name> REAL_FUN
%token <name> INT_FUN
%token <name> PROC_CALL
%token <name> RETURN
%token <name> NEW_BLOCK
%token <name> PROC_CALL_WITH_ARGUMENTS
%token <name> FUNCTION_CALL
%token <name> MOV
%token <name> MULI
%token <name> MULR
%token <name> DIVI
%token <name> DIVR
%token <name> MOD
%token <name> ANDI
%token <name> ANDR
%token <name> INT_TO_REAL
%token <name> REAL_TO_INT
%token <name> ORI
%token <name> ORR
%token <name> ADDI
%token <name> ADDR
%token <name> SUBI
%token <name> SUBR
%token <name> JLI
%token <name> JLR
%token <name> JUMPI
%token <name> JEI
%token <name> JER
%token <name> WRITE
%token <name> READ
%type <entry> procedure_statement
%type <data_type> type
%type <standard_type> standard_type
%type <index> subprogram_head
%type <entries> expression_list
%type <entry> expression
%type <entry> variable
%type <entry> factor
%type <name> begin
%type <name> or
%type <name> While
%type <name> Do
%type <name> If
%type <name> Then
%type <name> Else
%type <entry> term
%type <entry> simple_expression
%destructor {} begin
%destructor {} or
%destructor {} While
%destructor {} Do
%destructor {} If
%destructor {} Then
%destructor {} Else
%{
  int last_parameter=-1;
  bool local_scope=false;
  int compound_statements_complexity=0;
  int current_block=-1;
  vector<int> current_while_blocks;
  int next_jump_block=0;
  int next_jl_block=0;
  int next_else_block=0;
  int current_array_index=-1;
  int current_register=-1;
  vector<Entry> current_expressions;
  vector<Entry> current_argument_entries;
  bool in_condition=false;
  bool in_then=false;
  bool in_do=false;
  int compound_ifs=0;
  int compound_whiles=0;
  bool is_in_read=false;
  bool is_in_write=false;
%}
%%


program: PROGRAM ID '(' input_output ')' ';' global_declarations subprogram_declarations compound_statement '.'   {
                                                                                                                    print_assembly(DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }

;
input_output: identifier_list {
                                  //current_identifiers_list.clear();
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
                                                                                    yyerror("Variable is already defined at this scope.\n");
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
      | ARR '[' NUM '.''.' NUM ']' OF standard_type	{
                                                      struct Type type;
                                                      type.standard_type=$9;
                                                      type.is_array=true;
                                                      struct Number first_index_NUM=$3;
                                                      struct Number last_index_NUM=$6;
                                                      if (first_index_NUM.type==REAL_TYPE || last_index_NUM.type==REAL_TYPE)
                                                        yyerror("The number of first and second indexes for array should be integer value");
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
                                              current_block=-1;
                                              print_assembly(RETURN,yylval);
                                             }

;

subprogram_head: FUN ID arguments ':' standard_type ';' {
                                                            string function_name=*$2;
                                                            vector<int> arguments_types;
                                                            vector<bool> is_array_arguments;
                                                            vector<int> arguments_arrays_sizes;
                                                            for (int argument_index : current_arguments_indexes){
                                                              arguments_types.push_back(entries_list.at(argument_index).data_type);
                                                              is_array_arguments.push_back(entries_list.at(argument_index).is_array_data_type);
                                                              arguments_arrays_sizes.push_back(entries_list.at(argument_index).last_index-entries_list.at(argument_index).first_index);
                                                            }
                                                            int p=find_procedure(function_name,arguments_types,is_array_arguments,arguments_arrays_sizes);
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
                                                            new_procedure.address=entries_list.at($$).addresses.at(0);
                                                            yylval.procedure=new_procedure;

                                                            local_scope=true;
                                                        }
                | PROC ID arguments ';'            {
                                                            string procedure_name=*$2;
                                                            vector<int> arguments_types;
                                                            vector<bool> is_array_arguments;
                                                            vector<int> arguments_arrays_sizes;
                                                            for (int argument_index : current_arguments_indexes){
                                                              arguments_types.push_back(entries_list.at(argument_index).data_type);
                                                              is_array_arguments.push_back(entries_list.at(argument_index).is_array_data_type);
                                                              arguments_arrays_sizes.push_back(entries_list.at(argument_index).last_index-entries_list.at(argument_index).first_index);
                                                            }
                                                            int p=find_procedure(procedure_name,arguments_types,is_array_arguments,arguments_arrays_sizes);
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
                                                            new_procedure.address=entries_list.at($$).addresses.at(0);
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
compound_statement:   begin
                      optional_statements
                      END               { }

;
begin:  BEG {
              current_block++;
              if (current_block>0)
                print_assembly(JUMPI,yylval);
              if (local_scope && current_block==0){
                struct Entry function=entries_list.at(current_procedure_index);
                struct Procedure procedure;
                procedure.name=new string(function.name);
                procedure.address=function.addresses.at(0);
                yylval.procedure=procedure;
                if (function.data_type==INT_TYPE)
                  print_assembly(INT_FUN,yylval);
                else if (function.data_type==REAL_TYPE)
                  print_assembly(REAL_FUN,yylval);
              }
              if (!local_scope || current_block>0)
                print_assembly(NEW_BLOCK,yylval);
            }

optional_statements:  statement_list {}
                    | {}
;
statement_list: statement {}
                | statement_list ';' statement {}

;

statement: variable ASSIGNOP expression		{
                                            struct Entry variable=*$1;
                                            struct Entry expression=*$3;
                                            yylval.mov.assign_type=VARIABLE_ASSIGN;
                                            if (expression.data_type!=variable.data_type){
                                                current_register++;
                                                if (expression.data_type==REAL_TYPE){
                                                  yylval.real_to_int.entry_to_convert=new Entry(expression);
                                                  string temporal_int_expression_name="$t"+to_string(current_register);
                                                  int temporal_int_expression_index=insert_variable(temporal_int_expression_name,INT_TYPE,
                                                    expression.is_array_data_type,expression.first_index,expression.last_index,TEMPORARY);
                                                  expression=entries_list.at(temporal_int_expression_index);
                                                  yylval.real_to_int.converted_entry=new Entry(expression);
                                                  print_assembly(REAL_TO_INT,yylval);
                                                } else if (expression.data_type==INT_TYPE){
                                                  yylval.int_to_real.entry_to_convert=new Entry(expression);
                                                  string temporal_real_expression_name="$t"+to_string(current_register);
                                                  int temporal_real_expression_index=insert_variable(temporal_real_expression_name,REAL_TYPE,
                                                    expression.is_array_data_type,expression.first_index,expression.last_index,TEMPORARY);
                                                  expression=entries_list.at(temporal_real_expression_index);
                                                  yylval.int_to_real.converted_entry=new Entry(expression);
                                                  print_assembly(INT_TO_REAL,yylval);
                                                } else {
                                                  yyerror("Wrong data type of expression or variable");
                                                }
                                              }
                                              yylval.mov.assigned_entry_indexes=new vector<int>();
                                              yylval.mov.entry_to_assign_indexes=new vector<int>();
                                              if (variable.is_array_data_type && variable.current_array_index==-1 &&
                                                expression.is_array_data_type && expression.current_array_index==-1 &&
                                                  variable.values.size()==expression.values.size()){
                                                    for (int i=0;i<variable.values.size();i++){
                                                      variable.values.at(i)=expression.values.at(i);
                                                      yylval.mov.assigned_entry_indexes->push_back(i);
                                                      yylval.mov.entry_to_assign_indexes->push_back(i);
                                                    }
                                              } else if (variable.is_array_data_type && variable.current_array_index!=-1 &&
                                                expression.is_array_data_type && expression.current_array_index!=-1){
                                                  int variable_current_array_index=variable.current_array_index;
                                                  int expression_current_array_index=expression.current_array_index;
                                                variable.values.at(variable_current_array_index)=expression.values.at(expression_current_array_index);
                                                yylval.mov.assigned_entry_indexes->push_back(variable_current_array_index);
                                                yylval.mov.entry_to_assign_indexes->push_back(expression.current_array_index);
                                              } else if (variable.is_array_data_type && variable.current_array_index!=-1 &&
                                                !(expression.is_array_data_type)){
                                                  int variable_current_array_index=variable.current_array_index;
                                                variable.values.at(variable_current_array_index)=expression.values.at(0);
                                                yylval.mov.assigned_entry_indexes->push_back(variable_current_array_index);
                                                yylval.mov.entry_to_assign_indexes->push_back(0);
                                              } else if (variable.is_array_data_type && variable.current_array_index==-1 && expression.is_array_data_type
                                                && expression.current_array_index!=-1){
                                                  int expression_current_array_index=expression.current_array_index;
                                                variable.values.at(0)=expression.values.at(expression_current_array_index);
                                                yylval.mov.assigned_entry_indexes->push_back(0);
                                                yylval.mov.entry_to_assign_indexes->push_back(expression_current_array_index);
                                              } else if (variable.is_array_data_type && variable.current_array_index==-1 && !expression.is_array_data_type
                                                || !(variable.is_array_data_type) && !(expression.is_array_data_type)){
                                                variable.values.at(0)=expression.values.at(0);
                                                yylval.mov.assigned_entry_indexes->push_back(0);
                                                yylval.mov.entry_to_assign_indexes->push_back(0);
                                              }
                                              yylval.mov.entry_to_assign=new Entry(expression);
                                              yylval.mov.assigned_entry=new Entry(variable);
                                              if (expression.token_type==VALUE)
                                                yylval.mov.assign_type=CONSTANT_ASSIGN;
                                              else
                                                yylval.mov.assign_type=VARIABLE_ASSIGN;
                                            print_assembly(MOV,yylval);
                                            if (in_then){
                                              next_jump_block=current_block+2;
                                              print_assembly(JUMPI,yylval);
                                            }
                                          }
          | procedure_statement {
                                  if (is_in_read || is_in_write){
                                    is_in_read=false;
                                    is_in_write=false;
                                  } else{
                                    struct Entry procedure=*$1;
                                    if (procedure.arguments_count==0){
                                        string procedure_name=procedure.name;
                                        struct Procedure called_procedure;
                                        called_procedure.name=new string(procedure_name);
                                        yylval.procedure=called_procedure;
                                        print_assembly(PROC_CALL,yylval);
                                    } else {
                                      yylval.entries=new vector<Entry>(current_argument_entries);
                                      print_assembly(PROC_CALL_WITH_ARGUMENTS,yylval);
                                    }
                                    if (in_then){
                                      next_jump_block=current_block+2;
                                      print_assembly(JUMPI,yylval);
                                    }
                                  }
                                }
          | compound_statement  {
                                    if (in_then){
                                      next_jump_block=current_block+2;
                                      print_assembly(JUMPI,yylval);
                                    }
                                }
          | If expression Then statement Else statement {
                                                            compound_ifs--;
                                                            if (in_then){
                                                              print_assembly(JUMPI,yylval);
                                                            } else if (compound_ifs==0){
                                                              current_block++;
                                                              print_assembly(NEW_BLOCK,yylval);
                                                            }
                                                        }
          | While expression Do statement               {
                                                          compound_whiles--;
                                                          if (in_then){
                                                            next_jump_block=current_block+2;
                                                            print_assembly(JUMPI,yylval);
                                                          } else if (in_do){
                                                            next_jump_block=current_while_blocks.back();
                                                            current_while_blocks.pop_back();
                                                            print_assembly(JUMPI,yylval);
                                                          } if (compound_whiles==0){
                                                            current_block++;
                                                            print_assembly(NEW_BLOCK,yylval);
                                                          }
                                                        }

;
If: IF  {
          in_condition=true;
          compound_ifs++;
         }
;
Then: THEN  {
              in_condition=false;
              in_then=true;
            }
;
Else: ELSE  {
              in_then=false;
              current_block++;
              print_assembly(NEW_BLOCK,yylval);
            }
;
While: WHILE  {
                in_condition=true;
                compound_whiles++;
                current_block++;
                current_while_blocks.push_back(current_block);
                print_assembly(NEW_BLOCK,yylval);
              }
;
Do: DO {
          in_condition=false;
          in_do=true;
        }
;

variable: ID	{
                  string variable_name=*$1;
                  int variable_index=-1;
                  int global_variable_index=-1;
                  if (local_scope){
                      int local_variable_index=find_local_variable(variable_name,current_procedure_index);
                      variable_index=local_variable_index;
                  }
                  if (variable_index==-1){
                    global_variable_index=find_global_variable(variable_name);
                    variable_index=global_variable_index;
                    if (variable_index==-1)
                      yyerror("Variable is not declared");
                  }

                  $$=new Entry(entries_list.at(variable_index));
				}
          | ID '[' expression ']'	{
                                    string variable_name=*$1;
                                    struct Entry array_index=*$3;
                                    int variable_index=-1;
                                    int global_variable_index=-1;
                                    if (local_scope){
                                        int local_variable_index=find_local_variable(variable_name,current_procedure_index);
                                        variable_index=local_variable_index;
                                    }
                                    if (variable_index==-1){
                                      global_variable_index=find_global_variable(variable_name);
                                      variable_index=global_variable_index;
                                      if (variable_index==-1)
                                        yyerror("Variable is not declared");
                                    }

                                    $$=new Entry(entries_list.at(variable_index));
                                    switch(array_index.token_type){
                                      case LOCAL_VARIABLE:
                                      case GLOBAL_VARIABLE:
                                      case PROCEDURE:
                                      case ARGUMENT:
                                      case TEMPORARY_VARIABLE:
                                      if (array_index.is_array_data_type){
                                        if (array_index.values.empty())
                                          yyerror("Variable is not initialized");
                                        if (array_index.values.at(0).integer<0 || array_index.values.at(0).integer>$$->last_index)
                                          yyerror("Array out of bounds.");
                                        $$->current_array_index=array_index.values.at(0).integer;
                                        break;
                                      }
                                      case VALUE:
                                        if (array_index.values.at(0).integer<0 || array_index.values.at(0).integer>$$->last_index)
                                          yyerror("Array out of bounds.");
                                        $$->current_array_index=array_index.values.at(0).integer;
                                        break;                                    
                                    }
									               }
;

procedure_statement: ID	{
                           string procedure_name=*$1;
							             int procedure_index=find_procedure(procedure_name,vector<int>(),VOID);
                           $$=new Entry(entries_list.at(procedure_index));
                           struct Procedure procedure;
                           procedure.name=$1;
                           procedure.address=entries_list.at(procedure_index).addresses.at(0);
                           yylval.procedure=procedure;
						            }
                     | ID '(' expression_list ')' {
                                                    string procedure_name=*$1;
                                                    if (procedure_name=="write"){
                                                      for (struct Entry variable_to_write: *$3){
                                                        yylval.write.entry_to_write=new Entry(variable_to_write);
                                                        print_assembly(WRITE,yylval);
                                                        is_in_write=true;
                                                      }
                                                    } else if (procedure_name=="read"){
                                                      for (struct Entry variable_to_read : *$3){
                                                        yylval.read.entry_to_read=new Entry(variable_to_read);
                                                        print_assembly(READ,yylval);
                                                        is_in_read=true;
                                                      }
                                                    } else{
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
                                                      current_argument_entries.insert(current_argument_entries.end(),expression_results.begin(),expression_results.end());
                                                      for (int i=0; i<current_argument_entries.size();i++)
                                                        current_argument_entries.at(i).local_variable_function_index=procedure_index;
                                                      $$=new Entry(entries_list.at(procedure_index));
                                                      struct Procedure procedure;
                                                      procedure.name=new string(procedure_name);
                                                      procedure.address=entries_list.at(procedure_index).addresses.at(0);
                                                      yylval.procedure=procedure;
                                                    }
												                          }

;

expression_list: expression {
                                struct Entry expression=*$1;
                                $$=new vector<Entry>();
                                $$->push_back(expression);
                             }
                | expression_list ',' expression  {
                                                    struct Entry expression=*$3;
                                                    $1->push_back(expression);
                                                      $$=$1;
                                                  }
;

expression: simple_expression {
                                $$=$1;
                                if (in_condition && $1->token_type!=VALUE){
                                  struct Entry entry1=*$1;
                                  struct Entry entry2;
                                  current_register++;
                                  string temporal_variable_name="$t"+to_string(current_register);
                                  int temporal_variable_index=insert_variable(temporal_variable_name,entry1.data_type,false,0,0,TEMPORARY);
                                  entry2=entries_list.at(temporal_variable_index);
                                  entry2.token_type=VALUE;
                                  printf("Temporal variable: %s\n",entry2.name.c_str());
                                  yylval.mov.assigned_entry=$$;
                                  struct Entry relop_value;
                                  relop_value.data_type=$$->data_type;
                                  relop_value.token_type=VALUE;
                                  relop_value.is_array_data_type=false;
                                  relop_value.first_index=0;
                                  relop_value.last_index=0;
                                  struct Number value;
                                  if ($$->data_type==INT_TYPE){
                                    yylval.jl.entry1=new Entry(entry1);
                                    yylval.jl.entry2=new Entry(entry2);
                                    next_jl_block=current_block+1;
                                    print_assembly(JLI,yylval);
                                    value.type=INT_TYPE;
                                    value.integer=0;
                                    relop_value.values.push_back(value);
                                    yylval.mov.entry_to_assign=new Entry(relop_value);
                                    yylval.mov.assign_type=CONSTANT_ASSIGN;
                                    print_assembly(MOV,yylval);
                                    next_jump_block=current_block+2;
                                    print_assembly(JUMPI,yylval);
                                    current_block++;
                                    print_assembly(NEW_BLOCK,yylval);
                                    relop_value.values.at(0).integer=1;
                                    yylval.mov.entry_to_assign=new Entry(relop_value);
                                    print_assembly(MOV,yylval);
                                    current_block++;
                                    print_assembly(NEW_BLOCK,yylval);
                                    relop_value.values.at(0).integer=0;
                                  } else if ($$->data_type==REAL_TYPE){
                                    yylval.jl.entry1=new Entry(entry1);
                                    yylval.jl.entry2=new Entry(entry2);
                                    next_jl_block=current_block+1;
                                    print_assembly(JLR,yylval);
                                    value.type=REAL_TYPE;
                                    value.real=0.0;
                                    relop_value.values.push_back(value);
                                    yylval.mov.entry_to_assign=new Entry(relop_value);
                                    yylval.mov.assign_type=CONSTANT_ASSIGN;
                                    print_assembly(MOV,yylval);
                                    next_jump_block=current_block+2;
                                    print_assembly(JUMPI,yylval);
                                    current_block++;
                                    print_assembly(NEW_BLOCK,yylval);
                                    relop_value.values.at(0).real=1.0;
                                    yylval.mov.entry_to_assign=new Entry(relop_value);
                                    print_assembly(MOV,yylval);
                                    current_block++;
                                    print_assembly(NEW_BLOCK,yylval);
                                    relop_value.values.at(0).real=0.0;
                                  }
                                  yylval.je.entry2=new Entry(relop_value);
                                  yylval.je.entry1=$$;
                                  next_else_block=current_block+1;
                                  if (entry1.data_type==INT_TYPE)
                                    print_assembly(JEI,yylval);
                                  else if (entry1.data_type==REAL_TYPE)
                                    print_assembly(JER,yylval);
                                }
                              }
            | simple_expression RELOP simple_expression {
                                                          struct Entry entry1=*$1;
                                                          struct Entry entry2=*$3;
                                                          entry1=convert_entry(entry1);
                                                          entry2=convert_entry(entry2);
                                                          entry2=convert_entries(entry1,entry2);
                                                          current_register++;
                                                          string temporal_variable_name="$t"+to_string(current_register);
                                                          int temporal_variable_index=insert_variable(temporal_variable_name, entry1.data_type,false,0,0,TEMPORARY);
                                                          $$=new Entry(entries_list.at(temporal_variable_index));
                                                          yylval.mov.assigned_entry=$$;
                                                          yylval.mov.assigned_entry_indexes=new vector<int>();
                                                          yylval.mov.assigned_entry_indexes->push_back(0);
                                                          struct Entry relop_value;
                                                          relop_value.data_type=$$->data_type;
                                                          relop_value.token_type=VALUE;
                                                          relop_value.is_array_data_type=false;
                                                          relop_value.first_index=0;
                                                          relop_value.last_index=0;
                                                          struct Number value;
                                                          if ($$->data_type==INT_TYPE){
                                                            yylval.jl.entry1=new Entry(entry1);
                                                            yylval.jl.entry2=new Entry(entry2);
                                                            next_jl_block=current_block+1;
                                                            print_assembly(JLI,yylval);
                                                            value.type=INT_TYPE;
                                                            value.integer=0;
                                                            relop_value.values.push_back(value);
                                                            yylval.mov.entry_to_assign=new Entry(relop_value);
                                                            yylval.mov.assign_type=CONSTANT_ASSIGN;
                                                            print_assembly(MOV,yylval);
                                                            next_jump_block=current_block+2;
                                                            print_assembly(JUMPI,yylval);
                                                            current_block++;
                                                            print_assembly(NEW_BLOCK,yylval);
                                                            relop_value.values.at(0).integer=1;
                                                            yylval.mov.entry_to_assign=new Entry(relop_value);
                                                            print_assembly(MOV,yylval);
                                                            current_block++;
                                                            print_assembly(NEW_BLOCK,yylval);
                                                            relop_value.values.at(0).integer=0;
                                                          } else if ($$->data_type==REAL_TYPE){
                                                            yylval.jl.entry1=new Entry(entry1);
                                                            yylval.jl.entry2=new Entry(entry2);
                                                            next_jl_block=current_block+1;
                                                            print_assembly(JLR,yylval);
                                                            value.type=REAL_TYPE;
                                                            value.integer=0;
                                                            relop_value.values.push_back(value);
                                                            yylval.mov.entry_to_assign=new Entry(relop_value);
                                                            yylval.mov.assign_type=CONSTANT_ASSIGN;
                                                            print_assembly(MOV,yylval);
                                                            next_jump_block+2;
                                                            print_assembly(JUMPI,yylval);
                                                            current_block++;
                                                            print_assembly(NEW_BLOCK,yylval);
                                                            relop_value.values.at(0).integer=1;
                                                            yylval.mov.entry_to_assign=new Entry(relop_value);
                                                            print_assembly(MOV,yylval);
                                                            current_block++;
                                                            print_assembly(NEW_BLOCK,yylval);
                                                            relop_value.values.at(0).real=0.0;
                                                        }
                                                        if (in_condition && entry1.token_type!=VALUE && entry2.token_type!=VALUE){
                                                          yylval.je.entry2=new Entry(relop_value);
                                                          yylval.je.entry1=$$;
                                                          next_else_block=current_block+1;
                                                          if (entry1.data_type==INT_TYPE)
                                                            print_assembly(JEI,yylval);
                                                          else if (entry1.data_type==REAL_TYPE)
                                                            print_assembly(JER,yylval);
                                                        }
                                                        printf("Temporal variable: %s\n",$$->name.c_str());
                                                        current_register--;
                                                      }
;

simple_expression: term { $$=$1; }
                  | SIGN term {
                                struct Entry entry=*$2;
                                struct Token_Identifier sign_struct;
                                string sign=*(sign_struct.name);
                                entry=convert_entry(entry);
                                if (sign.compare("-")==0){
                                  for (int i=0;i<entry.values.size();i++){
                                    if (entry.data_type==INT_TYPE)
                                      entry.values.at(i).integer=-entry.values.at(i).integer;
                                    else if (entry.data_type==REAL_TYPE)
                                      entry.values.at(i).real=-entry.values.at(i).real;
                                    }
                                    current_register++;
                                    string temporal_variable_name="$t"+to_string(current_register);
                                    int temporal_variable_index=insert_variable(temporal_variable_name,entry.data_type,
                                      entry.is_array_data_type,entry.first_index,entry.last_index,TEMPORARY);
                                    for (int i=0;i<entry.values.size();i++)
                                      entries_list.at(temporal_variable_index).values.at(i)=entry.values.at(i);
                                    entry=entries_list.at(temporal_variable_index);
                                    printf("Temporal variable: %s\n",entry.name.c_str());
                                    yylval.mov.entry_to_assign=$2;
                                    yylval.mov.assigned_entry=new Entry(entry);
                                    yylval.mov.assign_type=(entry.token_type==VALUE) ? CONSTANT_ASSIGN : VARIABLE_ASSIGN;
                                    print_assembly(MOV,yylval);
                                    current_register--;
                                }
                                $$=new Entry(entry);
                              }
                  | simple_expression SIGN term {
                                                  struct Entry entry1=*$1;
                                                  struct Entry entry2=*$3;
                                                  entry1=convert_entry(entry1);
                                                  entry2=convert_entry(entry2);
                                                  entry2=convert_entries(entry1,entry2);
                                                  current_register++;
                                                  struct Token_Identifier sign_struct=$2;
                                                  string sign=*(sign_struct.name);
                                                  string temporal_variable_name="$t"+to_string(current_register);
                                                  int temporal_variable_index=insert_variable(temporal_variable_name,entry1.data_type,false,0,0,TEMPORARY);
                                                  printf("Temporal variable: %s\n",entries_list.at(temporal_variable_index).name.c_str());
                                                  $$=new Entry(entries_list.at(temporal_variable_index));
                                                  if ((sign).compare("+")==0){
                                                    if (entry1.data_type==INT_TYPE){
                                                      $$->values.at(0).integer=entry1.values.at(0).integer+entry2.values.at(0).integer;
                                                      yylval.add.entry1=new Entry(entry1);
                                                      yylval.add.entry2=new Entry(entry2);
                                                      yylval.add.result=$$;
                                                      print_assembly(ADDI,yylval);
                                                    } else if (entry1.data_type==REAL_TYPE){
                                                      $$->values.at(0).real=entry1.values.at(0).real+entry2.values.at(0).real;
                                                      yylval.add.entry1=new Entry(entry1);
                                                      yylval.add.entry2=new Entry(entry2);
                                                      yylval.add.result=$$;
                                                      print_assembly(ADDR,yylval);
                                                    }
                                                  } else if ((sign).compare("-")==0){
                                                    if (entry1.data_type==INT_TYPE){
                                                      $$->values.at(0).integer=entry1.values.at(0).integer-entry2.values.at(0).integer;
                                                      yylval.sub.entry1=new Entry(entry1);
                                                      yylval.sub.entry2=new Entry(entry2);
                                                      yylval.sub.result=$$;
                                                      print_assembly(SUBI,yylval);
                                                    } else if (entry1.data_type==REAL_TYPE){
                                                      $$->values.at(0).real=entry1.values.at(0).real-entry2.values.at(0).real;
                                                      yylval.sub.entry1=new Entry(entry1);
                                                      yylval.sub.entry2=new Entry(entry2);
                                                      yylval.sub.result=$$;
                                                      print_assembly(SUBR,yylval);
                                                    }
                                                  }
                                                  current_register--;
                                                }
                  | simple_expression or term {
                                                struct Entry entry1=*$1;
                                                struct Entry entry2=*$3;
                                                entry2=convert_entries(entry1,entry2);
                                                yylval.Or.entry1=new Entry(entry1);
                                                yylval.Or.entry2=new Entry(entry2);
                                                if (entry1.data_type==INT_TYPE){
                                                  current_register++;
                                                  string temporal_variable_name="$t"+to_string(current_register);
                                                  int temporal_variable_index=insert_variable(temporal_variable_name,INT_TYPE,false,0,0,TEMPORARY);
                                                  $$=new Entry(entries_list.at(temporal_variable_index));
                                                  $$->values.at(0).integer=(entry1.values.at(0).integer==0 && entry2.values.at(0).integer==0) ? 0 : 1;
                                                  yylval.Or.result=$$;
                                                  print_assembly(ORI,yylval);
                                                  printf("Temporal variable: %s\n",$$->name.c_str());
                                                  current_register--;
                                                } else if (entry2.data_type==REAL_TYPE){
                                                  current_register++;
                                                  string temporal_variable_name="$t"+to_string(current_register);
                                                  int temporal_variable_index=insert_variable(temporal_variable_name,INT_TYPE,false,0,0,TEMPORARY);
                                                  $$=new Entry(entries_list.at(temporal_variable_index));
                                                  $$->values.at(0).real=(entry1.values.at(0).real==0.0 && entry2.values.at(0).real==0.0) ? 0.0 : 1.0;
                                                  yylval.Or.result=$$;
                                                  print_assembly(ORR,yylval);
                                                  printf("Temporal variable: %s\n",$$->name.c_str());
                                                  current_register--;
                                                } else {
                                                  current_register--;
                                                  yyerror("Not identified type of variables");
                                                }
                                              }

;

or: OR
;
term: factor  { $$=$1; }
      | term MULOP factor  {
                              struct Entry entry1=*$1;
                              struct Entry entry2=*$3;
                              entry1=convert_entry(entry1);
                              entry2=convert_entry(entry2);
                              entry2=convert_entries(entry1,entry2);
                              string mulop_variable_name="$t"+to_string(current_register);
                              yylval.mulop.entry1=new Entry(entry1);
                              yylval.mulop.entry2=new Entry(entry2);
                              struct Token_Identifier mulop_struct=$2;
                              string mulop=*(mulop_struct.name);
                              if (entry1.data_type==INT_TYPE){
                                current_register++;
                                int mulop_expression_int_index=insert_variable(mulop_variable_name,INT_TYPE,false,0,0,TEMPORARY);
                                $$=new Entry(entries_list.at(mulop_expression_int_index));
                                printf("Temporal variable: %s\n",$$->name.c_str());
                                if (mulop.compare("*")==0){
                                    $$->values.at(0).integer=entry1.values.at(0).integer * entry2.values.at(0).integer;
                                    yylval.mulop.result=$$;
                                    print_assembly(MULI,yylval);
                                } else if (mulop.compare("/")==0 || mulop.compare("div")==0){
                                    if (entry2.values.at(0).integer==0){
                                      current_register--;
                                      yyerror("Division by 0");
                                    }
                                    $$->values.at(0).integer=entry1.values.at(0).integer / entry2.values.at(0).integer;
                                    yylval.mulop.result=$$;
                                    print_assembly(DIVI,yylval);
                                    break;
                                  }else if (mulop.compare("mod")==0){
                                    if (entry2.values.at(0).integer==0){
                                      current_register--;
                                      yyerror("Mod by 0");
                                    }
                                    $$->values.at(0).integer=entry1.values.at(0).integer % entry2.values.at(0).integer;
                                    yylval.mulop.result=$$;
                                    print_assembly(MOD,yylval);
                                  }else if (mulop.compare("and")==0){
                                  if (entry1.values.at(0).integer==0 || entry2.values.at(0).integer==0)
                                        $$->values.at(0).integer=0;
                                    else
                                        $$->values.at(0).integer==1;
                                    yylval.mulop.result=$$;
                                    print_assembly(ANDI,yylval);
                                  }
                                 } else if (entry1.data_type==REAL_TYPE){
                                   int mulop_real_expression_index=insert_variable(mulop_variable_name,REAL_TYPE,false,0,0,TEMPORARY);
                                   $$=new Entry(entries_list.at(mulop_real_expression_index));
                                   printf("Temporal variable: %s\n",$$->name.c_str());
                                   if (mulop.compare("*")==0){
                                      $$->values.at(0).real=entry1.values.at(0).real * entry2.values.at(0).real;
                                      yylval.mulop.result=$$;
                                      print_assembly(MULR,yylval);
                                  } else if (mulop.compare("/")==0){
                                      $$->values.at(0).real=entry1.values.at(0).real * entry2.values.at(0).real;
                                      yylval.mulop.result=$$;
                                      print_assembly(DIVR,yylval);
                                  } else if (mulop.compare("div")==0){
                                      $$->values.at(0).integer=(int)(entry1.values.at(0).real)/(int)(entry2.values.at(0).real);
                                      yylval.mulop.result=$$;
                                      print_assembly(DIVI,yylval);
                                  } else if (mulop.compare("and")==0){
                                     if (entry1.values.at(0).real==0.0 || entry2.values.at(0).real==0.0)
                                           $$->values.at(0).real=0.0;
                                       else
                                           $$->values.at(0).real==1.0;
                                       yylval.mulop.result=$$;
                                       print_assembly(ANDR,yylval);
                                  } else {
                                      current_register--;
                                      yyerror("Undefined operator");
                                    }
                                 }
                                 else {
                                   current_register--;
                                   yyerror("Data type of variables is undefined");
                                 }
                                 current_register--;
                           }


;

factor: variable  { $$=$1; }
        |  ID '(' expression_list ')' {
                                          string function_name=*$1;
                                          vector<int> arguments_types;
                                          vector<bool> is_array_arguments;
                                          vector<int> array_sizes;
                                          vector<Entry> potential_arguments;
                                          for(struct Entry potential_argument : *$3){
                                            arguments_types.push_back(potential_argument.data_type);
                                            is_array_arguments.push_back(potential_argument.is_array_data_type);
                                            array_sizes.push_back(potential_argument.last_index-potential_argument.first_index);
                                            potential_arguments.push_back(potential_argument);
                                          }
                                          int function_index=find_procedure(function_name,arguments_types,is_array_arguments,array_sizes);
                                          if (function_index==-1)
                                            yyerror("The function is undefined (first declared).");
                                          $$=new Entry(entries_list.at(function_index));
                                          yylval.function_call.entries=new vector<Entry>(potential_arguments);
                                          yylval.function_call.entry=$$;
                                          print_assembly(FUNCTION_CALL,yylval);
                                      }

        | NUM     {
                    struct Entry constant;
                    struct Number constant_value=$1;
                    constant.token_type=VALUE;
                    constant.data_type=constant_value.type;
                    constant.is_array_data_type=false;
                    constant.first_index=0;
                    constant.last_index=0;
                    constant.current_array_index=-1;
                    if (constant.data_type==INT_TYPE || constant.data_type==REAL_TYPE)
                      constant.values.push_back(constant_value);
                    else
                      yyerror("Undefined data type");
                    $$=new Entry(constant);
                  }
        | '(' expression ')' {
                                current_register++;
                                string temporal_variable_name="$t"+current_register;
                                int temporal_variable_index=insert_variable(temporal_variable_name, ($2->token_type==VALUE) ? $2->values.at(0).type : $2->data_type,
                                  $2->is_array_data_type,$2->first_index,$2->last_index,TEMPORARY);
                                printf("Temporal variable: %s\n",temporal_variable_name.c_str());
                                $$=new Entry(entries_list.at(temporal_variable_index));
                                current_register--;
                              }
        | NOT factor  {
                        struct Entry factor_to_negate=*$2;
                        yylval.mov.assigned_entry_indexes=new vector<int>();
                        current_register++;
                        if (factor_to_negate.data_type==INT_TYPE){
                          if (factor_to_negate.current_array_index!=-1 && factor_to_negate.is_array_data_type){
                            factor_to_negate.values.at(current_array_index).integer=
                              (factor_to_negate.values.at(current_array_index).integer==0) ? 1 : 0;
                              yylval.mov.assigned_entry_indexes->push_back(factor_to_negate.current_array_index);
                            }else{
                            factor_to_negate.values.at(0).integer = (factor_to_negate.values.at(0).integer==0) ? 1 : 0;
                            yylval.mov.assigned_entry_indexes->push_back(0);
                          }
                        } else if (factor_to_negate.data_type==REAL_TYPE){
                          if (factor_to_negate.current_array_index!=-1 && factor_to_negate.is_array_data_type){
                            factor_to_negate.values.at(current_array_index).real=
                              (factor_to_negate.values.at(current_array_index).real==0.0) ? 1.0 : 0.0;
                              yylval.mov.assigned_entry_indexes->push_back(factor_to_negate.current_array_index);
                          } else
                            factor_to_negate.values.at(0).real = (factor_to_negate.values.at(0).real==0.0) ? 1.0 : 0.0;
                            yylval.mov.assigned_entry_indexes->push_back(0);
                        } else
                            yyerror("Undefined data type");
                        string temporal_variable_name="$t"+to_string(current_register);
                        int negated_factor_index=insert_variable(temporal_variable_name,factor_to_negate.data_type,
                            factor_to_negate.is_array_data_type,factor_to_negate.first_index,factor_to_negate.last_index,TEMPORARY);
                        for (int current_value_index=factor_to_negate.first_index; current_value_index<=factor_to_negate.last_index;current_value_index++){
                          entries_list.at(negated_factor_index).values.at(current_value_index)=factor_to_negate.values.at(current_value_index);
                          current_value_index++;
                        }
                        struct Entry negated_factor=entries_list.at(negated_factor_index);
                        printf("Temporal variable: %s\n",temporal_variable_name.c_str());
                        switch (factor_to_negate.data_type){
                          case LOCAL_VARIABLE:
                          case GLOBAL_VARIABLE:
                          case PROCEDURE:
                          case TEMPORARY_VARIABLE:
                            yylval.mov.assign_type=VARIABLE_ASSIGN;
                          case VALUE:
                            yylval.mov.assign_type=CONSTANT_ASSIGN;
                        }
                        yylval.mov.assigned_entry=new Entry(negated_factor);
                        yylval.mov.entry_to_assign=new Entry(factor_to_negate);
                        print_assembly(MOV,yylval);
                        current_register--;
                        $$=new Entry(negated_factor);
                        $$->current_array_index=factor_to_negate.current_array_index;
                      }
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
  if (token==WRITE){
    struct Entry entry=*(token_value.write.entry_to_write);
    if (entry.token_type==PROCEDURE && entry.data_type==VOID){
      yyerror("Cannot write void procedure");
    }
    fprintf(yyout,"\t\twrite");
    if (entry.token_type==VALUE){
      if (entry.data_type==INT_TYPE)
        fprintf(yyout,".i\t#%d\n",entry.values.at(0).integer);
      else if (entry.data_type==REAL_TYPE)
        fprintf(yyout,".r\t#%f\n",entry.values.at(0).real);
    } else if (entry.is_array_data_type && entry.current_array_index!=-1){
      if (entry.data_type==INT_TYPE)
        fprintf(yyout,".i\t%d\n",entry.addresses.at(entry.current_array_index));
      else if (entry.data_type==REAL_TYPE)
        fprintf(yyout,".r\t%d\n",entry.addresses.at(entry.current_array_index));
    } else {
      if (entry.data_type==INT_TYPE)
        fprintf(yyout,".i\t%d\n",entry.addresses.at(0));
      else if (entry.data_type==REAL_TYPE)
        fprintf(yyout,".r\t%d\n",entry.addresses.at(0));
    }
  } else if(token==READ){
      struct Entry entry=*(token_value.read.entry_to_read);
      if (entry.token_type==VALUE || entry.token_type==PROCEDURE && entry.data_type==VOID ){
        yyerror("Cannot read value or void procedure.");
      }
      fprintf(yyout,"\t\tread");
      if (entry.is_array_data_type && entry.current_array_index!=-1){
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,".i\t%d\n",entry.addresses.at(entry.current_array_index));
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,".r\t%d\n",entry.addresses.at(entry.current_array_index));
      } else {
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,".i\t%d\n",entry.addresses.at(0));
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,".r\t%d\n",entry.addresses.at(0));
      }
  }else if (token==MOV){
    vector<int> assigned_entry_indexes=*(token_value.mov.assigned_entry_indexes);
      if (token_value.mov.assign_type==CONSTANT_ASSIGN){
        for (int i=0;i<assigned_entry_indexes.size();i++){
          if (token_value.mov.assigned_entry->data_type==INT_TYPE){
            fprintf(yyout,"\t\tmov.i\t%d, #%d\n",token_value.mov.assigned_entry->addresses.at(assigned_entry_indexes.at(i)),
              yylval.mov.entry_to_assign->values.at(0).integer);
          } else if (token_value.mov.assigned_entry->data_type==REAL_TYPE){
            fprintf(yyout,"\t\tmov.r\t%d, #%f\n",token_value.mov.assigned_entry->addresses.at(assigned_entry_indexes.at(i)),
              token_value.mov.entry_to_assign->values.at(0).real);
          }
        }
      }else if (token_value.mov.assign_type==VARIABLE_ASSIGN){
        vector<int> entry_to_assign_indexes=*(token_value.mov.entry_to_assign_indexes);
         for (int i=0,j=0;i<assigned_entry_indexes.size(),j<entry_to_assign_indexes.size();i++,j++){
           if (token_value.mov.assigned_entry->data_type==INT_TYPE){
             fprintf(yyout,"\t\tmov.i\t%d, %d\n",token_value.mov.assigned_entry->addresses.at(assigned_entry_indexes.at(i)),
              token_value.mov.entry_to_assign->addresses.at(entry_to_assign_indexes.at(j)));
           } else if (yylval.mov.assigned_entry->data_type==REAL_TYPE){
             fprintf(yyout,"\t\tmov.r\t%d, %d\n",token_value.mov.assigned_entry->addresses.at(assigned_entry_indexes.at(i)),
              token_value.mov.entry_to_assign->addresses.at(entry_to_assign_indexes.at(j)));
           }
         }
       }
  }else if (token==JLI){
    if(token_value.jl.entry1->token_type==VALUE){
      fprintf(yyout,"\t\tjl.i\t%d, ", token_value.jl.entry1->values.at(0).integer);
    }else
      fprintf(yyout,"\t\tjl.i\t%d, ", token_value.jl.entry1->addresses.at(0));
    if(token_value.jl.entry2->token_type==VALUE){
      fprintf(yyout,"%d, ", token_value.jl.entry2->values.at(0).integer);
    }else
      fprintf(yyout,"%d, ", token_value.jl.entry2->addresses.at(0));
    if (local_scope){
      fprintf(yyout,"#%s%d\n",entries_list.at(current_procedure_index).name.c_str(),next_jl_block);
    } else
      fprintf(yyout,"#lab%d\n",next_jl_block);
  }else if (token==JLR){
    if(token_value.jl.entry1->token_type==VALUE){
      fprintf(yyout,"\t\tjl.r\t#%f, ", token_value.jl.entry1->values.at(0).real);
    }else
      fprintf(yyout,"\t\tjl.r\t%d, ", token_value.jl.entry1->addresses.at(0));
    if(token_value.jl.entry2->token_type==VALUE){
      fprintf(yyout,"#%f, ", token_value.jl.entry2->values.at(0).real);
    }else
      fprintf(yyout,"%d, ", token_value.jl.entry2->addresses.at(0));
    if (local_scope){
      fprintf(yyout,"#%s%d\n",entries_list.at(current_procedure_index).name.c_str(),next_jl_block);
    } else
      fprintf(yyout,"#lab%d\n",next_jl_block);
  }else if (token==JER){
    if(token_value.je.entry1->token_type==VALUE){
      fprintf(yyout,"\t\tje.r\t#%f, ", token_value.je.entry1->values.at(0).real);
    }else
      fprintf(yyout,"\t\tje.r\t%d, ", token_value.je.entry1->addresses.at(0));
    if(token_value.je.entry2->token_type==VALUE){
      fprintf(yyout,"#%f, ", token_value.je.entry2->values.at(0).real);
    }else
      fprintf(yyout,"%d, ", token_value.je.entry2->addresses.at(0));
    if (local_scope){
      fprintf(yyout,"#%s%d\n",entries_list.at(current_procedure_index).name.c_str(),next_else_block);
    } else
      fprintf(yyout,"#lab%d\n",next_else_block);
  }else if (token==JEI){
    if(token_value.je.entry1->token_type==VALUE){
      fprintf(yyout,"\t\tje.i\t#%d, ", token_value.je.entry1->values.at(0).integer);
    }else
      fprintf(yyout,"\t\tje.i\t%d, ", token_value.je.entry1->addresses.at(0));
    if(token_value.je.entry2->token_type==VALUE){
      fprintf(yyout,"#%d, ", token_value.je.entry2->values.at(0).integer);
    }else
      fprintf(yyout,"%d, ", token_value.je.entry2->addresses.at(0));
    if (local_scope){
      fprintf(yyout,"#%s%d\n",entries_list.at(current_procedure_index).name.c_str(),next_else_block);
    } else
      fprintf(yyout,"#lab%d\n",next_else_block);
  }else if(token==JUMPI){
    if (local_scope)
      fprintf(yyout,"\t\tjump.i\t#%s%d\n",entries_list.at(current_procedure_index).name.c_str(),next_jump_block);
    else
      fprintf(yyout,"\t\tjump.i\t#lab%d\n",next_jump_block);
  }else if (token==INT_TO_REAL){
    if (token_value.int_to_real.entry_to_convert->token_type==VALUE)
      fprintf(yyout, "\t\tinttoreal.i\t%d, #%d\n",token_value.int_to_real.converted_entry->addresses.at(0),token_value.int_to_real.entry_to_convert->values.at(0).integer);
    else
      fprintf(yyout,"\t\tinttoreal.i\t%d, %d\n",token_value.int_to_real.converted_entry->addresses.at(0),token_value.int_to_real.entry_to_convert->addresses.at(0));
  } else if (token==REAL_TO_INT){
    if (token_value.int_to_real.entry_to_convert->token_type==VALUE)
      fprintf(yyout, "\t\trealtoint.r\t%d, #%f\n",token_value.int_to_real.converted_entry->addresses.at(0),token_value.int_to_real.entry_to_convert->values.at(0).real);
    else
      fprintf(yyout,"\t\trealtoint.i\t%d, %d\n",token_value.int_to_real.converted_entry->addresses.at(0),token_value.int_to_real.entry_to_convert->addresses.at(0));
  }else if(token==MULI){
      fprintf(yyout,"\t\tmul.i\t%d, ",token_value.mulop.result->addresses.at(0));
      if (token_value.add.entry1->token_type==VALUE){
        fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
      } else if (token_value.add.entry1->token_type!=VALUE){
        fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
      } if (token_value.add.entry2->token_type==VALUE){
        fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
      } else  if (token_value.add.entry2->token_type!=VALUE){
        fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
      }
  } else if (token==DIVI){
    fprintf(yyout,"\t\tdiv.i\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    } if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==MOD){
    fprintf(yyout,"\t\tmod.i\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    } if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==ANDI){
    fprintf(yyout,"\t\tand.i\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    } if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==MULR){
    fprintf(yyout,"\t\tmul.r\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%f, ",token_value.add.entry1->values.at(0).real);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    }if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%f\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if(token==DIVR){
    fprintf(yyout,"\t\tdiv.r\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%f, ",token_value.add.entry1->values.at(0).real);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    }if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%f\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if(token==ANDR){
    fprintf(yyout,"\t\tand.r\t%d, ",token_value.mulop.result->addresses.at(0));
    if (token_value.mulop.entry1->token_type==VALUE){
      fprintf(yyout,"#%f, ",token_value.mulop.entry1->values.at(0).real);
    }else
      fprintf(yyout,"%d, ",token_value.mulop.entry1->addresses.at(0));
    if (token_value.mulop.entry2->token_type==VALUE){
      fprintf(yyout,"#%f\n",token_value.mulop.entry2->values.at(0).real);
    }else
      fprintf(yyout,"%d\n",token_value.mulop.entry2->addresses.at(0));
  } else if (token==ORI){
    fprintf(yyout,"\t\tor.i\t%d, ",token_value.Or.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    } if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==ORR){
    fprintf(yyout,"\t\tor.r\t%d, ",token_value.Or.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%f, ",token_value.add.entry1->values.at(0).real);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    }if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%f\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==ADDI){
    fprintf(yyout,"\t\tadd.i\t%d, ",token_value.add.result->addresses.at(0));
      if (token_value.add.entry1->token_type==VALUE){
        fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
      } else if (token_value.add.entry1->token_type!=VALUE){
        fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
      } if (token_value.add.entry2->token_type==VALUE){
        fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
      } else  if (token_value.add.entry2->token_type!=VALUE){
        fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
      }
  } else if (token==ADDR){
    fprintf(yyout,"\t\tadd.r\t%d, ",token_value.add.result->addresses.at(0));
      if (token_value.add.entry1->token_type==VALUE){
        fprintf(yyout,"#%f, ",token_value.add.entry1->values.at(0).real);
      } else if (token_value.add.entry1->token_type!=VALUE){
        fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
      }if (token_value.add.entry2->token_type==VALUE){
        fprintf(yyout, "#%f\n", token_value.add.entry2->values.at(0).integer);
      } else  if (token_value.add.entry2->token_type!=VALUE){
        fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
      }
  } else if (token==SUBI){
    fprintf(yyout,"\t\tsub.i\t%d, ",token_value.sub.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%d, ",token_value.add.entry1->values.at(0).integer);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    } if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%d\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
  } else if (token==SUBR){
    fprintf(yyout,"\t\tsub.r\t%d, ",token_value.sub.result->addresses.at(0));
    if (token_value.add.entry1->token_type==VALUE){
      fprintf(yyout,"#%f, ",token_value.add.entry1->values.at(0).real);
    } else if (token_value.add.entry1->token_type!=VALUE){
      fprintf(yyout,"%d, ", token_value.add.entry1->addresses.at(0));
    }if (token_value.add.entry2->token_type==VALUE){
      fprintf(yyout, "#%f\n", token_value.add.entry2->values.at(0).integer);
    } else  if (token_value.add.entry2->token_type!=VALUE){
      fprintf(yyout,"%d\n",token_value.add.entry2->addresses.at(0));
    }
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
    fprintf(yyout,"\t\tcall\t#%s\n",procedure_name.c_str());
  } else if (token==PROC_CALL_WITH_ARGUMENTS){
    vector<Entry> entries=*(token_value.entries);
    for (struct Entry entry: entries){
      if (entry.token_type==VALUE){
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,"\t\tpush.i\t#%d\n",entry.values.at(0).integer);
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,"\t\tpush.r\t#%f\n",entry.values.at(0).real);
      }else {
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,"\t\tpush.i\t#%d\n",entry.addresses.at(0));
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,"\t\tpush.r\t#%d\n",entry.addresses.at(0));
      }
    }
    fprintf(yyout,"\t\tcall\t#%s\n",entries_list.at(entries.at(0).local_variable_function_index).name.c_str());
    token_value.entries->clear();
  }else if (token==FUNCTION_CALL){
    vector<Entry> entries=*(token_value.entries);
    for (struct Entry entry: entries){
      if (entry.token_type==VALUE){
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,"\t\tpush.i\t#%d\n",entry.values.at(0));
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,"\t\tpush.r\t#%f\n",entry.values.at(0));
      }else {
        if (entry.data_type==INT_TYPE)
          fprintf(yyout,"\t\tpush.i\t#%d\n",entry.addresses.at(0));
        else if (entry.data_type==REAL_TYPE)
          fprintf(yyout,"\t\tpush.r\t#%d\n",entry.addresses.at(0));
      }
    }
    struct Entry function=*(yylval.function_call.entry);
    switch (function.data_type){
      case INT_TYPE:
        fprintf(yyout,"\t\tcall.i\t#%s\n",function.name.c_str());
        fprintf(yyout,"\t\tincsp.i\t#%d\n",function.addresses.at(0));
        break;
      case REAL_TYPE:
        fprintf(yyout,"\t\tcall.r\t#%s\n",function.name.c_str());
        fprintf(yyout,"\t\tincsp.r\t#%d\t",function.addresses.at(0));
        break;
    }
  }else if (token==RETURN){
    fprintf(yyout,"\t\tleave\n\t\treturn\n");
  }else if(token==NEW_BLOCK){
    if (local_scope)
      fprintf(yyout,"%s%d:\n",entries_list.at(current_procedure_index).name.c_str(),current_block);
    else
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
  printf("Error: %s\n",s);
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
  {"*",MULOP},{"/",MULOP},{"div",MULOP},{"mod",MULOP},{"and",MULOP},
  {"=",RELOP},{"<>",RELOP},{"<=",RELOP},{"<",RELOP},{"=>",RELOP},{">",RELOP}
};

void init(){
  struct Entry *p;
  for (p=keywords_dictionary;p->token;p++)
    insert(p->name,p->token,KEYWORD);
}

struct Entry convert_entries(struct Entry entry1, struct Entry entry2){
  if (entry1.data_type!=entry2.data_type){
    current_register++;
    if (entry1.data_type==INT_TYPE){
      yylval.real_to_int.entry_to_convert=new Entry(entry2);
      string real_to_int_variable_name="$t"+to_string(current_register);
      int real_to_int_variable_index=insert_variable(real_to_int_variable_name,INT_TYPE,false,0,0,TEMPORARY);
      entries_list.at(real_to_int_variable_index).values.at(0).integer=(int)(entry2.values.at(0).real);
      printf("Temporal variable: %s\n",entries_list.at(real_to_int_variable_index).name.c_str());
      entry2=(entries_list.at(real_to_int_variable_index));
      yylval.real_to_int.converted_entry=new Entry(entry2);
      print_assembly(REAL_TO_INT,yylval);
    } else if (entry1.data_type==REAL_TYPE){
      yylval.int_to_real.entry_to_convert=new Entry(entry2);
      string int_to_real_variable_name="$t"+to_string(current_register);
      int int_to_real_variable_index=insert_variable(int_to_real_variable_name,REAL_TYPE,false,0,0,TEMPORARY);
      entries_list.at(int_to_real_variable_index).values.at(0).real=(double)(entry2.values.at(0).integer);
      printf("Temporal variable: %s\n",entries_list.at(int_to_real_variable_index).name.c_str());
      entry2=(entries_list.at(int_to_real_variable_index));
      yylval.int_to_real.converted_entry=new Entry(entry2);
      print_assembly(INT_TO_REAL,yylval);
    }
    current_register--;
  }
  return entry2;
}
struct Entry convert_entry(struct Entry entry){
  if (entry.is_array_data_type && entry.current_array_index!=-1){
    struct Number value=entry.values.at(entry.current_array_index);
    int current_array_index_address=entry.addresses.at(entry.current_array_index);
    entry.is_array_data_type=false;
    entry.addresses.clear();
    entry.values.clear();
    entry.first_index=0;
    entry.last_index=0;
    entry.values.push_back(value);
    entry.addresses.push_back(current_array_index_address);
  }
  return entry;
}
