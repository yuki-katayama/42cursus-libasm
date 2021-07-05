; ************************************************************************** */
;                                                                            */
;                                                        :::      ::::::::   */
;   ft_read.s                                          :+:      :+:    :+:   */
;                                                    +:+ +:+         +:+     */
;   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
;                                                +#+#+#+#+#+   +#+           */
;   Created: 2021/07/05 12:36:53 by kyuki             #+#    #+#             */
;   Updated: 2021/07/05 12:36:54 by kyuki            ###   ########.fr       */
;                                                                            */
; ************************************************************************** */

%ifdef __LINUX__
    %define M_FT_READ ft_read
    %define M_ERRNO_LOCATION __errno_location
    %define M_SYSCALL_READ 0
	%define M_CALL_PLT wrt ..plt
%else
    %define M_FT_READ _ft_read
    %define M_ERRNO_LOCATION ___error
    %define M_SYSCALL_READ 0x2000003
	%define M_CALL_PLT
%endif

global	M_FT_READ

section	.text
		extern M_ERRNO_LOCATION

M_FT_READ:
	mov		rax, M_SYSCALL_READ ;rax = read()
	syscall	;read(rdi<fd>, rsi<buf>, rdx<byte>)
	%ifdef __LINUX__
		cmp	rax, 0 ;if(rax == 0)
		jl	error_exit ;if(rax < 0) → error_exit
	%else
		jc	error_exit ;if(c == 1) → error_exit
	%endif
	ret

error_exit:
	%ifdef __LINUX__
		neg	rax ;rax *= -1
	%endif
	push	rax ;push rax to stack…
	call	M_ERRNO_LOCATION M_CALL_PLT ;rax = errno address
	pop		qword[rax] ;errnoのアドレスを直接逆参照してポップ クワッドワードは8バイト(64bit)のデータ項目
	mov		rax, -1 ;rax = -1
	ret