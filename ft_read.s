global	_ft_read

section	.text
		extern ___error

_ft_read:
	mov rax, 0x2000003	;rax = read()
	syscall				;read(rdi<fd>, rsi<buf>, rdx<byte>)
	jc error_exit		;if c == 1 → error_exit
	ret

error_exit:
	push rax			;push rax to stack
	call ___error		;rax = errno address
	pop qword[rax]		;errnoのアドレスを直接逆参照してポップ クワッドワードは8バイト(64bit)のデータ項目
	mov rax, -1			;rax = -1
	ret