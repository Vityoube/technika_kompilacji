#include "parser.hpp"
#include <math.h>
#include <stdexcept>
#define STRMAX 999
#define NAMEMAX 50
#define SYMMAX 100
#define MAXVARIABLES 1000
#define MAXVALUES 10000
#define MAXPROCEDURES 1000
int lastchar = -1;
vector<Entry> entries_list;
vector<Value> values_list;
vector<Variable> variables_list;
vector<Procedure> procedures_list;
struct Variable variable;
struct Procedure procedure;
int lastentry = 0;
int last_variable=0;
int last_procedure=0;
int last_procedure_argument=0;

int
lookup (char* name,int token_type)
{
  int p;
  for (p = lastentry; p > 0; p--)
    if (entries_list.at(p).name.compare(name) == 0 && entries_list.at(p).token_type==token_type)
    	return p;
  return 0;
}

int find_local_variable(string name){
  int p;
  for (p=last_variable;p>0;p--)
    if (name.compare(variables_list.at(p).variable_name)==0 && variables_list.at(p).visibility==LOCAL)
      return p;
  return 0;
}
int find_global_variable(string name){
  int p;
  for (p=last_variable;p>0;p--)
    if (name.compare(variables_list.at(p).variable_name)==0 && variables_list.at(p).visibility==GLOBAL)
      return p;
  return 0;
}
int find_procedure(string name){
  int p;
  for (p=last_procedure;p>0;p--)
    if (name.compare(procedures_list.at(p).procedure_name)==0)
      return p;
  return 0;
}


int insert (string name, int tok,int token_type){
  int len;
  len = name.length();
  if (lastentry + 1 >= SYMMAX)
    throw invalid_argument("keyword table full");
  if (lastchar + len + 1 >= STRMAX)
	throw invalid_argument("lexemes array full");
  lastentry++;
  entries_list.at(lastentry).token = tok;
  lastchar += len + 1;
  entries_list.at(lastentry).name=name;
  entries_list.at(lastentry).token_type=token_type;
  return lastentry;
}

int insert_global_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index){
  int len;
  len = variable_name.length();
  if (last_variable + 1 >= MAXVARIABLES)
	  throw invalid_argument("variables table full");
  if (len + 1 >= NAMEMAX)
    throw invalid_argument("Too long name for variable");
  last_variable++;
  variable.variable_name=variable_name;
  variable.standard_type=standard_type;
  variable.visibility=GLOBAL;
  variable.is_array=is_array;
  struct Value value;
  value.standard_type=standard_type;
  if (variable.is_array){
	  if (first_index<=last_index && first_index>=0 && last_index>=0){
		  for (int i=0;i<last_index;i++){
		  		  switch (value.standard_type){
		  		   case INT_TYPE:
		  		 	  value.intval=0;
		  		 	  break;
		  		   case REAL_TYPE:
		  		 	  value.realval=0.0;
		  		 	  break;
		  		   default:
		  		 	  throw invalid_argument("Wrong value type");
		  		   }
		  		  variable.values.push_back(value);
		  	  }
	  } else {
		  throw invalid_argument("Wrong indexes of array");
	  }

  } else {
	  switch (value.standard_type){
	  case INT_TYPE:
		  value.intval=0;
		  break;
	  case REAL_TYPE:
		  value.realval=0.0;
		  break;
	  default:
		  throw invalid_argument("Wrong value type");
	  }
	  variable.values.push_back(value);
  }
  insert(variable_name,ID,GLOBAL_VARIABLE);
  variables_list.push_back(variable);
  return last_variable;
}

int insert_local_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index, string function_name) {
	int len;
	  len = variable_name.length();
	  if (last_variable + 1 >= MAXVARIABLES)
		  throw invalid_argument("variables table full");
	  if (len + 1 >= NAMEMAX)
	    throw invalid_argument("Too long name for variable");
	  last_variable++;
	  variable.variable_name=variable_name;
	  variable.standard_type=standard_type;
	  variable.visibility=LOCAL;
	  variable.function_name=function_name;
	  variable.is_array=is_array;
	  struct Value value;
	  value.standard_type=standard_type;
	  if (variable.is_array){
		  if (first_index<=last_index && first_index>=0 && last_index>=0){
			  for (int i=0;i<last_index;i++){
			  		  switch (value.standard_type){
			  		   case INT_TYPE:
			  		 	  value.intval=0;
			  		 	  break;
			  		   case REAL_TYPE:
			  		 	  value.realval=0.0;
			  		 	  break;
			  		   default:
			  		 	  throw invalid_argument("Wrong value type");
			  		   }
			  		  variable.values.push_back(value);
			  	  }
		  } else {
			  throw invalid_argument("Wrong indexes of array");
		  }

	  } else {
		  switch (value.standard_type){
		  case INT_TYPE:
			  value.intval=0;
			  break;
		  case REAL_TYPE:
			  value.realval=0.0;
			  break;
		  default:
			  throw invalid_argument("Wrong value type");
		  }
		  variable.values.push_back(value);
	  }
	  insert(variable_name,ID,LOCAL_VARIABLE);
	  variables_list.push_back(variable);
	  return last_variable;
}



int insert_procedure(string procedure_name,bool is_function, vector<Variable> arguments,
		int standard_return_type, bool is_array_return_type, int first_index, int last_index
		){
  int len;
  len = procedure_name.length();
  if (last_procedure + 1 >= MAXPROCEDURES)
	  throw invalid_argument("procedures table full");
  if (len + 1 >= NAMEMAX)
	  throw invalid_argument("Too long name for procedure");
  last_procedure++;
  procedure.procedure_name=procedure_name;
  procedure.is_function=is_function;
  for (Variable argument: arguments)
	  procedure.arguments.push_back(argument);
  procedure.arguments_count=procedure.arguments.size();
  procedure.is_function=is_function;
  if (procedure.is_function){
	  procedure.standard_return_type=standard_return_type;
	  procedure.is_array_return_type=is_array_return_type;
	  struct Value value;
	  if (procedure.is_array_return_type){
		  if (first_index<=last_index && first_index>=0 && last_index>=0){
			  for (int i=0;i<last_index;i++){
				  switch (procedure.standard_return_type){
				  case INT_TYPE:
					  value.intval=0;
					  break;
				  case REAL_TYPE:
					  value.realval=0.0;
					  break;
				  default:
					  throw invalid_argument("Wrong value type");
				  }
				  procedure.return_values.push_back(value);
			  }
		  } else {
			  throw invalid_argument("Wrong indexes of array");
		  }
	  } else {
		  switch (procedure.standard_return_type){
		  				  case INT_TYPE:
		  					  value.intval=0;
		  					  break;
		  				  case REAL_TYPE:
		  					  value.realval=0.0;
		  					  break;
		  				  default:
		  					  throw invalid_argument("Wrong value type");
		  				  }
		  				  procedure.return_values.push_back(value);
	  }
  }
  insert(procedure_name,ID,PROCEDURE);
  procedures_list.push_back(procedure);
  return last_procedure;
}
