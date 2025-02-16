/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   insertion_sort.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gpirozzi <giovannipirozzi12345@gmail.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/10 12:23:14 by gpirozzi          #+#    #+#             */
/*   Updated: 2025/02/12 11:29:14 by gpirozzi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	insertion_sort(t_stack **a, t_stack **b)
{
	t_stack	*min;

	while (stack_len(*a) > 3)
	{
		min = find_min(*a);
		move_to_top(a, min);
		pb(a, b);
	}
	sort_three(a);
	while(*b)
		pa(a, b);
}
