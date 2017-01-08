#include "global.h"
int
main ()
{
  init ();
  yyparse ();
  exit (0);
}
