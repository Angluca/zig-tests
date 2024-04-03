typedef struct Op op_t;
typedef op_t *op_p;
void* op_new(const char* name);
op_t* op_new_op_all(const char* names[], int size);
void op_free(op_t *pp);
void hello(op_t *pp);
void hello_all(op_t *pp);
