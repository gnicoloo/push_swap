/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gnicolo <gnicolo@student.42firenze.it>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/10 15:16:58 by gnicolo           #+#    #+#             */
/*   Updated: 2025/02/28 16:02:34 by gnicolo          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	print_stack(t_stack *stack)
{
	t_stack	*current;

	current = stack;
	while (current)
	{
		ft_printf("numero corrente: %d\n", current->nbr);
		ft_printf("indice del numero: %d\n", current->index);
		current = current->next;
	}
	ft_printf("\n");
}

static void	ft_clean_matrix(char **matrix)
{
	int	i;

	i = 0;
	while (matrix[i])
	{
		free(matrix[i]);
		i++;
	}
	free(matrix);
}

static void	ft_bank_data(t_stack **a, t_stack **tmp, char **numbers, int flags)
{
	if (flags == 1)
	{
		init_stack_a(a, numbers, 0);
		init_stack_a(tmp, numbers, 0);
		ft_clean_matrix(numbers);
	}
	else
	{
		init_stack_a(a, numbers, 1);
		init_stack_a(tmp, numbers, 1);
	}
}

int	main(int argc, char **argv)
{
	t_stack		*a;
	t_stack		*b;
	t_stack		*tmp;
	char		**numbers;
	int			max_chunk;

	a = NULL;
	b = NULL;
	tmp = NULL;
	if (argc <= 1)
		return (ft_printf("\n"));
	else if (argc == 2)
	{
		numbers = ft_split(argv[1], ' ');
		ft_bank_data(&a, &tmp, numbers, 1);
	}
	else if (argc > 2)
		ft_bank_data(&a, &tmp, &argv[1], 0);
	if (stack_sorted(a))
		return (free_stack(&a), free_stack(&b), free_stack(&tmp), 0);
	ft_index_list(&a, &tmp);
	max_chunk = assign_chunk(a);
	if (move_chunks_to_b(&a, &b, max_chunk) == 3)
		return (free_stack(&a), free_stack(&b), 0);
	return (insertion_sort(&a, &b), 0);
}
