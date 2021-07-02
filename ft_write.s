%ifdef __LINUX__
    %define M_FT_WRITE ft_write
    %define M_ERRNO_LOCATION __errno_location
    %define M_SYSCALL_WRITE 1
	%define M_CALL_PLT wrt ..plt
%else
    %define M_FT_WRITE _ft_write
    %define M_ERRNO_LOCATION ___error
    %define M_SYSCALL_WRITE 0x2000004
	%define M_CALL_PLT
%endif


global M_FT_WRITE
section .text
		extern M_ERRNO_LOCATION

M_FT_WRITE:
	mov		rax, M_SYSCALL_WRITE ;write
	syscall ;write(rdi, rsi, rdx)
	%ifdef __LINUX__
		cmp rax, 0 ; compare rax and 0
		jl	error_exit ;if(jl < 0) error_exit()
	%else
		jc	error_exit ;when dont work write, (jc == 1)
	%endif
	ret

error_exit:
	%ifdef __LINUX__
		neg	rax ;rax *= -1
	%endif
	push	rax ;push rax to stack
	call	M_ERRNO_LOCATION M_CALL_PLT ;rax = errno address
	pop		qword[rax] ;errnoのアドレスを直接逆参照してポップ クワッドワードは8バイト(64bit)のデータ項目
	mov		rax, -1 ;rax = -1
	ret