/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */

#line 67 "parser.cpp" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "parser.hpp".  */
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
#line 1 "parser.yy" /* yacc.c:355  */

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

#line 179 "parser.cpp" /* yacc.c:355  */

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
    PROC_CALL_WITH_ARGUMENTS = 288
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 82 "parser.yy" /* yacc.c:355  */

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
 

#line 244 "parser.cpp" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 98 "parser.yy" /* yacc.c:355  */

  void print_assembly(int token, YYSTYPE token_value);
  extern int yylex();
  FILE* open_pascal_file(char * filename);
  void close_pascal_file();

 

#line 266 "parser.cpp" /* yacc.c:355  */

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */

/* Copy the second part of user declarations.  */
#line 146 "parser.yy" /* yacc.c:358  */

  int last_parameter=-1;
  bool local_scope=false;
  int compound_statements_complexity=0;
  int current_block=0;

#line 278 "parser.cpp" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   115

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  44
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  24
/* YYNRULES -- Number of rules.  */
#define YYNRULES  51
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  119

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   289

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      34,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      27,    28,     2,     2,    42,     2,    30,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    33,    29,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    31,     2,    32,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    35,    36,    37,    38,    39,    40,    41,    43
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   155,   155,   161,   164,   168,   173,   186,   188,   189,
     209,   217,   229,   230,   233,   234,   238,   250,   273,   295,
     296,   299,   319,   341,   347,   352,   354,   355,   359,   374,
     387,   388,   389,   393,   398,   404,   409,   444,   445,   448,
     449,   453,   454,   455,   456,   460,   461,   465,   466,   468,
     469,   470
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "DONE", "error", "$undefined", "NONE", "NUM", "ID", "\"if\"",
  "\"while\"", "\"then\"", "\"else\"", "\"do\"", "\"begin\"", "\"end\"",
  "\"var\"", "\"program\"", "\"function\"", "\"procedure\"", "\"array\"",
  "\"of\"", "\"integer\"", "\"real\"", "\"not\"", "\"or\"", "SIGN",
  "ASSIGNOP", "MULOP", "RELOP", "'('", "')'", "';'", "'.'", "'['", "']'",
  "':'", "'\\n'", "START", "REAL_FUN", "INT_FUN", "PROC_CALL", "RETURN",
  "NEW_BLOCK", "PROC_CALL_WITH_ARGUMENTS", "','", "\"..\"", "$accept",
  "program", "input_output", "identifier_list", "global_declarations",
  "local_declarations", "type", "standard_type", "subprogram_declarations",
  "subprogram_declaration", "subprogram_head", "arguments",
  "parameter_list", "compound_statement", "optional_statements",
  "statement_list", "statement", "variable", "procedure_statement",
  "expression_list", "expression", "simple_expression", "term", "factor", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,    40,    41,    59,
      46,    91,    93,    58,    10,   282,   283,   284,   285,   286,
     287,   288,    44,   289
};
# endif

#define YYPACT_NINF -87

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-87)))

