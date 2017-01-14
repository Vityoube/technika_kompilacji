%option nodefault
%option outfile="lexer.c"
%{
    #include "global.h"
%}
%%
%{
int p;
%}
[ \t]+  {}
"{"[^}\n]*"}"
[\n\r]+ {}

[0-9]([0-9])*  {
                  printf("integer value: %d",yytext);
                  sscanf(yytext,"%d",&yylval.number.integer);
                  yylval.number.type=INT;
                  return NUM;
                }

[0-9]([0-9])*('.'[0-9]([0-9])*)?('E'('+'|'-'|'')[0-9]([0-9])*)? {
                                                                  printf("real value : %d",yytext);
                                                                  sscanf(yytext,"%d",&yylval.number.real);
                                                                  yylval.number.type=DOUBLE;
                                                                  return NUM;
                                                                }

[A-Za-z]([0-9A-Za-z])* {
                          if (yyleng>BSIZE)
                            error ("compiler error");
                          p=lookup(yytext,KEYWORD);
                          if (p==0){
                            sscanf(yytext,"%s",&yylval.string);
                            return ID;
                          }
                          yylval.token=entries_list[p].token;
                          yylval.string=entries_list[p].name;
                          return entries_list[p].token;
                        }


<<EOF>> {
          return DONE;
        }

.       {
          if (yyleng>BSIZE)
            error ("compiler error");
          p=lookup(yytext,KEYWORD);
          if (p==0){
            yylval.token=NONE;
            return yytext[yyleng-1];
          }
          yylval.token=entries_list[p].token;
          yylval.string=entries_list[p].name;
          return entries_list[p].token;
        }
%%


int yywrap(){
  return -1;
}


