# 🏗️ Architecture Documentation

## Panoramica dell'Architettura

Push Swap segue un'architettura modulare con separazione chiara delle responsabilità.

```
┌─────────────────────────────────────────────────────────┐
│                      MAIN (push_swap.c)                 │
│              Entry Point & Flow Control                 │
└────────────┬─────────────────────────────┬──────────────┘
             │                             │
    ┌────────▼─────────┐         ┌────────▼──────────┐
    │  Initialization  │         │  Error Detection   │
    │  stack_init.c    │         │ errors_detector.c  │
    └────────┬─────────┘         └────────────────────┘
             │
    ┌────────▼─────────┐
    │  Indexing Layer  │
    │  index_list.c    │
    └────────┬─────────┘
             │
    ┌────────▼─────────────────────────────────────┐
    │          Sorting Strategy Selector           │
    │  (≤3: sort_three, >3: chunk-based)          │
    └────────┬─────────────────────────────────────┘
             │
    ┌────────▼─────────┐         ┌─────────────────┐
    │   Chunk-Based    │         │ Insertion Sort  │
    │  for_chunks.c    │────────▶│insertion_sort.c │
    └────────┬─────────┘         └─────────────────┘
             │
    ┌────────▼─────────────────────────────────────┐
    │           Stack Operations Layer             │
    │  push.c, swap.c, rotate.c, reverse_rotate.c  │
    └──────────────────────────────────────────────┘
```

---

## Moduli e Responsabilità

### 📁 Core Module

#### `push_swap.c` - Main Program
**Responsabilità**: Entry point e orchestrazione del flusso

```c
main()
├── Validazione argomenti
├── Inizializzazione stack
├── Check se già ordinato
├── Scelta strategia (≤3 o >3)
└── Cleanup memoria
```

**Funzioni principali**:
- `main()`: Entry point
- `print_stack()`: Debug utility (può essere rimossa)
- `ft_bank_data()`: Gestione dati iniziali

---

### 🔧 Initialization Module

#### `stack_init.c` - Stack Initialization
**Responsabilità**: Parsing input e creazione stack iniziale

```c
init_stack_a()
├── Parse argomenti (singoli o stringa)
├── Converti in numeri interi
├── Valida ogni numero
├── Crea nodi dello stack
└── Ritorna stack inizializzato
```

**Strutture dati**:
```c
typedef struct s_stack {
    int             nbr;        // Valore numerico
    int             index;      // Posizione nell'ordinamento
    int             chunk;      // Gruppo di appartenenza
    struct s_stack  *next;      // Puntatore al prossimo nodo
} t_stack;
```

---

### ⚠️ Error Handling Module

#### `errors_detector.c` - Input Validation
**Responsabilità**: Validazione input e gestione errori

**Controlli implementati**:
1. **Sintassi**: Solo numeri, spazi, segni +/-
2. **Range**: INT_MIN ≤ numero ≤ INT_MAX
3. **Duplicati**: Nessun numero ripetuto
4. **Formato**: Parsing corretto

```c
error_syntax()      // Valida formato numerico
error_duplicate()   // Controlla duplicati
free_errors()       // Cleanup in caso di errore
free_stack()        // Libera memoria stack
```

---

### 📊 Indexing Module

#### `index_list.c` - Element Indexing
**Responsabilità**: Assegnazione indici per confronti efficienti

```c
ft_index_list(stack_a, stack_tmp)
├── Per ogni elemento in A
│   ├── Conta quanti elementi sono minori
│   └── Assegna indice = conteggio
└── Ritorna stack con indici
```

**Vantaggio**: Confronti O(1) invece di confrontare valori diretti

**Esempio**:
```
Input:  [42, 15, -3, 100, 7]
Indici: [ 3,  2,  0,   4, 1]
```

---

### 🎯 Sorting Strategy Modules

#### `for_chunks.c` - Chunk-Based Sorting
**Responsabilità**: Divisione e spostamento chunk

**Pipeline**:
```c
assign_chunk()          // Calcola chunk per ogni elemento
├── Determina chunk_size (20 o 39)
└── chunk = index / chunk_size

move_chunks_to_b()      // Sposta chunk da A a B
├── Per ogni chunk (0 a max)
│   ├── Trova elementi del chunk
│   ├── Muovi in cima
│   └── Esegui pb
└── Lascia 3 elementi in A
```

**Ottimizzazioni**:
- Chunk size dinamico
- Rotazione bidirezionale ottimizzata
- Early exit se ≤3 elementi

#### `insertion_sort.c` - Final Sorting
**Responsabilità**: Ordinamento finale da stack B

```c
insertion_sort()
├── Mentre A > 3
│   ├── Trova minimo in A
│   ├── Muovi in cima
│   └── pb
├── sort_three(A)
└── Mentre B non vuoto
    ├── Trova massimo in B
    ├── Muovi in cima
    └── pa
```

---

### 🔄 Operations Module

#### `push.c` - Push Operations
```c
pa()  // Push da B ad A
pb()  // Push da A a B
```

#### `swap.c` - Swap Operations
```c
sa()  // Swap primi 2 di A
sb()  // Swap primi 2 di B
ss()  // Esegui sa + sb
```

