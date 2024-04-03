//zig build-lib zig_ptr.zig
//zig cc call_zig.c libzig_ptr.a && ./a.out
//zig cc call_zig.c libzig_ptr.a.o && ./a.out
#include <stdint.h>

#define zig_extern
zig_extern void hello(char *msg, uint8_t len);
zig_extern void hello_all(char *msgs[], uint8_t len);
int main() {
    char* str = "hello";
    /*hello((uint8_t*)str, 5);*/
    hello(str, 5);
    char* msgs[] = {"world", "zig_ptr"};
    hello_all(msgs, 2);
    return 0;
}
