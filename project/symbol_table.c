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
int last_function_argument=0;
int last_procedure_argument=0;
int last_function_local_variable=0;
int last_procedure_local_variable=0;
int
lookup (char s[])
{
  int p;
  for (p = lastentry; p > 0; p--)
    if (strcmp (dictionary[p].name, s) == 0)
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
  dictionary[lastentry].token = tok;
  dictionary[lastentry].name=&lexemes[lastchar + 1];
  lastchar += len + 1;
  strcpy (dictionary[lastentry].name, s);
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
  strcpy(values[last_value].name,"value_");
  insert(values[last_value].name,ID);
  itoa(last_value,values[last_value].name+6,length_of_value);
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
  memset(variables[last_variable].name,0,255);
  strcpy(variables[last_variable].name,"var_");
  stnrcpy(variables[last_variable].name+4,name,strlen(name));
  insert(variables[last_variable].name,ID);
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
  memset(arrays[last_array].name,0,255);
  strcpy(arrays[last_array].name,"array_");
  stnrcpy(arrays[last_array].name+6,name,strlen(name));
  insert(arrays[last_array].name,ID);
  memset(arrays[last_array].data_type,0,strlen(data_type));
  strcpy(arrays[last_array].data_type,data_type);
  arrays[last_array].first_index=first_index;
  arrays[last_array].last_index=last_index;
  return last_array;
}

int insert_procedure(char[] name){
  int len;
  len = strlen (name);
  if (last_procedure + 1 >= MAXPROCEDURES)
    error ("procedures table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_procedure++;
  memset(procedures[last_procedure].name,0,255);
  strcpy(procedures[last_procedure].name,"procedure_");
  strncpy(procedures[last_procedure].name+10,name,strlen(name));
  insert(procedures[last_procedure].name,ID);
  return last_procedure;
}

int insert_function(char[] name, char * arguments[], char * arguments_type[], char* return_type){
  int len;
  len = strlen (name);
  if (last_function + 1 >= MAXFUNCTIONS)
    error ("procedures table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_function++;
  memset(functions[last_function].name,0,255);
  strcpy(functions[last_function].name,"function_");
  strncpy(functions[last_function].name+9,name,strlen(name));
  insert(functions[last_function].name,name);
  return last_function;
}

int insert_function_arguments(char function_name[],char* names[],char data_type[]){
  int function_index=find_function(function_name);
  last_function_argument++;
  for (int i=0;i<sizeof(names)-1;i++){
    memset(functions[function_index].arguments[last_function_argument].name,0,strlen(names[i]));
    strcpy(functions[function_index].arguments[last_function_argument].name,names[i]);
    memset(functions[function_index].arguments[last_function_argument].data_type,strlen(data_type));
    strcpy(functions[function_index].arguments[last_function_argument].data_type,data_type);
    functions[function_index].arguments_count++;
  }
  return function_index;
}

int insert_procedure_arguments(char procedure_name[],char* names[],char data_type){
  int procedure_index=find_procedure(procedure_name);
  last_procedure_argument++;
  for (int i=0;i<sizeof(names)-1;i++){
    memset(procedures[procedure_index].arguments[last_procedure_argument].name,0,strlen(names[i]));
    strcpy(procedures[procedure_index].arguments[last_procedure_argument].name,names[i]);
    memset(procedures[procedure_index].arguments[last_procedure_argument].data_type,strlen(data_type));
    strcpy(procedures[procedure_index].arguments[last_procedure_argument].data_type,data_type);
    procedures[function_index].arguments_count++;
  }
  return procedure_index;
}

int insert_function_local_variables(char function_name[],char* names[],char data_type[]){
  int function_index=find_function(function_name);
  last_function_local_variable++;
  for (int i=0;i<sizeof(names)-1;i++){
    memset(functions[function_index].local_variables[last_function_local_variable].name,0,strlen(names[i]));
    strcpy(functions[function_index].local_variables[last_function_local_variable].name,names[i]);
    memset(functions[function_index].local_variables[last_function_local_variable].data_type,strlen(data_type));
    strcpy(functions[function_index].local_variables[last_function_local_variable].data_type,data_type);
  }
  return function_index;
}

int insert_procedure_local_variables(char procedure_name[],char* names[],char data_type){
  int procedure_index=find_procedure(procedure_name);
  last_procedure_local_variable++;
  for (int i=0;i<sizeof(names)-1;i++){
    memset(procedures[procedure_index].local_variables[last_procedure_local_variable].name,0,strlen(names[i]));
    strcpy(procedures[procedure_index].local_variables[last_procedure_local_variable].name,names[i]);
    memset(procedures[procedure_index].local_variables[last_procedure_local_variable].data_type,strlen(data_type));
    strcpy(procedures[procedure_index].local_variables[last_procedure_local_variable].data_type,data_type);
  }
  return procedure_index;
}

double function_return_double_value(char function_name[], double return_double_value){
  int function_index=find_function(function_name);
  functions[function_index].return_double_value=return_double_value;
  return return_value;
}

int function_return_int_value(char function_name[], int return_int_value){
  int function_index=find_function(function_name);
  functions[function_index]return_int_value=return_int_value;
  return return_double_value;

}
