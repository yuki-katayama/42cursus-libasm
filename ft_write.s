global _ft_write
section .text
		extern ___error

_ft_write:
	mov rax, 0x2000004	;write
	syscall				;write(rdi, rsi, rdx)
	jc error_exit		;when dont work write, jc == 1
	ret

error_exit:
	push rax			;push rax to stack
	call ___error		;rax = errno address
	pop qword[rax]		;errnoのアドレスを直接逆参照してポップ クワッドワードは8バイト(64bit)のデータ項目
	mov rax, -1			;rax = -1
	ret