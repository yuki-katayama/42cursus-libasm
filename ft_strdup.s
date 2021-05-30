; ************************************************************************** */
;                                                                            */
;                                                        :::      ::::::::   */
;   ft_strdup.s                                        :+:      :+:    :+:   */
;                                                    +:+ +:+         +:+     */
;   By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+        */
;                                                +#+#+#+#+#+   +#+           */
;   Created: 2021/05/30 13:19:27 by kyuki             #+#    #+#             */
;   Updated: 2021/05/30 13:19:28 by kyuki            ###   ########.fr       */
;                                                                            */
; ************************************************************************** */
global _ft_strdup

section .text
		extern _malloc
		extern _ft_strlen
		extern _ft_strcpy

_free_stack:
	mov rsp, rbp ;rsp = rbp
	pop rbp
	ret

_ft_strdup:
	push rbp			;push rbp to stack
	mov rbp, rsp		;rbp = rsp
	sub rsp, 0x10		;make address
	mov [rbp-0x8], rdi	;address[rbp-0x8] = rdi<str_address>
	call _ft_strlen		;rax<len> = strlen(rdi)
	mov rdi, rax		;rdi<len> = rax<len>
	call _malloc		;rax<malloced> = malloc(rdi<len>)
	mov rdi, [rbp-0x8]	;rdi<str_address> = address[rbp-0x8]<str_address>
	mov rsi, rdi		;rsi<str_address> = rdi<str_address>
	mov rdi, rax		;rdi<malloced> = rax<malloced>
	call _ft_strcpy		;rax<str_address> = strcpy(rdi<malloced>, rsi<str_address>)
	call _free_stack
	ret