; ************************************************************************** */
;                                                                            */
;                                                        :::      ::::::::   */
;   ft_strlen.s                                        :+:      :+:    :+:   */
;                                                    +:+ +:+         +:+     */
;   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
;                                                +#+#+#+#+#+   +#+           */
;   Created: 2021/07/05 12:36:53 by kyuki             #+#    #+#             */
;   Updated: 2021/07/05 12:36:54 by kyuki            ###   ########.fr       */
;                                                                            */
; ************************************************************************** */

%ifdef __LINUX__
    %define M_FT_STRLEN ft_strlen
%else
    %define M_FT_STRLEN _ft_strlen
%endif

global M_FT_STRLEN
section .text
M_FT_STRLEN:
	xor	rcx, rcx ;rax = 0;
loop:
	cmp	byte[rdi + rcx], 0 ;if(str[top of addr src  + rax] == \0)
	je	exit_loop ;if(a == b)
	inc	rcx ;rax++
	jmp	loop ;jump to exit_loop
exit_loop:
	mov	rax, rcx
	ret