#### `rotate.c` - Rotate Operations
```c
ra()  // Ruota A verso l'alto
rb()  // Ruota B verso l'alto
rr()  // Esegui ra + rb
```

#### `reverse_rotate.c` - Reverse Rotate Operations
```c
rra()  // Ruota A verso il basso
rrb()  // Ruota B verso il basso
rrr()  // Esegui rra + rrb
```

**Pattern comune**:
1. Manipola lo stack
2. Stampa l'operazione su stdout
3. Ritorna

---

### 🛠️ Utilities Module

#### `utils.c` - Core Utilities
**Funzioni helper fondamentali**:

```c
find_min()          // Trova nodo con valore minimo
find_max()          // Trova nodo con valore massimo
find_last()         // Trova ultimo nodo
stack_len()         // Conta elementi
stack_sorted()      // Controlla se ordinato
sort_three()        // Ordina 3 elementi ottimizzato
```

#### `util2.c` - Additional Utilities
**Funzioni di movimento**:

```c
move_to_top()       // Porta nodo in cima ad A
move_to_top_b()     // Porta nodo in cima a B
find_index()        // Trova posizione di un nodo
```

**Ottimizzazione rotazione**:
```c
if (position <= size / 2)
    use ra/rb        // Rotazione forward
else
    use rra/rrb      // Rotazione backward
```

---

## Flusso di Esecuzione

### Caso 1: Input ≤ 3 elementi

```
main()
  └─> init_stack_a()
       └─> Validazione input
            └─> sort_three()
                 ├─> Porta massimo in fondo
                 └─> Se necessario, swap primi due
                      └─> Output operazioni
```

### Caso 2: Input > 3 elementi

```
main()
  └─> init_stack_a()
       └─> Validazione input
            └─> ft_index_list()
                 └─> Assegna indici
                      └─> assign_chunk()
                           └─> Calcola chunk
                                └─> move_chunks_to_b()
                                     ├─> Per ogni chunk
                                     │    └─> Sposta in B
                                     └─> insertion_sort()
                                          ├─> Ordina A (3 elementi)
                                          └─> Riporta da B ad A
                                               └─> Output operazioni
```

---

## Design Patterns

### 1. Strategy Pattern
Selezione algoritmo basata su dimensione input:
```c
if (size <= 3)
    sort_three();
else
    chunk_based_sort();
```

### 2. Iterator Pattern
Navigazione liste linkate:
```c
while (node) {
    process(node);
    node = node->next;
}
```

### 3. Factory Pattern
Creazione nodi stack:
```c
new_node = malloc(sizeof(t_stack));
initialize(new_node, value);
add_to_stack(new_node);
```

---

## Gestione Memoria

### Allocazioni
```c
Stack A:  malloc per ogni nodo
Stack B:  malloc per ogni nodo
Stack tmp: malloc per indicizzazione (liberato dopo)
```

### Deallocazioni
```c
free_stack()
├─> Per ogni nodo
│    └─> free(nodo)
└─> stack = NULL
```

**Punti critici**:
- ✅ Libera memoria in caso di errore
- ✅ Libera stack tmp dopo indicizzazione
- ✅ Libera entrambi gli stack alla fine

---

## Performance Considerations

### Complessità per Modulo

| Modulo | Operazione | Complessità |
|--------|-----------|-------------|
| `stack_init` | Inizializzazione | O(n) |
| `index_list` | Indicizzazione | O(n²) |
| `for_chunks` | Divisione chunk | O(n) |
| `move_chunks_to_b` | Spostamento | O(n log n) |
| `insertion_sort` | Sorting finale | O(n log n) |
| **Totale** | | **O(n²)** |

### Ottimizzazioni Implementate

1. **Indicizzazione**: Confronti O(1)
2. **Chunk dinamici**: Adattamento al size
3. **Rotazione bidirezionale**: Scelta percorso più breve
4. **Sort three ottimizzato**: Max 2 operazioni

---

## Testing Strategy

### Unit Tests (ideale)
```
errors_detector.c → Test validazione input
index_list.c      → Test assegnazione indici
for_chunks.c      → Test calcolo chunk
utils.c           → Test funzioni helper
```

### Integration Tests
```
test.sh → Test end-to-end completi
```

---

## Estensibilità

### Per aggiungere nuovi algoritmi:

1. Crea nuovo file in `src/`
2. Dichiara funzioni in `include/push_swap.h`
3. Integra in `push_swap.c` con strategy pattern
4. Aggiungi test in `test.sh`

### Esempio: Turk Algorithm
```c
// src/turk_algorithm.c
void turk_sort(t_stack **a, t_stack **b)
{
    // Implementazione
}

// push_swap.c
if (size <= 3)
    sort_three(a);
else if (size <= 100)
    chunk_based_sort(a, b);
else
    turk_sort(a, b);
```

---

## Debugging

### Funzioni Debug (commentate in produzione)
```c
print_stack()     // Stampa contenuto stack
print_indices()   // Stampa indici
print_chunks()    // Stampa assegnazione chunk
```

### Valgrind Check
```bash
valgrind --leak-check=full ./push_swap 4 67 3 87 23
```

---

**Autore**: Giovanni Nicolo  
**Versione**: 2.0  
**Data**: Febbraio 2026
