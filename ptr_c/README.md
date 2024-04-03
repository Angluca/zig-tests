zig call c
```zsh
zig cc -c c_ptr.c

zig build-exe call_c.zig c_ptr.o && ./call_c
zig run call_c.zig c_ptr.o
```
c call zig-lib
```zsh
zig build-obj zig_ptr.zig
zig cc call_zig.c zig_ptr.o && ./a.out

zig build-lib zig_ptr.zig
zig cc call_zig.c libzig_ptr.a && ./a.out
zig cc call_zig.c libzig_ptr.a -o a_out && ./a_out
zig cc call_zig.c libzig_ptr.a.o && ./a.out
```
