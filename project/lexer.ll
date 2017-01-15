%option nodefault
%{
    #include "parser.hpp"
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
                  yylval.number.type=(Number.type)0;
                  return NUM;
                }

[0-9]([0-9])*('.'[0-9]([0-9])*)?('E'('+'|'-'|'')[0-9]([0-9])*)? {
                                                                  printf("real value : %d",yytext);
                                                                  sscanf(yytext,"%d",&yylval.number.real);
                                                                  yylval.number.type=(Number.type)1;
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
                          yylval.token=entries_list.at(p).token;
                          yylval.string=entries_list.at(p).name;
                          return entries_list.at(p).token;
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
          yylval.token=entries_list.at(p).token;
                          yylval.string=entries_list.at(p).name;
                          return entries_list.at(p).token;
        }
%%


int yywrap(){
  return -1;
}


