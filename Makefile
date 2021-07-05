# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kyuki <kyuki@student.42tokyo.jp>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/05 12:38:52 by kyuki             #+#    #+#              #
#    Updated: 2021/07/05 12:38:53 by kyuki            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	libasm.a

CC		=	gcc

CFLAGS	=	-g -Wall -Wextra -Werror

RM		= rm -rf

ASMSRC	=	ft_write.s \
			ft_strlen.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_strdup.s \
			ft_read.s

ASMOBJS	=	$(ASMSRC:.s=.o)

AR		=	ar rcs

NASM	=	nasm

ifeq ($(shell uname),Linux)
	NASMFLAGS = -Fdwarf -felf64 -D __LINUX__=1
else
	NASMFLAGS = -Fdwarf -fmacho64
endif

%.o	: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

.PHONY: all
all:	$(NAME)

$(NAME):	$(ASMOBJS)
			$(AR) $(NAME) $(ASMOBJS)

.PHONY: test
test	:	all
			$(CC) $(CFLAGS) main.c $(NAME)
			./a.out

.PHONY: clean
clean	:
			$(RM) $(ASMOBJS)

.PHONY: fclean
fclean	:	clean
			$(RM)	$(NAME)
			$(RM)	a.out

.PHONY: re
re		:	fclean all
