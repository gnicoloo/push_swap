# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gnicolo <gnicolo@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/10 17:43:57 by gnicolo           #+#    #+#              #
#    Updated: 2026/02/01 15:42:22 by gnicolo          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ============================================================================ #
#                                   COLORS                                     #
# ============================================================================ #

RED		= \033[0;31m
GREEN	= \033[0;32m
YELLOW	= \033[0;33m
BLUE	= \033[0;34m
RESET	= \033[0m

# ============================================================================ #
#                                  VARIABLES                                   #
# ============================================================================ #

NAME		= push_swap
CC			= gcc
CFLAGS		= -Wall -Wextra -Werror -g
RM			= rm -rf

# ============================================================================ #
#                                 DIRECTORIES                                  #
# ============================================================================ #

SRC_DIR		= src
INC_DIR		= include
OBJ_DIR		= obj
LIBFT_DIR	= libft

# ============================================================================ #
#                                    FILES                                     #
# ============================================================================ #

SRC_FILES	= errors_detector.c \
			  insertion_sort.c \
			  push_swap.c \
			  push.c \
			  reverse_rotate.c \
			  rotate.c \
			  stack_init.c \
			  swap.c \
			  utils.c \
			  util2.c \
			  index_list.c \
			  for_chunks.c

SRCS		= $(addprefix $(SRC_DIR)/, $(SRC_FILES))
OBJS		= $(addprefix $(OBJ_DIR)/, $(SRC_FILES:.c=.o))
LIBFT		= $(LIBFT_DIR)/libft.a

# ============================================================================ #
#                                   INCLUDES                                   #
# ============================================================================ #

INCLUDES	= -I$(INC_DIR) -I$(LIBFT_DIR)

# ============================================================================ #
#                                    RULES                                     #
# ============================================================================ #

all: $(NAME)

$(NAME): $(LIBFT) $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) -L$(LIBFT_DIR) -lft -o $(NAME)
	@echo "$(GREEN)✓ $(NAME) compiled successfully!$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@echo "$(BLUE)Compiling: $<$(RESET)"

$(LIBFT):
	@echo "$(YELLOW)Building libft...$(RESET)"
	@$(MAKE) -C $(LIBFT_DIR) --no-print-directory
	@echo "$(GREEN)✓ libft compiled!$(RESET)"

clean:
	@$(RM) $(OBJ_DIR)
	@$(MAKE) clean -C $(LIBFT_DIR) --no-print-directory
	@echo "$(RED)✗ Object files removed$(RESET)"

fclean: clean
	@$(RM) $(NAME)
	@$(MAKE) fclean -C $(LIBFT_DIR) --no-print-directory
	@echo "$(RED)✗ Executable removed$(RESET)"

re: fclean all

# ============================================================================ #
#                                   TESTING                                    #
# ============================================================================ #

test3:
	@echo "$(YELLOW)Testing with 3 numbers...$(RESET)"
	@./$(NAME) 2 1 3 | wc -l

test5:
	@echo "$(YELLOW)Testing with 5 numbers...$(RESET)"
	@./$(NAME) 5 4 3 2 1 | wc -l

test100:
	@echo "$(YELLOW)Testing with 100 numbers...$(RESET)"
	@ARG=$$(seq 1 100 | shuf | tr '\n' ' '); \
	MOVES=$$(./$(NAME) $$ARG | wc -l); \
	echo "Moves: $$MOVES"; \
	if [ $$MOVES -lt 700 ]; then \
		echo "$(GREEN)✓ PASS (< 700)$(RESET)"; \
	else \
		echo "$(RED)✗ FAIL$(RESET)"; \
	fi

test500:
	@echo "$(YELLOW)Testing with 500 numbers...$(RESET)"
	@ARG=$$(seq 1 500 | shuf | tr '\n' ' '); \
	MOVES=$$(./$(NAME) $$ARG | wc -l); \
	echo "Moves: $$MOVES"; \
	if [ $$MOVES -lt 5500 ]; then \
		echo "$(GREEN)✓ PASS (< 5500)$(RESET)"; \
	else \
		echo "$(RED)✗ FAIL$(RESET)"; \
	fi

bench: test3 test5 test100 test500

# ============================================================================ #
#                                    HELP                                      #
# ============================================================================ #

help:
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(RESET)"
	@echo "$(GREEN)                      PUSH_SWAP MAKEFILE                       $(RESET)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(RESET)"
	@echo "$(YELLOW)Available targets:$(RESET)"
	@echo "  $(GREEN)make$(RESET)          - Compile the project"
	@echo "  $(GREEN)make clean$(RESET)    - Remove object files"
	@echo "  $(GREEN)make fclean$(RESET)   - Remove object files and executable"
	@echo "  $(GREEN)make re$(RESET)       - Recompile the project"
	@echo "  $(GREEN)make test3$(RESET)    - Test with 3 numbers"
	@echo "  $(GREEN)make test5$(RESET)    - Test with 5 numbers"
	@echo "  $(GREEN)make test100$(RESET)  - Test with 100 numbers"
	@echo "  $(GREEN)make test500$(RESET)  - Test with 500 numbers"
	@echo "  $(GREEN)make bench$(RESET)    - Run all tests"
	@echo "  $(GREEN)make help$(RESET)     - Show this help message"
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(RESET)"

.PHONY: all clean fclean re test3 test5 test100 test500 bench help