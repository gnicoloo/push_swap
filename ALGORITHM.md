# 🧮 Algorithm Documentation

## Panoramica

Push Swap implementa un **algoritmo ibrido** che combina diverse strategie di sorting per ottimizzare il numero di operazioni in base alla dimensione dell'input.

## Tabella dei Contenuti

- [Strategia Generale](#strategia-generale)
- [Casi Speciali (≤ 3 elementi)](#casi-speciali--3-elementi)
- [Algoritmo Chunk-Based (> 3 elementi)](#algoritmo-chunk-based--3-elementi)
- [Indicizzazione](#indicizzazione)
- [Ottimizzazioni](#ottimizzazioni)
- [Complessità](#complessità)

---

## Strategia Generale

L'algoritmo adotta strategie diverse in base alla dimensione dell'input:

```
Input Size │ Strategy
───────────┼─────────────────────────────────
1          │ No operation needed
2          │ Single swap if needed
3          │ Optimized hard-coded cases
≤ 100      │ Chunk-based (20 elements/chunk)
> 100      │ Chunk-based (39 elements/chunk)
```

---

## Casi Speciali (≤ 3 elementi)

### 1 Elemento
- **Operazioni**: 0
- Già ordinato

### 2 Elementi
- **Operazioni**: 0-1
- Se `a[0] > a[1]`: esegui `sa`

### 3 Elementi
Algoritmo ottimizzato con massimo 2 operazioni:

```
Caso       │ Stack A  │ Operazioni
───────────┼──────────┼───────────────
1          │ 1 2 3    │ (già ordinato)
2          │ 1 3 2    │ sa, ra
3          │ 2 1 3    │ sa
4          │ 2 3 1    │ rra
5          │ 3 1 2    │ ra
6          │ 3 2 1    │ sa, rra
```

**Implementazione**:
```c
void sort_three(t_stack **a)
{
    t_stack *max = find_max(*a);
    
    if (max == *a)              // Caso 5 o 6
        ra(a);
    else if (max == (*a)->next) // Caso 2 o 4
        rra(a);
    
    if ((*a)->nbr > (*a)->next->nbr)
        sa(a);
}
```

---

## Algoritmo Chunk-Based (> 3 elementi)

### Fase 1: Indicizzazione

Prima di ordinare, ogni elemento riceve un **indice** basato sulla sua posizione nell'ordinamento finale:

```
Input:     [42, 15, -3, 100, 7]
Sorted:    [-3, 7, 15, 42, 100]
Indices:   [ 0, 1,  2,  3,   4]

Result mapping:
  42 → index 3
  15 → index 2
  -3 → index 0
 100 → index 4
   7 → index 1
```

### Fase 2: Divisione in Chunk

Gli elementi vengono divisi in **chunk** basati sul loro indice:

```c
chunk_size = (size <= 100) ? 20 : 39;
chunk_number = index / chunk_size;
```

**Esempio con 100 elementi**:
```
Chunk 0: indices  0-19  (20 elementi)
Chunk 1: indices 20-39  (20 elementi)
Chunk 2: indices 40-59  (20 elementi)
Chunk 3: indices 60-79  (20 elementi)
Chunk 4: indices 80-99  (20 elementi)
```

### Fase 3: Push Chunks to B

Processiamo i chunk dal più basso al più alto:

```
Iniziale:
Stack A: [tutti gli elementi]
Stack B: [vuoto]

Iterazione chunk 0:
  - Trova elementi con chunk == 0
  - Muovili in cima ad A (con ra/rra ottimizzato)
  - Esegui pb
  
Stack A: [elementi chunk 1-4]
Stack B: [elementi chunk 0]

... ripeti per tutti i chunk ...

Finale:
Stack A: [3 elementi più grandi]
Stack B: [tutti gli altri]
```

**Ottimizzazione della rotazione**:
```c
int position = find_index(a, node);
int size = stack_len(a);

if (position <= size / 2)
    // Usa ra (rotate forward)
else
    // Usa rra (rotate backward)
```

### Fase 4: Sort Remaining in A

Quando rimangono ≤ 3 elementi in A:
```c
sort_three(&a);
```

### Fase 5: Insertion Sort from B

Riportiamo gli elementi da B ad A in ordine decrescente:

```
while (B non vuoto):
    1. Trova il massimo in B
    2. Muovilo in cima a B (ra/rra ottimizzato)
    3. Esegui pa
    
Risultato: A ordinato in ordine crescente
```

**Pseudocodice**:
```c
while (stack_len(b) > 0)
{
    max = find_max(b);
    move_to_top(&b, max);
    pa(&a, &b);
}
```

---

## Indicizzazione

### Algoritmo di Indicizzazione

```c
void ft_index_list(t_stack **a, t_stack **tmp)
{
    t_stack *current_a;
    t_stack *current_tmp;
    int index;
    
    current_a = *a;
    while (current_a)
    {
        index = 0;
        current_tmp = *tmp;
        
        // Conta quanti elementi sono minori
        while (current_tmp)
        {
            if (current_tmp->nbr < current_a->nbr)
                index++;
            current_tmp = current_tmp->next;
        }
        
        current_a->index = index;
        current_a = current_a->next;
    }
}
```

### Vantaggi dell'Indicizzazione

1. **Confronti O(1)**: Confrontare indici invece di valori
2. **Gestione numeri negativi**: Trasparente
3. **Range normalizzato**: 0 a n-1
4. **Calcolo chunk semplificato**: Divisione diretta

---

## Ottimizzazioni

### 1. Scelta Direzione Rotazione

Sempre scegliere il percorso più breve:

```c
int position = find_index(stack, target);
int size = stack_len(stack);

if (position <= size / 2)
    // rotate: position moves
else
    // reverse_rotate: (size - position) moves
```

**Esempio**:
```
Stack: [10, 20, 30, 40, 50, 60, 70]
Target: 60 (position 5, size 7)

Opzione 1 (ra): 5 rotazioni
Opzione 2 (rra): 2 rotazioni  ← SCELTO
```

### 2. Chunk Size Dinamico

```c
chunk_size = (size <= 100) ? 20 : 39;
```

- **≤ 100**: Chunk più piccoli → più precisi
- **> 100**: Chunk più grandi → meno iterazioni

### 3. Early Sorting Check

```c
bool stack_sorted(t_stack *stack)
{
    while (stack->next)
    {
        if (stack->nbr > stack->next->nbr)
            return false;
        stack = stack->next;
    }
    return true;
}
```

Se lo stack è già ordinato → 0 operazioni.

### 4. Sort Three Ottimizzato

Invece di un albero di decisione completo, usiamo:
1. Porta il massimo in fondo (max 1 operazione)
2. Se necessario, swap i primi due (max 1 operazione)

**Totale**: massimo 2 operazioni per 3 elementi.

---

## Complessità

### Complessità Temporale

| Operazione | Complessità |
|------------|-------------|
| Indicizzazione | O(n²) |
| Assegnazione chunk | O(n) |
| Move chunks to B | O(n × log n) |
| Sort three | O(1) |
| Insertion from B | O(n × log n) |
| **Totale** | **O(n²)** |

**Nota**: Sebbene la complessità teorica sia O(n²), il numero di operazioni effettive è molto più basso grazie alle ottimizzazioni.

### Complessità Spaziale

- **Stack A**: O(n)
- **Stack B**: O(n)
- **Stack temporaneo** (per indicizzazione): O(n)
- **Totale**: O(n)

### Performance Pratica

| Input Size | Operazioni Medie | Operazioni Max |
|------------|------------------|----------------|
| 3          | 2                | 2              |
| 5          | 8-10             | 12             |
| 100        | 650-750          | ~900           |
| 500        | 4500-5500        | ~7000          |

---

## Confronto con Altri Algoritmi

| Algoritmo | Complessità Teorica | Operazioni (n=100) | Operazioni (n=500) |
|-----------|---------------------|--------------------|--------------------|
| **Chunk-based (nostro)** | O(n²) | ~700 | ~5500 |
| Quick Sort | O(n log n) | ~664 | ~4482 |
| Merge Sort | O(n log n) | ~664 | ~4482 |
| Insertion Sort | O(n²) | ~4950 | ~124750 |
| Turk Algorithm | O(n log n) | ~600 | ~4000 |

**Nota**: I numeri sono approssimativi e dipendono dall'implementazione e dall'input.

---

## Miglioramenti Futuri

### Possibili Ottimizzazioni

1. **Turk Algorithm**: Implementare l'algoritmo Turk per prestazioni ancora migliori
2. **Chunk Adattivi**: Calcolare dinamicamente il chunk size ottimale
3. **Look-ahead**: Prevedere le prossime mosse per ottimizzare le rotazioni doppie
4. **Operazioni Combinate**: Usare più spesso `rr`, `rrr`, `ss` quando possibile

### Performance Target

| Input Size | Current | Target | Improvement |
|------------|---------|--------|-------------|
| 100        | ~700    | ~550   | ~21%        |
| 500        | ~5500   | ~4000  | ~27%        |

---

## Riferimenti

- [Push Swap Subject (42)](https://cdn.intra.42.fr/pdf/pdf/960/push_swap.en.pdf)
- [Sorting Algorithms Visualization](https://visualgo.net/en/sorting)
- [Turk Algorithm](https://medium.com/@ayogun/push-swap-c1f5d2d41e97)

---

**Autore**: Giovanni Nicolo (gnicolo@student.42firenze.it)  
**Data**: Febbraio 2026  
**Versione**: 1.0
