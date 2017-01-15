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
#line 2 "parser.yy" /* yacc.c:1909  */

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

#line 125 "parser.hpp" /* yacc.c:1909  */

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
    THEN = 262,
    ELSE = 263,
    WHILE = 264,
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
    RELOP = 281
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 82 "parser.yy" /* yacc.c:1909  */

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
 

#line 204 "parser.hpp" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 119 "parser.yy" /* yacc.c:1909  */

  void print_assembly(FILE * file, int type, YYSTYPE value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();
 

#line 225 "parser.hpp" /* yacc.c:1909  */

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */
