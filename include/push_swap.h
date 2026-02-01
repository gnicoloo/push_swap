/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/07 11:08:31 by gnicolo           #+#    #+#             */
/*   Updated: 2026/02/01 15:44:58 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include <stdbool.h>
# include <limits.h>
# include "libft.h"

//for errors
int				error_syntax(char *str);
void			free_stack(t_stack **stack);
void			free_errors(t_stack **a);
int				error_duplicate(t_stack *a, int n);

//utils
t_stack			*find_last(t_stack *stack);
t_stack			*find_max(t_stack *stack);
t_stack			*find_min(t_stack *stack);
t_stack			*best_node(t_stack **a, t_stack **b);
void			init_stack_a(t_stack **a, char **argv, int flags);
void			sort_three(t_stack **a);
bool			stack_sorted(t_stack *stack);
int				stack_len(t_stack *stack);
int				take_min(t_stack *stack);
void			ft_index_list(t_stack **a, t_stack **tmp);
int				find_index(t_stack *stack, t_stack *node);
void			move_to_top(t_stack **a, t_stack *node);
void			move_to_top_b(t_stack **a, t_stack *node);
void			ft_clean_mat(char **mat);

//per chunk
int				assign_chunk(t_stack *stack);
int				find_median(t_stack *stack);
int				move_chunks_to_b(t_stack **a, t_stack **b, int max_chunk);
void			insertion_sort(t_stack **a, t_stack **b);

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
void			ss(t_stack **a, t_stack **b);

#endif
//             {{{bhooo potevano servire}}}
/* int		    find_total_moves(t_stack *a, t_stack *b, t_stack *node);
void			setup_a(t_stack **a, int nbr);
int				find_position_a(t_stack *a, int nbr);
int				count_to_top(t_stack **stack, t_stack *node);
void			print_stack(t_stack *stack);
void			h_sort(t_stack **a, t_stack **b);*/
