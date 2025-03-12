/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   swap.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/07 14:29:57 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/24 17:58:20 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	swap(t_stack **head)
{
	t_stack	*first;
	t_stack	*second;

	if (!(*head) || !(*head)->next)
		return ;
	first = (*head);
	second = (*head)->next;
	first->next = second->next;
	second->next = first;
	*head = second;
}

void	sa(t_stack **a)
{
	if (!a)
		return ;
	swap(a);
	ft_printf("sa\n");
}

void	sb(t_stack **b)
{
	if (!b)
		return ;
	swap(b);
	ft_printf("sb\n");
}

void	ss(t_stack **a, t_stack **b)
{
	if (!a || !b)
		return ;
	swap(a);
	swap(b);
	ft_printf("ss\n");
}
