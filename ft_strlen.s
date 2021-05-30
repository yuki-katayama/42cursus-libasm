; ************************************************************************** */
;                                                                            */
;                                                        :::      ::::::::   */
;   ft_strlen.s                                        :+:      :+:    :+:   */
;                                                    +:+ +:+         +:+     */
;   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
;                                                +#+#+#+#+#+   +#+           */
;   Created: 2021/05/30 13:19:27 by kyuki             #+#    #+#             */
;   Updated: 2021/05/30 13:19:28 by kyuki            ###   ########.fr       */
;                                                                            */
; ************************************************************************** */
global _ft_strlen
section .text
_ft_strlen:
		xor rax, rax			;rax = 0;
loop:
		cmp byte[rdi + rax], 0	;str[top of addr src  + rax] == \0
		je exit_loop			;if a == b
		inc rax					;rax++
		jmp loop				;jump exit_loop
exit_loop:
		ret