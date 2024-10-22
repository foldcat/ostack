# ostack 

a simple implementation of a stack
in odin via a linked data structure

quickstart:
```odin
s, _err := make_stack(i32)
defer destroy_stack(s)

stack_push(s, 1)

print_stack(s)

res, ok := stack_peek(s)
if ok {
    fmt.println(res)
}

res, ok = stack_pop(s)
if ok {
    fmt.println(res)
}

res, ok = stack_peek(s)
if !ok {
    fmt.println("stack is empty")
}

res, ok = stack_pop(s)
if !ok {
    fmt.println("stack is empty")
}
```
