//zig cc -c opaque.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Op {
    /*char name[32];*/
    const char *name;
    const char **names;
    int size;
} op_t;

void* op_new(const char *name) {
    op_t *pp = malloc(sizeof(op_t));
    pp->name = name;
    /*memset(pp, 0, sizeof(op_t));*/
    /*if(!pp) {*/
        /*strcpy(pp->name, name);*/
    /*}*/
    return (void*)pp;
}
op_t* op_new_all(const char **names, int size) {
    op_t *pp = malloc(sizeof(op_t));
    pp->names = names;
    pp->size = size;
    return pp;
}
void op_free(op_t *pp) {
    free(pp);
}
void hello(op_t *pp) {
    printf("%s\n", pp->name);
}
void hello_all(op_t *pp) {
    for(int i=0; i<pp->size; ++i) {
        printf("%s\n", pp->names[i]);
    }
}
