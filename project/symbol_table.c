#include "global.h"
#include "parser.h"

#define STRMAX 999
#define NAMEMAX 50
#define SYMMAX 100
#define MAXVARIABLES 1000000
#define MAXVALUES 1000000000
#define MAXPROCEDURES 100000
#define MAXFUNCTIONS  100000
char lexemes[STRMAX];
int lastchar = -1;
struct entry keywords[SYMMAX];
struct value values[MAXVALUES];
struct variable variables[MAXVARIABLES];
struct array arrays[MAXVARIABLES];
struct procedure procedures[MAXPROCEDURES];
struct function functions[MAXFUNCTIONS];
int lastentry = 0;
int last_value=0;
int last_variable=0;
int last_procedure=0;
int last_array=0;
int last_function=0;
int
lookup (char s[])
{
  int p;
  for (p = lastentry; p > 0; p--)
    if (strcmp (keywords[p].name, s) == 0)
      return p;
  return 0;
}
int find_value(char name[]){
  int p;
  for (p=last_value;p>0;p--)
    if (strcmp(values[p].name,name)==0)
      return p;
  return 0;
}

int find_variable(char name[]){
  int p;
  for (p=last_variable;p>0;p--)
    if (strcmp(variables[p].name,name)==0)
      return p;
  return 0;
}

int find_array(char name[]){
  int p;
  for (p=last_array;p>0;p--)
    if (strcmp(arrays[p].name,name)==0)
      return p;
  return 0;
}

int find_procedure(char name[]){
  int p;
  for (p=last_procedure;p>0;p--)
    if (strcmp(procedures[p].name,name)==0)
      return p;
  return 0;
}

int find_function(char name[]){
  int p;
  for (p=last_function;p>0;p--)
    if (strcmp(functions[p].name,name)==0)
      return p;
  return 0;
}

int
insert (char s[], int tok)
{
  int len;
  len = strlen (s);
  if (lastentry + 1 >= SYMMAX)
    error ("keyword table full");
  if (lastchar + len + 1 >= STRMAX)
    error ("lexemes array full");
  lastentry++;
  keywords[lastentry].token = tok;
  keywords[lastentry].name=&lexemes[lastchar + 1];
  lastchar += len + 1;
  strcpy (keywords[lastentry].name, s);
  return lastentry;
}
int insert_value(char* type, int intval, double realval){
  int len;
  len = strlen (s);
  if (last_value + 1 >= MAXVALUES)
    error ("values table full");
  last_value++;
  int length_of_value=(last_value==0) ? 1 : (int)log10(last_value)+1;
  memset(values[last_value].name,0,255);
  strcpy(values[last_value].name,"value");
  itoa(last_value,values[last_value].name+5,length_of_value);
  memset(values[last_value].data_type,0,strlen(type));
  strcpy(values[last_value].data_type,type);
  if (strcmp(type,"integer")==0){
    values[last_value].intval=intval;
  } else if (strcmp(type,"real")==0){
    values[last_value].realval=realval;
  }
  return last_value;
}
int insert_variable(char name[], char* data_type, int intval, double realval){
  int len;
  len = strlen (name);
  if (last_variable + 1 >= MAXVARIABLES)
    error ("variables table full");
  if (len + 1 >= NAMEMAX)
    error ("Too long name for identifier");
  last_variable++;
  memset(variables[last_variable].name,0,strlen(name));
  strcpy(variables[last_variable].name,name);
  memset(variables[last_variable].data_type,0,strlen(data_type));
  strcpy(variables[last_variable].data_type,data_type);
  if (strcmp(type,"integer")==0){
    variables[last_variable].intval=intval;
  else if (strcmp(type,"real")==0){
    variables[last_variable].realval=realval;
  return last_variable;
}

int insert_array(char[] name, char data_type[], int first_index, int last_index){
  int len;
  len = strlen (name);
  if (last_array + 1 >= MAXVARIABLES)
    error ("arrays table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_array++;
  memset(arrays[last_array].name,0,strlen(name));
  strcpy(arrays[last_array].name,name);
  memset(arrays[last_array].data_type,0,strlen(data_type));
  strcpy(arrays[last_array].data_type,data_type);
  arrays[last_array].first_index=first_index;
  arrays[last_array].last_index=last_index;
  return last_array;
}

int insert_procedure(char[] name, int arguments_count, char * arguments_type[]){
  int len;
  len = strlen (name);
  if (last_procedure + 1 >= MAXPROCEDURES)
    error ("procedures table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_procedure++;
  memset(procedures[last_procedure].name,0,strlen(name));
  strcpy(procedures[last_procedure].name,name);
  procedures[last_procedure].arguments_count=arguments_count;
  for (int i=0;i<sizeof(arguments_type);i++){
    memset(procedures[last_procedure].arguments_type[i],0,sizeof(arguments_type)-1);
    strcpy(procedures[last_procedure].arguments_type[i],arguments_type);
  }
  return last_procedure;
}

int insert_function(char[] name, int arguments_count, char * arguments_type[], char* return_type, int last_call_result){
  int len;
  len = strlen (name);
  if (last_function + 1 >= MAXFUNCTIONS)
    error ("procedures table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_function++;
  memset(functions[last_function].name,0,strlen(name));
  strcpy(functions[last_function].name,name);
  functions[last_function].arguments_count=arguments_count;
  for (int i=0;i<sizeof(arguments_type);i++){
    memset(functions[last_function].arguments_type[i],0,sizeof(arguments_type)-1);
    strcpy(functions[last_function].arguments_type[i],arguments_type);
  }
  functions[last_function].return_type=return_type;
  functions[last_function].last_call_result=last_call_result;
  return last_function;
}
