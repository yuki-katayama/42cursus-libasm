%ifdef __LINUX__
    %define M_FT_STRCPY ft_strcpy
%else
    %define M_FT_STRCPY _ft_strcpy
%endif

global	M_FT_STRCPY
section	.text

M_FT_STRCPY:
	mov	rax, rdi ;rax = rdi
	xor	rcx, rcx ;rcx = 0
loop:
	mov	dl, byte[rsi + rcx] ;c = str[top of addr src  + rcx]
	mov	byte[rax + rcx], dl ;cpy_str[top of addr cpy + rcx] = c
	cmp	byte[rsi + rcx], 0 ;if(str[top of addr src  + rcx] == '\0')
	je	exit_loop ;if(a == b), jump exit_loop
	inc	rcx ;rcx++
	jmp	loop ;jump to loop
exit_loop:
	ret