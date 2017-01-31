%option nodefault
%{
    #include "parser.hpp"
%}
%pointer
%%
%{
int p;
%}
[ \t]+  {}
"{"[^}\n]*"}"
[\n\r]+ {}

[0-9]([0-9])*  {
                  printf("integer value: %d\n",atoi(yytext));
                  yylval.number.integer=atoi(yytext);
                  yylval.number.type=INT_TYPE;
                  return NUM;
                }

[0-9]([0-9])*[.][0-9]([0-9])*('E'('+'|'-'|'')[0-9]([0-9])*)? {
                                                                  printf("real value : %f\n",atof(yytext));
                                                                  yylval.number.real=atof(yytext);
                                                                  yylval.number.type=REAL_TYPE;
                                                                  return NUM;
                                                                }

[A-Za-z_]([0-9A-Za-z_])* {
                          if (yyleng>BSIZE)
                            yyerror ("compiler error");
                          p=lookup(yytext,KEYWORD);
                          if (p==-1){
                            yylval.name=new string(yytext);
                            return ID;
                          }
                          yylval.token_identifier.token=entries_list.at(p).token;
                          yylval.token_identifier.name=new string(entries_list.at(p).name);
                          return entries_list.at(p).token;
                        }

<<EOF>> {
          return DONE;
        }

":="    {
          yylval.token_identifier.name=new string(yytext);
          yylval.token_identifier.token=ASSIGNOP;
          return ASSIGNOP;
        }
"+"|"-" {
          yylval.token_identifier.name=new string(yytext);
          yylval.token_identifier.token=SIGN;
          return SIGN;
        }
"*"|"/"|"div"|"mod"|"and" {
                            yylval.token_identifier.name=new string(yytext);
                            yylval.token_identifier.token=MULOP;
                            return MULOP;
                          }
">="|"<="|"<"|">"|"="|"<>"         {
                                      yylval.token_identifier.name=new string(yytext);
                                      yylval.token_identifier.token=RELOP;
                                      return RELOP;
                                    }

.      {
          if (yyleng>BSIZE)
            yyerror ("compiler error");
          p=lookup(yytext,KEYWORD);
          if (p==-1){
            yylval.name=new string(yytext);
            return yytext[yyleng-1];
          }
          yylval.token_identifier.token=entries_list.at(p).token;
          yylval.token_identifier.name=new string(entries_list.at(p).name);
          return entries_list.at(p).token;
        }
%%


int yywrap(){
  return -1;
}
