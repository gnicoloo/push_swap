/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   reverse_rotate.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/18 12:53:56 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/24 18:01:45 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	reverse_rotate(t_stack **head)
{
	t_stack	*current;
	t_stack	*last;
	t_stack	*second_last;

	if (!(*head) || !(*head)->next)
		return ;
	current = *head;
	while (current->next && current->next->next)
		current = current->next;
	second_last = current;
	last = current->next;
	second_last->next = NULL;
	last->next = *head;
	*head = last;
}

void	rra(t_stack **a)
{
	reverse_rotate(a);
	ft_printf("rra\n");
}

void	rrb(t_stack **b)
{
	reverse_rotate(b);
	ft_printf("rrb\n");
}

void	rrr(t_stack **a, t_stack **b)
{
	reverse_rotate(a);
	reverse_rotate(b);
	ft_printf("rrr\n");
}
