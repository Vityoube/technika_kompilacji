#include "symbol_table.h"
#include <math.h>
typedef void* gpointer;
#define STRMAX 999
#define NAMEMAX 50
#define SYMMAX 100
#define MAXVARIABLES 1000
#define MAXVALUES 10000
#define MAXPROCEDURES 100
#define MAXFUNCTIONS  100
#define MAXDATATYPES 1000
char lexemes[STRMAX];
int lastchar = -1;
//struct data_type data_types[MAXDATATYPES];
//struct entry entries_list[SYMMAX];
//struct value values_list[MAXVALUES];
//struct variable variables_list[MAXVARIABLES];
//struct array arrays_list[MAXVARIABLES];
//struct procedure procedures_list[MAXPROCEDURES];
int lastentry = 0;
int last_value=0;
int last_variable=0;
int last_procedure=0;
int last_data_type=0;
int last_procedure_argument=0;

struct entry keywords_dictionary[]={
  {"if", IF},
  {"then",THEN},
  {"else",ELSE},
  {"while",WHILE},
  {"do",DO},
  {"var",VAR},
  {"program",PROGRAM},
  {"function",FUNCTION},
  {"procedure",PROCEDURE},
  {"array",ARRAY},
  {"of",OF},
  {"integer",INTEGER},
  {"real",REAL},
  {"not",NOT},
  {"or",OR},
  {"begin",BEG},
  {"end",END},
  {":=",ASSIGNOP},
  {"+",SIGN},{"-",SIGN},
  {"*",MULOP},{"/",MULOP},{"div",MULOP},{"mod",MULOP},
  {"=",RELOP},{"<>",RELOP},{"<=",RELOP},{"<",RELOP},{"=>",RELOP},{">",RELOP}
};

void init(){
  struct entry *p;
  for (p=keywords_dictionary;p->token;p++)
    insert(p->name,p->token,KEYWORD);
}

int
lookup (std::string name,int token_type)
{
  int p;
  for (p = lastentry; p > 0; p--)
    if (name.compare(entries_list.at(p).name) == 0 && entries_list.at(p).token_type==token_type)
    	return p;
  return 0;
}
int find_value(std::string name){
  int p;
  for (p=last_value;p>0;p--)
    if (name.compare(values_list.at(p).name)==0)
      return p;
  return 0;
}

int find_variable(std::string name){
  int p;
  for (p=last_variable;p>0;p--)
    if (name.compare(variables_list.at(p).name)==0)
      return p;
  return 0;
}

int find_procedure(std::string name){
  int p;
  for (p=last_procedure;p>0;p--)
    if (name.compare(procedures_list.at(p).name)==0)
      return p;
  return 0;
}


struct entry
insert (std::string name, int tok,int token_type)
{
  int len;
  len = name.length();
  if (lastentry + 1 >= SYMMAX)
    yyerror ("keyword table full");
  if (lastchar + len + 1 >= STRMAX)
    yyerror ("lexemes array full");
  lastentry++;
  entries_list.at(lastentry).token = tok;
  entries_list.at(lastentry).name=&lexemes[lastchar + 1];
  lastchar += len + 1;
  entries_list.at(lastentry).name=name;
  entries_list.at(lastentry).token_type=token_type;
  return entries_list.at(lastentry);
}
//int insert_value(char* type, int intval, double realval){
 // int len;
 // len = strlen (type);
 // if (last_value + 1 >= MAXVALUES)
 //   error ("values table full");
 // last_value++;
 // int length_of_value=0;
  //length_of_value=(last_value==0)? 1 : (log10(last_value))+1;
  //memset(values_list[last_value].name,0,255);
  //sprintf(last_value,values_list[last_value].name,"%d",length_of_value);
  //memset(values_list[last_value].type,0,strlen(type));
  //strcpy(values_list[last_value].type,type);
  //if (strcmp(type,"integer")==0){
//	  values_list[last_value].intval=intval;
  //} else if (strcmp(type,"real")==0){
//	  values_list[last_value].realval=realval;
 // }
 // return last_value;
