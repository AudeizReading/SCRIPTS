CC=gcc
CFLAGS=-Wall -Werror -Wextra -ansi -Wpedantic
DEP_CFLAGS=-MM -MD
RM=-rm -rf
NAME=executable
src=$(wildcard *.c)
obj=$(src:.c=.o)
dep=$(src:.c=.d)

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(obj)
	$(CC) $^ -o $@; chmod +x $@

%.o:%.c
	$(CC) -c $< $(CFLAGS) -o $@

%.d:%.c
	$(CC) $< $(DEP_CFLAGS) $(CFLAGS) -o $@

clean:
	$(RM) $(obj) $(dep)

fclean: clean
	$(RM) $(NAME)

re: fclean all

-include $(dep)
