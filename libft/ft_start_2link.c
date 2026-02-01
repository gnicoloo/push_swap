/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_start_2link.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/14 18:55:48 by gnicolo           #+#    #+#             */
/*   Updated: 2025/06/30 17:43:51 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_start_2link(t_stack **lst)
{
	t_stack	*current;

	current = *lst;
	while (current)
	{
		if (current->next)
			current->next->prev = current;
		current = current->next;
	}
}