#define YYTABLE_NINF -34

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      30,     9,    17,    21,   -87,    49,   -87,    29,    25,    40,
      69,   -87,   -87,    72,    49,    55,   -20,    57,    81,    83,
      63,   -87,    60,    58,    28,    24,    24,   -87,    79,    64,
     -87,    70,   -87,    68,    68,   -87,    47,   -87,    65,   -87,
     -87,    71,   -87,    24,    24,   -87,   -12,     3,     3,    24,
     -87,    89,    50,    73,   -87,    91,   -87,    57,    24,    49,
      66,    74,    49,   -87,    98,   -87,   -19,   -87,    75,    24,
     -87,    73,    76,    57,     3,     3,    24,     3,    57,   -87,
     -87,     0,    51,    62,   -87,     1,    67,   -87,    24,   -87,
     -10,   -87,    96,    73,    73,    61,   -87,   -87,    58,   -87,
      49,    77,    58,   104,   -87,   -87,    57,   -87,     8,   -87,
      80,    82,   -87,    58,   -87,    93,   -87,    62,   -87
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,     4,     0,     3,     0,
       0,     7,     5,    14,     0,     0,     0,    24,     0,     0,
       0,     8,     0,     0,    35,     0,     0,    30,     0,    25,
      26,     0,    29,    19,    19,    15,     0,     2,     0,    12,
      13,     0,    10,     0,     0,    49,    33,     0,     0,     0,
      47,     0,    39,    41,    45,     0,    23,     0,     0,     0,
       0,     0,     0,    16,     0,     6,     0,    37,     0,     0,
      51,    42,     0,     0,     0,     0,     0,     0,     0,    27,
      28,     0,     0,     0,    18,     0,     0,    36,     0,    34,
       0,    50,     0,    44,    43,    40,    46,    32,     0,    20,
       0,     0,     0,     0,    38,    48,     0,    21,     0,    17,
       0,     0,    31,     0,     9,     0,    22,     0,    11
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -87,   -87,   -87,   -13,   -87,   -87,   -86,   -78,   -87,   -87,
     -87,    78,   -87,    -5,   -87,   -87,   -53,   -17,   -87,    44,
     -23,    39,   -37,   -41
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     7,     8,    13,    36,    41,    42,    15,    20,
      21,    60,    82,    27,    28,    29,    30,    50,    32,    66,
      67,    52,    53,    54
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      31,    16,    51,    55,    79,   101,    70,    45,    46,    87,
      22,    71,   107,    23,     3,    69,   110,     4,   105,    44,
      92,    68,    10,    88,    47,    97,    72,   116,    45,    46,
      49,    63,    88,    98,   102,    80,    96,    93,    94,   118,
      31,   113,    10,    10,     1,    47,    81,    48,     5,    85,
      10,    49,   -33,   112,     6,    43,    31,     9,    17,    44,
      62,    31,    24,    25,    26,   104,    17,    10,    17,    11,
      18,    19,    74,    75,    12,    38,    76,    39,    40,    99,
     100,    39,    40,    74,    75,    14,    33,   108,    34,    31,
      37,    56,    35,    57,    58,    59,    64,    73,    77,    83,
      65,    78,    86,    84,    91,   106,   109,    89,   111,   114,
     103,   117,    61,    90,   115,    95
};

