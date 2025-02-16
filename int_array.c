/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   int_array.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gpirozzi <giovannipirozzi12345@gmail.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/12 16:33:55 by gpirozzi          #+#    #+#             */
/*   Updated: 2025/02/12 18:01:10 by gpirozzi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* #include "push_swap.h"

void swap(int *a, int *b)
{
	int temp = *a;
	*a = *b;
	*b = temp;
}

void sorted_array(int *array, int len)
{
	int i, j;

	for (i = 0; i < len - 1; i++)
	{
		for (j = i + 1; j < len; j++)
		{
			if (array[i] > array[j])
				swap(&array[i], &array[j]);
		}
	}
}

int *init_array(t_stack *a)
{
	int *array;
	int i;
	int len;

	len = stack_len(a);
	array = malloc(sizeof(int) * len);
	if (!array)
		return (NULL);

	i = 0;
	while (a)
	{
		array[i++] = a->nbr;
		a = a->next;
	}
	sorted_array(array, len);
	return (array);
} */
