global _ft_strlen
section .text
_ft_strlen:
		xor rax, rax			;rax = 0;
loop:
		cmp byte[rdi + rax], 0	;str[top of addr src  + rax] == \0
		je exit_loop			;if a == b
		inc rax					;rax++
		jmp loop				;jump exit_loop
exit_loop:
		ret