//}
struct data_type insert_data_type(std::string standard_type){
	last_data_type++;
	data_types.at(last_data_type).standard_type=standard_type;
	data_types.at(last_data_type).is_array=false;
	return data_types.at(last_data_type);
}

struct data_type insert_array_data_type(std::string standard_type,int first_index, int last_index){
	last_data_type++;
	data_types.at(last_data_type).standard_type=standard_type;
	data_types.at(last_data_type).is_array=true;
	if (last index < first_index){
		yyerror("Syntax error: last index cannot be less than first index");
		return NULL;
	}
	if (first_index<0 || last_index<0){
		yyerror("Syntax error: index cannot be negative");
		return NULL;
	}
	data_types.at(last_data_type).first_index=first_index;
	data_types.at(last_data_type).last_index=last_index;
	return data_types.at(last_data_type);
}
/*
int insert_variable(char name[], std::vector data_types){
  int len;
  len = strlen (name);
  if (last_variable + 1 >= MAXVARIABLES)
//    error ("variables table full");
  if (len + 1 >= NAMEMAX)
//    error ("Too long name for identifier");
  last_variable++;
  memset(variables_list[last_variable].name,0,255);
 /* variables_list[last_variable].value_types=g_ptr_array_new();
  variables_list[last_variable].values=g_ptr_array_new();
  strncpy(variables_list[last_variable].name,name,strlen(name));
//  for (int i=0;i<data_types->len;i++){
//	  g_ptr_array_add(variables_list[last_variable].value_types,data_types->pdata);
//	  struct data_type data_type=data_types[i];
//	  if (data_type.is_array){
/*		  if (strcmp(data_type.standard_type,"integer")==0)
			  for (int i=data_type.first_index;i<data_type.last_index;i++){
				  struct value value=
				  {.intval=0, .standard_type="integer", .realval=0.0};
//				  g_ptr_array_add(variables_list[last_variable].values,(gpointer)value);
			  }
		  else
			  for (int i=data_type.first_index;i<data_type.last_index;i++){
			  				  struct value value=
			  				  {.intval=0, .standard_type="real", .realval=0.0};
//			  				  g_ptr_array_add(variables_list[last_variable].values,(gpointer)value);
			  }
	  } else {
		  if (strcmp(data_type.standard_type,"integer")==0){
			  struct value value= {.intval=0, .standard_type="integer", .realval=0.0};
//			  g_ptr_array_add(variables_list[last_variable].values,value);
		  } else {
			  struct value value= {.intval=0, .standard_type="real", .realval=0.0};
//			  g_ptr_array_add(variables_list[last_variable].values,value);
		  }
	  }
  }
//  insert(name,ID,VARIABLE);
  return last_variable;
}



int insert_procedure(char name[],struct data_type return_type){
  int len;
  len = strlen (name);
  if (last_procedure + 1 >= MAXPROCEDURES)
//    error ("procedures table full");
  if (len + 1 >= NAMEMAX)
  error ("Too long name for identifier");
  last_procedure++;
  memset(procedures_list[last_procedure].name,0,255);
  strncpy(procedures_list[last_procedure].name,name,strlen(name));
  last_procedure++;
  memset(procedures_list[last_procedure].name,0,255);
  procedures_list[last_procedure].return_type=return_type;
  procedures_list[last_procedure].arguments=
  insert(name,ID,PROCEDURE);
  return last_procedure;
}




int insert_procedure_arguments(char procedure_name[],std::vector<variable> arguments,char type[]){
  int procedure_index=find_procedure(procedure_name);
  last_procedure_argument++;
//  for (int i=0;i<arguments->len;i++)
//   	  g_ptr_array_add(procedures_list[procedure_index].arguments,(gpointer)g_ptr_array_ref(arguments));
//  procedures_list[procedure_index].arguments_count+=arguments->len;
  return procedure_index;
}

//double function_return_double_value(char function_name[], double return_double_value){
//  int function_index=find_procedure(function_name);
  //procedures_list[function_index].return_double_value=return_double_value;
 // return return_double_value;
//}

//int function_return_int_value(char function_name[], int return_int_value){
 // int function_index=find_procedure(function_name);
  //procedures_list[function_index].return_int_value=return_int_value;
  //return return_int_value;
//}