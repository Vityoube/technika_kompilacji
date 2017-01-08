%{
  #include "global.h"
%}
%union{
	char  * str_type;
	int int_type;
}
%defines
%token <str_type> DIV 'div'
%token <str_type> MOD 'mod'
%token <int_type> NUM 
%token <int_type> ID
%token DONE 0
%token <str_type> '+' '-' '/' '*'
%%
sequ:  expr ';'      { return DONE; }
      | ';'          { return DONE; }
      | error { yyerror("syntax error (match)"); }
expr: /* empty */
    | expr '+' term	 {
                        emit('+', NONE);
                     }
    | expr '-' term {
                      emit('-', NONE);
                    }
    | term	    { }
    | error { yyerror("syntax error (match)"); }
;
term: term '*' factor {
                          emit('*', NONE);
                         }
    | term '/' factor {
                              emit('/', NONE);
                         }
    | term DIV factor {
                              emit(DIV, NONE);
                             }
    | term MOD factor {
                              emit(MOD, NONE);
                           }
    | factor		{}
    | error { yyerror("syntax error (match)"); }
;
factor: '(' expr ')'  { }
      | NUM           { emit(NUM, $1); }
      | ID            { emit (ID, $1); }
      | error         { yyerror ("syntax error (factor)"); }
;
%%

