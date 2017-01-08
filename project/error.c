#include "global.h"
#include "parser.h"

void yyerror(char const * s){
  printf("Error: %s",s);
}
