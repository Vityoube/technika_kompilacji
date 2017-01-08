%option nodefault
%option outfile="lexer.c"
%{
    #include "global.h"
    #include "parser.h"
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
                  sscanf(yytext,"%d",&yylval.integer);
                  return NUM;
                }

[0-9]([0-9])*('.'[0-9]([0-9])*)?('E'('+'|'-'|'')[0-9]([0-9])*)? {
                                                                  printf("real value : %d",yytext);
                                                                  sscanf(yytext,"%d",&yylval.real);
                                                                  return NUM;
                                                                }

[A-Za-z]([0-9A-Za-z])* {
                          if (yyleng>BSIZE)
                            error ("compiler error");
                          p=lookup(yytext);
                          if (p==0){
                            sscanf(yytext,"%s",&yylval.string);
                            return ID;
                          }
                          yylval.integer=keywords[p].token;
                          yylval.string=keywords[p].name;
                          return keywords[p].token;
                        }


<<EOF>> {
          return DONE;
        }

.       {
          if (yyleng>BSIZE)
            error ("compiler error");
          p=lookup(yytext);
          if (p==0){
            yylval.integer=NONE;
            return yytext[yyleng-1];
          }
          yylval.integer=keywords[p].token;
          yylval.string=keywords[p].name;
          return keywords[p].token;
        }
%%


int yywrap(){
  return -1;
}

FILE* open_pascal_file(char * filename){
  yyin=fopen(filename, "r");
}

void close_pascal_file(){
  fclose(yyin);
}