static const yytype_uint8 yycheck[] =
{
      17,    14,    25,    26,    57,    83,    47,     4,     5,    28,
      15,    48,    98,    33,     5,    27,   102,     0,    28,    31,
      73,    44,    42,    42,    21,    78,    49,   113,     4,     5,
      27,    36,    42,    33,    33,    58,    77,    74,    75,   117,
      57,    33,    42,    42,    14,    21,    59,    23,    27,    62,
      42,    27,    24,   106,     5,    27,    73,    28,    11,    31,
      13,    78,     5,     6,     7,    88,    11,    42,    11,    29,
      15,    16,    22,    23,     5,    17,    26,    19,    20,    28,
      29,    19,    20,    22,    23,    13,     5,   100,     5,   106,
      30,    12,    29,    29,    24,    27,    31,     8,    25,    33,
      29,    10,     4,    29,    28,     9,    29,    32,     4,    29,
      43,    18,    34,    69,    32,    76
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    14,    45,     5,     0,    27,     5,    46,    47,    28,
      42,    29,     5,    48,    13,    52,    47,    11,    15,    16,
      53,    54,    57,    33,     5,     6,     7,    57,    58,    59,
      60,    61,    62,     5,     5,    29,    49,    30,    17,    19,
      20,    50,    51,    27,    31,     4,     5,    21,    23,    27,
      61,    64,    65,    66,    67,    64,    12,    29,    24,    27,
      55,    55,    13,    57,    31,    29,    63,    64,    64,    27,
      67,    66,    64,     8,    22,    23,    26,    25,    10,    60,
      64,    47,    56,    33,    29,    47,     4,    28,    42,    32,
      63,    28,    60,    66,    66,    65,    67,    60,    33,    28,
      29,    51,    33,    43,    64,    28,     9,    50,    47,    29,
      50,     4,    60,    33,    29,    32,    50,    18,    51
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    44,    45,    46,    47,    47,    48,    48,    49,    49,
      50,    50,    51,    51,    52,    52,    53,    54,    54,    55,
      55,    56,    56,    57,    58,    58,    59,    59,    60,    60,
      60,    60,    60,    61,    61,    62,    62,    63,    63,    64,
      64,    65,    65,    65,    65,    66,    66,    67,    67,    67,
      67,    67
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,    10,     1,     1,     3,     6,     0,     0,     6,
       1,     8,     1,     1,     0,     3,     3,     6,     4,     0,
       3,     3,     5,     3,     0,     1,     1,     3,     3,     1,
       1,     6,     4,     1,     4,     1,     4,     1,     3,     1,
       3,     1,     2,     3,     3,     1,     3,     1,     4,     1,
       3,     2
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 155 "parser.yy" /* yacc.c:1646  */
    {
                                                                                                                    print_assembly(DONE,yylval);
                                                                                                                    YYACCEPT;
                                                                                                                }
#line 1438 "parser.cpp" /* yacc.c:1646  */
    break;

  case 3:
#line 161 "parser.yy" /* yacc.c:1646  */
    {
                                  current_identifiers_list.clear();
                              }
#line 1446 "parser.cpp" /* yacc.c:1646  */
    break;

  case 4:
#line 164 "parser.yy" /* yacc.c:1646  */
    {
                      string identifier=*(yyvsp[0].name);
                      current_identifiers_list.push_back(identifier);
                    }
#line 1455 "parser.cpp" /* yacc.c:1646  */
    break;

  case 5:
#line 168 "parser.yy" /* yacc.c:1646  */
    {
                                            string identifier=*(yyvsp[0].name);
                                            current_identifiers_list.push_back(identifier);
                                          }
#line 1464 "parser.cpp" /* yacc.c:1646  */
    break;

  case 6:
#line 173 "parser.yy" /* yacc.c:1646  */
    {
                                                                            for (string identifier: current_identifiers_list){
                                                                              int p=find_global_variable(identifier);
                                                                              if(p==-1){
                                                                                struct Type type=(yyvsp[-1].data_type);
                                                                                insert_variable(identifier, type.standard_type,type.is_array,type.first_index,type.last_index,GLOBAL);
                                                                                printf("global variable: %s\n",identifier.c_str());
                                                                              } else {
                                                                                yyerror("Variable is already defined\n");
                                                                              }
                                                                            }
                                                                            current_identifiers_list.clear();
                                                                          }
#line 1482 "parser.cpp" /* yacc.c:1646  */
    break;

  case 7:
#line 186 "parser.yy" /* yacc.c:1646  */
    { print_assembly(START,yylval); }
#line 1488 "parser.cpp" /* yacc.c:1646  */
    break;

  case 9:
#line 189 "parser.yy" /* yacc.c:1646  */
    {
                                                                            struct Type type=(yyvsp[-1].data_type);
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
#line 1513 "parser.cpp" /* yacc.c:1646  */
    break;

  case 10:
#line 209 "parser.yy" /* yacc.c:1646  */
    {
						            struct Type type;
                        type.standard_type=(yyvsp[0].standard_type);
                        type.is_array=false;
                        type.first_index=0;
                        type.last_index=0;
                        (yyval.data_type)=type;
					          }
#line 1526 "parser.cpp" /* yacc.c:1646  */
    break;

  case 11:
#line 217 "parser.yy" /* yacc.c:1646  */
    {
                                                      struct Type type;
                                                      type.standard_type=(yyvsp[0].standard_type);
                                                      type.is_array=true;
                                                      struct Number first_index_NUM=(yyvsp[-5].number);
                                                      struct Number last_index_NUM=(yyvsp[-3].number);
                                                      type.first_index=first_index_NUM.integer;
                                                      type.last_index=last_index_NUM.integer;
                                                      (yyval.data_type)=type;
      												                    }
#line 1541 "parser.cpp" /* yacc.c:1646  */
    break;

  case 12:
#line 229 "parser.yy" /* yacc.c:1646  */
    { (yyval.standard_type)=INT_TYPE;  }
#line 1547 "parser.cpp" /* yacc.c:1646  */
    break;

  case 13:
#line 230 "parser.yy" /* yacc.c:1646  */
    { (yyval.standard_type)=REAL_TYPE; }
#line 1553 "parser.cpp" /* yacc.c:1646  */
    break;

  case 16:
#line 240 "parser.yy" /* yacc.c:1646  */
    {
                                              current_procedure_index=-1;
                                              current_parameter_indexes.clear();
                                              current_arguments_indexes.clear();
                                              local_scope=false;
                                              print_assembly(RETURN,yylval);
                                             }
#line 1565 "parser.cpp" /* yacc.c:1646  */
    break;

  case 17:
#line 250 "parser.yy" /* yacc.c:1646  */
    {
                                                            string function_name=*(yyvsp[-4].name);
                                                            int p=find_procedure(function_name,current_parameter_indexes,(yyvsp[-1].standard_type));
                                                            if (p==-1){
                                                              current_procedure_index=insert_procedure(function_name,true,current_parameter_indexes,(yyvsp[-1].standard_type),false,0,0);
                                                              (yyval.index)=current_procedure_index;
                                                              printf("Function: %s\n",function_name.c_str());
                                                            } else {
                                                              yyerror("The function is already defined in the program.\n");
                                                            }
                                                            for (int argument_index : current_arguments_indexes)
                                                              assign_procedure_to_local_variable(argument_index,current_procedure_index);
                                                            current_identifiers_list.clear();
                                                            struct Procedure new_procedure;
                                                            new_procedure.name=new string(function_name);
                                                            new_procedure.address=entries_list.at((yyval.index)).address;
                                                            yylval.procedure=new_procedure;
                                                            if ((yyvsp[-1].standard_type)==INT_TYPE)
                                                              print_assembly(INT_FUN,yylval);
                                                            else if ((yyvsp[-1].standard_type)=REAL_TYPE)
                                                              print_assembly(REAL_FUN,yylval);
                                                            local_scope=true;
                                                        }
#line 1593 "parser.cpp" /* yacc.c:1646  */
    break;

  case 18:
#line 273 "parser.yy" /* yacc.c:1646  */
    {
                                                            string procedure_name=*(yyvsp[-2].name);
                                                            int p=find_procedure(procedure_name,current_parameter_indexes,VOID);
                                                            if (p==-1){
                                                              current_procedure_index=insert_procedure(procedure_name,false,current_parameter_indexes,VOID,false,0,0);
                                                              (yyval.index)=current_procedure_index;
                                                              printf("Procedure: %s\n",procedure_name.c_str());
                                                            } else
                                                              yyerror("The procedure is already defined in the program.\n");
                                                            for (int argument_index : current_arguments_indexes)
                                                              assign_procedure_to_local_variable(argument_index,current_procedure_index);
                                                            current_identifiers_list.clear();
                                                            struct Procedure new_procedure;
                                                            new_procedure.name=new string(procedure_name);
                                                            new_procedure.address=entries_list.at((yyval.index)).address;
                                                            yylval.procedure=new_procedure;
                                                            print_assembly(PROC,yylval);
                                                            local_scope=true;
                                                        }
#line 1617 "parser.cpp" /* yacc.c:1646  */
    break;

  case 20:
#line 296 "parser.yy" /* yacc.c:1646  */
    {  }
#line 1623 "parser.cpp" /* yacc.c:1646  */
    break;

  case 21:
#line 299 "parser.yy" /* yacc.c:1646  */
    {
                                              struct Type type=(yyvsp[0].data_type);
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
#line 1648 "parser.cpp" /* yacc.c:1646  */
    break;

  case 22:
#line 319 "parser.yy" /* yacc.c:1646  */
    {
                                                                struct Type type=(yyvsp[0].data_type);
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
#line 1674 "parser.cpp" /* yacc.c:1646  */
    break;

  case 23:
#line 343 "parser.yy" /* yacc.c:1646  */
    { compound_statements_complexity--; }
#line 1680 "parser.cpp" /* yacc.c:1646  */
    break;

  case 24:
#line 347 "parser.yy" /* yacc.c:1646  */
    {
                                    if (!local_scope && compound_statements_complexity==0)
                                      print_assembly(NEW_BLOCK,yylval);
                                    compound_statements_complexity++;
                                   }
#line 1690 "parser.cpp" /* yacc.c:1646  */
    break;

  case 28:
#line 359 "parser.yy" /* yacc.c:1646  */
    {
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
#line 1709 "parser.cpp" /* yacc.c:1646  */
    break;

  case 29:
#line 374 "parser.yy" /* yacc.c:1646  */
    {
                                  struct Entry procedure=entries_list.at((yyvsp[0].index));
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
#line 1727 "parser.cpp" /* yacc.c:1646  */
    break;

  case 33:
#line 393 "parser.yy" /* yacc.c:1646  */
    {
                  int identifier_index;
					       //int variable_index=find_variable($1);
					       //$$=variables_list[variable_index];
				}
#line 1737 "parser.cpp" /* yacc.c:1646  */
    break;

  case 34:
#line 398 "parser.yy" /* yacc.c:1646  */
    {
          								//int variable_index=find_variable($1);
										//$$=variable_index;
									}
#line 1746 "parser.cpp" /* yacc.c:1646  */
    break;

  case 35:
#line 404 "parser.yy" /* yacc.c:1646  */
    {
                           string procedure_name=*(yyvsp[0].name);
							             int procedure_index=find_procedure(procedure_name,vector<int>(),VOID);
                           (yyval.index)=procedure_index;
						            }
#line 1756 "parser.cpp" /* yacc.c:1646  */
    break;

  case 36:
#line 409 "parser.yy" /* yacc.c:1646  */
    {
                                                    string procedure_name=*(yyvsp[-3].name);
                                                    vector<Entry> expression_results=*(yyvsp[-1].entries);
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
#line 1793 "parser.cpp" /* yacc.c:1646  */
    break;


#line 1797 "parser.cpp" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 472 "parser.yy" /* yacc.c:1906  */




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
