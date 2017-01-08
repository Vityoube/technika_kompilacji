#include "global.h"
#include "parser.h"

int main(int argc, char* argv[]){
  init();
  open_pascal_file(argv[1]);
  yyparse();
  close_pascal_file();
}
