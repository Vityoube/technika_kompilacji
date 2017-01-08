
%option outfile="lexer.c"
%option nodefault
%array
%x alnum
%{
  #include "global.h"
  char lexbuf[BSIZE];
  int lineno = 1;
  int tokenval = NONE;
  #define YY_DECL int lexan();
%}

%%
" "|"\t"
"\n"  lineno++;
[:digit:] {
            unput(yytext);
            sscanf(yytext+1,"%d",&tokenval);
            return NUM;
          }
[:alpha:] {
              int p, b =0;
              BEGIN(alnum);
          }
<alnum>[:alnum:] {
                  lexbuf[b]=yytext;
          	      b++;
          	      if (b >= BSIZE)
          		      error ("compiler error");
                  }
                  BEGIN(alnum);
<alnum>  {
          lexbuf[b]=EOS;
          if (t!=EOF)
            unput(yytext);
          p = lookup (lexbuf);
      	  if (p == 0)
      	    p = insert (lexbuf, ID);
      	  tokenval = p;
      	  return symtable[p].token;
        }

<<EOF>> {
          return DONE;
        }

.       {
          tokenval = NONE;
          return t;
        }
%%
