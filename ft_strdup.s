%ifdef __LINUX__
    %define M_FT_STRDUP ft_strdup
	%define M_FT_STRLEN ft_strlen
	%define M_FT_STRCPY ft_strcpy
	%define M_CALL_PLT wrt ..plt
	%define M_MALLOC malloc
%else
    %define M_FT_STRDUP _ft_strdup
	%define M_FT_STRLEN _ft_strlen
	%define M_FT_STRCPY _ft_strcpy
	%define M_CALL_PLT
	%define M_MALLOC _malloc
%endif
global M_FT_STRDUP

section .text
		extern M_MALLOC
		extern M_FT_STRLEN
		extern M_FT_STRCPY
M_FT_STRDUP:
	push	rbp ;push rbp to stack
	mov		rbp, rsp ;rbp = rsp
	sub		rsp, 0x20 ;make address
	mov		[rbp-0x8], rdi ;address[rbp-0x8] = rdi<str_address>
	call	M_FT_STRLEN ;rax<len> = strlen(rdi)
	inc		rax
	mov		rdi, rax ;rdi<len> = rax<len>
	call	M_MALLOC M_CALL_PLT ;rax<malloced> = malloc(rdi<len>)
	mov		rdi, [rbp-0x8] ;rdi<str_address> = address[rbp-0x8]<str_address>
	mov		rsi, rdi ;rsi<str_address> = rdi<str_address>
	mov		rdi, rax ;rdi<malloced> = rax<malloced>
	call	M_FT_STRCPY ;rax<str_address> = strcpy(rdi<malloced>, rsi<str_address>)
	mov		rsp, rbp ;rsp = rbp
	pop		rbp
	ret
    ; push rdi
    ; call ft_strlen
    ; inc  rax
    ; mov  rdi, rax
    ; call malloc
    ; cmp  rax, 0
    ; je   .error
    ; mov  rdi, rax
    ; pop  rsi
    ; sub  rsp, 8
    ; call ft_strcpy
    ; add  rsp, 8
    ; ret

.error:
    pop  rsi
    ret