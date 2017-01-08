%x alpha
%array
%option nodefault
%option outfile="lexer.c"
%{
  #include "global.h"
  #include "math.h"
  #define YYSTYPE int_type 
  char lexbuf[BSIZE];
  int lineno = 1;
  int tokenval=NONE;
%}

%%
%{
int p;
%}
[ \t]
[\n]  lineno++;
[0-9]+ {
          (void)sscanf(yytext,"%d",&yylval.int_type);
          return NUM;
       }
[A-Za-z][A-Za-z0-9]+  {
                  if (yyleng>BSIZE)
                    error ("compiler error");
                  p=lookup(yytext);
                  if (p==0)
                    p=insert(yytext,ID);
                  yylval.int_type=p;
                  return symtable[yylval.int_type].token;
                }

<<EOF>>  return DONE;
.     {	
    yylval.int_type=NONE;
    return yytext[yyleng-1];
  }
%%
