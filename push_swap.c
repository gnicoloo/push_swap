/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gpirozzi <giovannipirozzi12345@gmail.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/10 15:16:58 by gpirozzi          #+#    #+#             */
/*   Updated: 2025/02/13 11:17:39 by gpirozzi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void print_stack(t_stack *stack)
{
	t_stack *current = stack;

	while (current)
	{
		printf("numero corrente: %d\n", current->nbr);
		printf("indice del numero: %d\n", current->index);
		current = current->next;
	}
	printf("\n");
}

int main(int argc, char **argv)
{
	t_stack	*a = NULL;
	t_stack	*b = NULL;
	t_stack	*tmp = NULL;
	char	**numbers;

	numbers = NULL;
	if (argc <= 1)
		return (ft_printf("Error\n"));
	else if (argc == 2)
	{
		numbers = ft_split(argv[1], ' ');
		init_stack_a(&a, numbers);
		init_stack_a(&tmp, numbers);
		int i = 0;
		while (numbers[i])
		{
			 free(numbers[i]);
			 i++;
		}
		free (numbers);
	}
	else if (argc > 2)
	{
		init_stack_a(&a, &argv[1]);
		init_stack_a(&tmp, &argv[1]);
	}
	printf("Stack A before sorting:\n");
	print_stack(a);
	print_stack(b);
	ft_index_list(&a, &tmp);
	insertion_sort(&a, &b);
	printf("Stack A after sorting:\n");
	print_stack(a);
	print_stack(tmp);
	free_stack(&a);
	free_stack(&b);
	return 0;
}

