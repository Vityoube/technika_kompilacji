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
                  sscanf(yytext,"%d",yylval.number.integer);
                  yylval.number.type=INT_TYPE;
                  return NUM;
                }

[0-9]([0-9])*('.'[0-9]([0-9])*)?('E'('+'|'-'|'')[0-9]([0-9])*)? {
                                                                  printf("real value : %d",yytext);
                                                                  sscanf(yytext,"%d",yylval.number.real);
                                                                  yylval.number.type=REAL_TYPE;
                                                                  return NUM;
                                                                }

[A-Za-z]([0-9A-Za-z])* {
                          if (yyleng>BSIZE)
                            yyerror ("compiler error");
                          p=lookup(yytext,KEYWORD);
                          if (p==-1){
                            yylval.name=new string(yytext);
                            return ID;
                          }
                          yylval.token=entries_list.at(p).token;
                          yylval.name=new string(entries_list.at(p).name);
                          return entries_list.at(p).token;
                        }


<<EOF>> {
          return DONE;
        }

.       {
          if (yyleng>BSIZE)
            yyerror ("compiler error");
          p=lookup(yytext,KEYWORD);
          if (p==-1){
            yylval.name=new string(yytext);
            return yytext[yyleng-1];
          }
          yylval.token=entries_list.at(p).token;
          yylval.name=new string(entries_list.at(p).name);
          return entries_list.at(p).token;
        }
%%


int yywrap(){
  return -1;
}
