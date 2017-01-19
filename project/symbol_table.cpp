#include "parser.hpp"
#include <stdexcept>
#define STRMAX 999
#define NAMEMAX 50
#define SYMMAX 100
#define MAXVARIABLES 1000
#define MAXVALUES 10000
#define MAXPROCEDURES 1000
int lastchar = -1;
vector<Entry> entries_list;
int lastentry = -1;
int last_address=0;
vector<string> current_identifiers_list;
vector<int> current_declarations_indexes;
vector<int> current_parameter_indexes;
int current_procedure_index=-1;
using namespace std;
int
lookup (char* name,int token_type)
{
  int p;
  for (p = 0; p <=lastentry; p++)
    if (entries_list.at(p).name.compare(name) == 0 && entries_list.at(p).token_type==token_type)
    	return p;
  return -1;
}

int find_procedure(string name, vector<int> arguments_indexes, int return_type){
  int p;
  for (p = 0; p <=lastentry; p++)
    if (entries_list.at(p).name.compare(name)==0 && entries_list.at(p).token_type==PROCEDURE &&
      entries_list.at(p).arguments_indexes==arguments_indexes && entries_list.at(p).data_type==return_type )
        return p;
  return -1;
}

int find_global_variable(string name){
  int p;
  for (p=0;p<=lastentry;p++)
    if(entries_list.at(p).name.compare(name)==0 && entries_list.at(p).token_type==GLOBAL_VARIABLE)
      return p;
  return -1;
}

int find_local_variable(string name, int function_index){
  int p;
  for (p=0;p<=lastentry;p++)
    if (entries_list.at(p).name.compare(name) && entries_list.at(p).token_type==LOCAL_VARIABLE
      && entries_list.at(p).local_variable_function_index==function_index)
        return p;
    return -1;
}

int insert(string name, int token, int token_type){
  struct Entry entry;
  entry.name=name;
  entry.token=token;
  entry.token_type=token_type;
  entries_list.push_back(entry);
  lastentry++;
  return lastentry;
}

int insert_variable(string variable_name, int standard_type, bool is_array, int first_index, int last_index, int visibility){
  int len;
  len = variable_name.length();
  if (lastentry >= MAXVARIABLES)
	  throw invalid_argument("variables table full");
  if (len + 1 >= NAMEMAX)
    throw invalid_argument("Too long name for variable");
  struct Entry variable;
  variable.name=variable_name;
  variable.address=last_address;
  variable.token=ID;
  if (visibility==GLOBAL)
    variable.token_type=GLOBAL_VARIABLE;
  else if (visibility==LOCAL)
    variable.token_type=LOCAL_VARIABLE;
  variable.data_type=standard_type;
  variable.is_array_data_type=is_array;
  struct Number value;
  value.type=standard_type;
  if (variable.is_array_data_type){
	  if (first_index<=last_index && first_index>=0 && last_index>=0){
      variable.first_index=first_index;
      variable.last_index=last_index;
		  for (int i=0;i<last_index;i++){
		  		  switch (value.type){
		  		   case INT_TYPE:
		  		 	  value.integer=0;
		  		 	  break;
		  		   case REAL_TYPE:
		  		 	  value.real=0.0;
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
	  switch (value.type){
	  case INT_TYPE:
		  value.integer=0;
		  break;
	  case REAL_TYPE:
		  value.real=0.0;
		  break;
	  default:
		  throw invalid_argument("Wrong value type");
	  }
	  variable.values.push_back(value);
  }
  switch (variable.data_type){
  case INT_TYPE:
      last_address+=4;
      break;
  case REAL_TYPE:
      last_address+=8;
      break;
  default:
    throw invalid_argument("Wrong value type");
  }
  lastentry++;
  entries_list.push_back(variable);
  return lastentry;
}

void assign_procedure_to_local_variable(int variable_index, int procedure_index){
      entries_list[variable_index].local_variable_function_index=procedure_index;
}

int insert_procedure(string procedure_name,bool is_function, vector<int> arguments_indexes,
		int standard_return_type, bool is_array_return_type, int first_index, int last_index
		){
  int len;
  len = procedure_name.length();
  if (lastentry + 1 >= MAXPROCEDURES)
	  throw invalid_argument("procedures table full");
  if (len + 1 >= NAMEMAX)
	  throw invalid_argument("Too long name for procedure");
  struct Entry procedure;
  procedure.name=procedure_name;
  procedure.token=ID;
  procedure.address=last_address;
  procedure.token_type=PROCEDURE;
  procedure.is_function=is_function;
  procedure.arguments_indexes=arguments_indexes;
  procedure.arguments_count=procedure.arguments_indexes.size();
  procedure.data_type=VOID;
  if (procedure.is_function){
	  procedure.data_type=standard_return_type;
	  procedure.is_array_data_type=is_array_return_type;
	  struct Number value;
    value.type=standard_return_type;
	  if (procedure.is_array_data_type){
		  if (first_index<=last_index && first_index>=0 && last_index>=0){
        procedure.first_index=first_index;
        procedure.last_index=last_index;
			  for (int i=0;i<last_index;i++){
				  switch (procedure.data_type){
				  case INT_TYPE:
					  value.integer=0;
					  break;
				  case REAL_TYPE:
					  value.real=0.0;
					  break;
				  default:
					  throw invalid_argument("Wrong value type");
				  }
				  procedure.values.push_back(value);
			  }
		  } else {
			  throw invalid_argument("Wrong indexes of array");
		  }
	  } else {
		  switch (procedure.data_type){
		  				  case INT_TYPE:
		  					  value.integer=0;
		  					  break;
		  				  case REAL_TYPE:
		  					  value.real=0.0;
		  					  break;
		  				  default:
		  					  throw invalid_argument("Wrong value type");
		  				  }
		  				  procedure.values.push_back(value);
	  }
    switch(procedure.data_type){
      case INT_TYPE:
        last_address+=4;
        break;
      case REAL_TYPE:
        last_address+=8;
        break;
    }
  }
  lastentry++;
  entries_list.push_back(procedure);
return  lastentry;
}
