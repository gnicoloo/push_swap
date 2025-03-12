/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   insertion_sort.c                                   :+:      :+:    :+:   */
/*													  +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/10 12:23:14 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/23 14:54:14 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	insertion_sort(t_stack **a, t_stack **b)
{
	t_stack	*min;
	int		tot_size;
	t_stack	*max;

	tot_size = stack_len(*a);
	while (stack_len(*a) > 3)
	{
		min = find_min(*a);
		move_to_top(a, min);
		pb(a, b);
	}
	sort_three(a);
	while (stack_len(*a) != tot_size)
		pa(a, b);
	while (*b)
	{
		max = find_max(*b);
		move_to_top_b(b, max);
		pa(a, b);
	}
	free_stack(b);
	free_stack(a);
}
