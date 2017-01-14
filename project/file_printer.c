#include "global.h"


void print_assembly(FILE* output_file, int token_type, YYSTYPE type){
  int fd;
  char path[255];
  fd=fileno(yyin);
  sprintf(path, "/proc/self/fd/%d", fd);
  char filename[255];
  memset(filename, 0, sizeof(filename));
  readlink(path,filename,sizeof(filename)-1);
  char assembly_file[255];
  memset(assembly_file, 0, sizeof(assembly_file));
  strncpy(assembly_file,filename,strlen(filename)-4);
  strcat(assembly_file,".asm");
  FILE* output=fopen(assembly_file,"wb");
  if (token_type==NUM){

  }else if (token_type==DONE){
    fprintf(output,"%s","\texit\n");
  }
}
