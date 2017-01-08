#include "global.h"

void
yyerror (char *m) 
{
  fprintf (stderr, "line%d:%s\n", lineno, m);
  exit (1);
}


