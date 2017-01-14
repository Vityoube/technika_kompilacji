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

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 3 "parser.y" /* yacc.c:1909  */

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

#line 60 "parser.h" /* yacc.c:1909  */

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
    RELOP = 281,
    VARIABLE = 282,
    FUNCTION = 283,
    PROCEDURE = 284,
    ARRAY = 285,
    KEYWORD = 286
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "parser.y" /* yacc.c:1909  */

	  struct Number number;
	  int token;
	  char * string;
	  char * type;
	  GArray * identifiers;	
	  struct variable variable;  
 

#line 115 "parser.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_H_INCLUDED  */
