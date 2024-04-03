//zig cc -c c_ptr.c
#include "c_ptr.h"

void hello_c(const char* str) {
    printf("%s\n", str);
}

void hello_all_c(const char* msgs[], int size) {
    for(int i=0; i<size; ++i) {
        printf("%s\n", msgs[i]);
    }
}

