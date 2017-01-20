/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_HPP_INCLUDED
# define YY_YY_PARSER_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 1 "parser.yy" /* yacc.c:1909  */

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

#line 123 "parser.hpp" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DONE = 0,
    NONE = 258,
    NUM = 259,
    ID = 260,
    IF = 261,
    WHILE = 262,
    THEN = 263,
    ELSE = 264,
    DO = 265,
    BEG = 266,
    END = 267,
    VAR = 268,
    PROGRAM = 269,
    FUN = 270,
    PROC = 271,
    ARR = 272,
    OF = 273,
    INTEGER = 274,
    REAL = 275,
    NOT = 276,
    OR = 277,
    SIGN = 278,
    ASSIGNOP = 279,
    MULOP = 280,
    RELOP = 281,
    START = 282,
    REAL_FUN = 283,
    INT_FUN = 284,
    PROC_CALL = 285,
    RETURN = 286,
    NEW_BLOCK = 287,
    PROC_CALL_WITH_ARGUMENTS = 288,
    MOV = 289
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 79 "parser.yy" /* yacc.c:1909  */

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
    struct Entry * entry;
    struct Mov {
      int assign_type;
      struct Entry * entry_to_assign;
      struct Entry * assigned_entry;
      vector<int> * changed_values_indexes;
    } mov;
 

#line 196 "parser.hpp" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 102 "parser.yy" /* yacc.c:1909  */

  void print_assembly(int token, YYSTYPE token_value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();

 

#line 218 "parser.hpp" /* yacc.c:1909  */

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */
