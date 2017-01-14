#include <glib-2.0/glib.h>
struct entry{
  char* name;
  int token;
  int token_type;
};
struct data_type{
	char* standard_type;
	uint is_array;
	int first_index;
	int last_index;
};
struct value{
  char * name;
  char * standard_type;
  int intval;
  double realval;
};
struct variable{
  char * name;
  GPtrArray* value_types;
  GPtrArray* values;
  char * visibility;
};

struct procedure{
  int last_function_call_int_result;
  double last_function_call_double_result;
  char * name;
  GPtrArray* arguments;
  int arguments_count;
  char * return_type;
  int return_int_value;
  double return_double_value;
};

extern struct entry entries_list[];
extern struct data_type data_types_list[];
extern struct value values_list[];
extern struct variable variables_list[];
extern struct array arrays_list[];
extern struct procedure procedures_list[];
