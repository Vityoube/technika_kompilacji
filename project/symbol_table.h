#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string.h>
#include <string>
using namespace std;
struct entry{
  string name;
  int token;
  int token_type;
};
struct data_type{
	string standard_type;
	bool is_array;
	int first_index;
	int last_index;
};
struct value{
  string name;
  string standard_type;
  int intval;
  double realval;
};
struct variable{
  string name;
  vector<data_type> value_types;
  vector<value> values;
  enum{ GLOBAL,LOCAL } visibility;
};

struct procedure{
  int last_function_call_int_result;
  double last_function_call_double_result;
  string name;
  vector<variable> arguments;
  int arguments_count;
  struct data_type return_type;
  vector<value> return_values;
};

vector<entry> entries_list;
vector<data_type> data_types_list;
vector<value> values_list;
vector<variable> variables_list;
vector<procedure> procedures_list;
extern int lookup(char name[],int type);
extern int insert (char name[], int tok, int token_type);
extern int insert_data_type(char standard_type[]);
extern int insert_array_data_type(char standard_type[],int first_index, int last_index);
extern int find_value(char name[]);
extern int find_variable(char name[]);
extern int find_array(char name[]);
extern int find_procedure(char name[]);
extern int find_function(char name[]);
extern int insert_value(char* type, int intval, double realval);
extern int insert_variable(char name[], char* type);
extern int insert_array(char name[], char type[], int first_index, int last_index);
extern int insert_procedure(char name[]);
extern int insert_function(char name[], char* return_type);
extern void init();
extern int insert_function_arguments(char function_name[],vector<variable> arguments,char type[]);
extern int insert_procedure_arguments(char procedure_name[],vector<variable> arguments,char type[]);
extern int insert_procedure_local_variables(char procedure_name[],vector<variable> variables,char type[]);
extern double function_return_double_value(char function_name[], double return_double_value);
extern int function_return_int_value(char function_name[], int return_int_value);
