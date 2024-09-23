package stack

import "core:fmt"
import "core:mem"

Node :: struct($T: typeid) {
	value: T,
	next:  ^Node(T),
}

Stack :: struct($T: typeid) {
	next: ^Node(T),
}

make_stack :: proc($T: typeid, alloc := context.allocator) -> ^Stack(T) {
	return new_clone(Stack(T){next = nil}, alloc)
}

stack_push :: proc(stack: ^$L/Stack($T), target: T, alloc := context.allocator) {
	if stack.next == nil {
		res, err := new_clone(Node(T){value = target, next = nil}, alloc)
		stack.next = res
	} else {
		next_ptr := stack.next
		res, err := new_clone(Node(T){value = target, next = next_ptr}, alloc)
		stack.next = res
	}
}


// pops an item off the stack, if the stack is empty, 
// ok's value will be false, otherwise true
stack_pop :: proc(stack: ^$L/Stack($T), alloc := context.allocator) -> (result: T, ok: bool) {
	if stack.next == nil {
		a: T
		return a, false
	}
	tail := stack.next.next
	if tail != nil {
		node_for_delete := stack^.next
		ret_val := node_for_delete.value
		free(node_for_delete, alloc)
		stack.next = tail
		return ret_val, true
	} else {
		free(stack.next, alloc)
		stack.next = nil
	}

	a: T
	return a, false
}

// peeks the stack, if the stack is empty, 
// ok's value will be false, otherwise true
stack_peek :: proc(stack: ^$L/Stack($T), alloc := context.allocator) -> (result: T, ok: bool) {
	res := stack.next
	if res != nil {
		return res.value, true
	} else {
		a: T
		return a, false
	}
}


// prints out the stack
print_stack :: proc(stack: ^$L/Stack($T)) {
	current_node := stack.next
	fmt.print("<")
	for current_node != nil {
		temp := current_node
		current_node = current_node.next
		fmt.print(temp.value)
		if current_node != nil {
			fmt.print(", ")
		}
	}
	fmt.print(">")
	fmt.println()
}

// calls free() on every node of the stack, then 
// freeing itself
destroy_stack :: proc(stack: ^$L/Stack($T), alloc := context.allocator) {
	current_node := stack.next
	for current_node != nil {
		temp := current_node
		current_node = current_node.next
		free(temp, alloc)
	}
	free(stack)
}
