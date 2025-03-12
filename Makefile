# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/10 17:43:57 by gnicolo           #+#    #+#              #
#    Updated: 2025/02/21 23:26:45 by gnicolo          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


CC = gcc
CFLAGS = -Wall -Wextra -Werror -g
NAME = push_swap
SRC = errors_detector.c insertion_sort.c push_swap.c push.c reverse_rotate.c\
		rotate.c stack_init.c swap.c utils.c util2.c index_list.c for_chunks.c

OBJ_SRC= ${SRC:.c=.o}

LIBFT_DIR = ./libft
LIBFT = $(LIBFT_DIR)/libft.a

all: $(LIBFT) $(NAME)

$(LIBFT):
		@$(MAKE) -C $(LIBFT_DIR)

$(NAME): $(OBJ_SRC) $(LIBFT)
	$(CC) $(CFLAGS) -I$(LIBFT_DIR) $(OBJ_SRC) -L$(LIBFT_DIR) -lft -o $(NAME)

%.o: %.c
		@${CC} -c ${CFLAGS} -I$(LIBFT_DIR) $< -o $@

clean:
		rm -rf $(OBJ_SRC)
		@$(MAKE) clean -C $(LIBFT_DIR)

fclean: clean
		rm -rf $(NAME)
		@$(MAKE) fclean -C $(LIBFT_DIR)

re: fclean all

.PHONY: all clean fclean re