/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gpirozzi <giovannipirozzi12345@gmail.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/07 11:08:31 by gpirozzi          #+#    #+#             */
/*   Updated: 2025/02/12 19:15:11 by gpirozzi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H


#include <stdbool.h>
#include <limits.h>
#include "./libft/libft.h"


typedef struct s_stack
{
	int		nbr;
	int		index;
	struct	s_stack	*next;
}	t_stack;

//for errors
int				error_syntax(char *str);
void			free_stack(t_stack **stack);
void			free_errors(t_stack **a);
int				error_duplicate(t_stack *a, int n);

//utils
t_stack			*find_last(t_stack *stack);
t_stack			*find_max(t_stack *stack);
t_stack			*find_min(t_stack *stack);
void			init_stack_a(t_stack **a, char **argv);
void			sort_three(t_stack **a);
bool			stack_sorted(t_stack *stack);
char			**split(char *s, char c);
int				stack_len(t_stack *stack);
void			insertion_sort(t_stack **a, t_stack **b);
void			move_to_top(t_stack **a, t_stack *node);
void			ft_index_list(t_stack **a, t_stack **tmp);
void			print_stack(t_stack *stack);

//moves
void			pa(t_stack **a, t_stack **b);
void			pb(t_stack **a, t_stack **b);
void			ra(t_stack **a);
void			rb(t_stack **b);
void			rr(t_stack **a, t_stack **b);
void			rra(t_stack **a);
void			rrb(t_stack **b);
void			rrr(t_stack **a, t_stack **b);
void			sa(t_stack **a);
void			sb(t_stack **b);
void			ss(t_stack **a,t_stack **b);

#endif
