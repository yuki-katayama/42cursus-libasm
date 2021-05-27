global	_ft_strcpy
section	.text

_ft_strcpy:
		mov rax, rdi			;rax = rdi
		xor rcx, rcx			;rcx = 0
loop:
		mov dl, byte[rsi + rcx]	;c = str[top of addr src  + rcx]
		mov byte[rax + rcx], dl	;cpy_str[top of addr cpy + rcx] = c
		cmp byte[rsi + rcx], 0	;str[top of addr src  + rcx] == '\0'
		je exit_loop			;jump exit_loop
		inc rcx					;rcx++
		jmp loop				;back loop
exit_loop:
		ret