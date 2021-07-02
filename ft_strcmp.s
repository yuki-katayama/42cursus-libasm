%ifdef __LINUX__
    %define M_FT_STRCMP ft_strcmp
%else
    %define M_FT_STRCMP _ft_strcmp
%endif

global	M_FT_STRCMP
section .text
M_FT_STRCMP:
	push r8
	mov rcx, -1 ;rcx = -1
loop:
	inc rcx ;rcx += 1
	mov r8b, byte [rdi+rcx] ;r8b = str1[rdi + rcx]
	cmp r8b, byte [rsi + rcx] ;if(r8b == str2[rsi + rcx])
	jne loop_error ;(a != b), jump to loop_error
	cmp byte [rdi + rcx], 0 ;if(str1[rdi + rcx] == 0)
	je loop_success ;(a == b), jump to loop_success
	jmp loop ;jumpt to loop

loop_success:
	xor rax, rax ;rax = 0
	pop r8
	ret

loop_error:
	xor rax, rax ;rax = 0
    mov al, r8b ;al = s1[rdi + rcx]
    xor r8, r8 ;r8 = 0
    mov r8b, byte [rsi + rcx] ;r8 = str2[rsi + rcx]
    sub eax, r8d ;eax = eax - r8d
	pop r8
    ret