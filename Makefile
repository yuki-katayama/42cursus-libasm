NAME	=	libasm.a

CC		=	gcc

CFLAGS	=	-Wall -Wextra -Werror

RM		= rm -rf

ASMSRC	=	ft_write.s \
			ft_strlen.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_strdup.s \
			ft_read.s \
			test.s

ASMOBJS	=	$(ASMSRC:.s=.o)

AR		=	ar rcs

NASM	=	nasm

NASMFLAGS	=	-f macho64

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
