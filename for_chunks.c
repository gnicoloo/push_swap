/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   for_chunks.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/18 16:37:13 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/24 18:01:26 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	assign_chunk(t_stack *stack)
{
	int			size_a;
	int			chunk_size;
	t_stack		*head;
	t_stack		*max;

	head = stack;
	size_a = stack_len(stack);
	if (size_a <= 100)
		chunk_size = 20;
	else
		chunk_size = 39;
	while (stack)
	{
		stack->chunk = stack->index / chunk_size;
		stack = stack->next;
	}
	stack = head;
	max = find_max(stack);
	return (max->chunk);
}

int	find_median(t_stack *stack)
{
	int			size;
	int			i;
	int			median;
	t_stack		*tmp;

	size = stack_len(stack);
	i = 0;
	median = 0;
	if (size == 0)
		return (0);
	tmp = stack;
	while (i < size / 2)
	{
		tmp = tmp->next;
		i++;
	}
	median = tmp->nbr;
	return (median);
}

int	has_chunk(t_stack *a, int chunk)
{
	while (a)
	{
		if (a->chunk == chunk)
			return (1);
		a = a->next;
	}
	return (0);
}

int	move_chunks_to_b(t_stack **a, t_stack **b, int max_chunk)
{
	t_stack		*tmp;
	int			current_chunk;

	tmp = NULL;
	current_chunk = 0;
	if (stack_len(*a) <= 3)
	{
		sort_three(a);
		return (3);
	}
	while (*a && current_chunk < max_chunk)
	{
		tmp = (*a);
		if (tmp->chunk == current_chunk)
		{
			pb(a, b);
			if (*b && (*b)->next && (*b)->nbr < find_median(*b))
				rb(b);
		}
		else
			ra(a);
		if (!has_chunk(*a, current_chunk))
			current_chunk++;
	}
	return (0);
}
