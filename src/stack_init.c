/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_init.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/07 11:41:46 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/28 16:00:36 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	append_node(t_stack **stack, int n)
{
	t_stack	*node;
	t_stack	*last_node;

	if (!stack)
		return ;
	node = ft_calloc(sizeof(t_stack), 1);
	if (!node)
		return ;
	node->next = NULL;
	node->nbr = n;
	if (!(*stack))
		*stack = node;
	else
	{
		last_node = find_last(*stack);
		last_node->next = node;
	}
}

void	ft_clean_mat(char **mat)
{
	int	i;

	i = 0;
	while (mat[i])
	{
		free(mat[i]);
		i++;
	}
	free(mat);
}

void	ft_union(t_stack **a, char **mat, int i)
{
	if (i == 1)
		free_errors(a);
	else
	{
		ft_clean_mat(mat);
		free_errors(a);
	}
}

void	init_stack_a(t_stack **a, char **argv, int flags)
{
	long	n;
	int		i;

	i = 0;
	while (argv[i])
	{
		if (error_syntax(argv[i]))
			ft_union(a, argv, flags);
		n = ft_atoi(argv[i]);
		if (n > INT_MAX || n < INT_MIN)
			ft_union(a, argv, flags);
		if (error_duplicate((*a), (int)n))
			ft_union(a, argv, flags);
		append_node(a, (int)n);
		i++;
	}
}
