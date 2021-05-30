; ************************************************************************** */
;                                                                            */
;                                                        :::      ::::::::   */
;   ft_strcmp.s                                        :+:      :+:    :+:   */
;                                                    +:+ +:+         +:+     */
;   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
;                                                +#+#+#+#+#+   +#+           */
;   Created: 2021/05/30 13:19:27 by kyuki             #+#    #+#             */
;   Updated: 2021/05/30 13:19:28 by kyuki            ###   ########.fr       */
;                                                                            */
; ************************************************************************** */
global	_ft_strcmp
section .text
_ft_strcmp:
		mov		rcx, -1				;i = -1
loop:
		inc		rcx					;i++
		mov		dl, byte [rdi+rcx]	;al = str1[i]
		mov		bl, byte [rsi+rcx]	;bl = str2[i]
		cmp		dl, 0				;if al == 0
		je		exit				;jump zero
		cmp		bl, 0				;if bl == 0
		je		exit				;then zero
		cmp		dx, bx				;if al == bl
    	je		loop				;then loop
		jmp		exit
exit:
	xor rax, rax
	mov al ,dl 						;al = dl
	sub	dl, bl 						;dl = dl - bl
	jc	overflow					;jump overflow
	mov al, dl 						;al = dl
	ret
overflow:
	sub eax, ebx					;eax = eax - ebx
	ret