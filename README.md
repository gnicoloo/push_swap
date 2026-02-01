# 🔄 Push Swap

[![42 School](https://img.shields.io/badge/42-Firenze-00babc?style=flat-square)](https://42firenze.it/)
[![Norm](https://img.shields.io/badge/Norm-passing-success?style=flat-square)](https://github.com/42School/norminette)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)

> Un algoritmo efficiente di sorting per stack con un set limitato di operazioni

## 📋 Indice

- [Descrizione](#-descrizione)
- [Algoritmo](#-algoritmo)
- [Installazione](#-installazione)
- [Utilizzo](#-utilizzo)
- [Operazioni](#-operazioni)
- [Performance](#-performance)
- [Testing](#-testing)
- [Struttura del Progetto](#-struttura-del-progetto)
- [Autore](#-autore)

## 📖 Descrizione

**Push Swap** è un progetto della 42 School che consiste nell'ordinare una lista di numeri interi utilizzando due stack e un set limitato di operazioni. L'obiettivo è trovare la sequenza più efficiente di mosse per ordinare i numeri in ordine crescente nello stack A.

### Obiettivi del Progetto

- ✅ Implementare un algoritmo di sorting ottimizzato
- ✅ Minimizzare il numero di operazioni necessarie
- ✅ Gestire correttamente gli errori e i casi limite
- ✅ Rispettare la Norminette (standard di coding 42)

## 🧮 Algoritmo

Il progetto implementa un **algoritmo ibrido basato su chunk e insertion sort**:

### 1. **Sort per piccoli set (≤ 3 elementi)**
   - Algoritmo ottimizzato specifico per 2-3 elementi
   - Numero minimo garantito di operazioni

### 2. **Chunk-based sorting (> 3 elementi)**
   - Divisione dello stack in chunk basati sulla mediana
   - Push dei chunk in stack B in modo organizzato
   - Insertion sort ottimizzato per riportare elementi in A

### Caratteristiche principali:
- **Indicizzazione**: Ogni elemento viene indicizzato per facilitare il confronto
- **Chunk dinamici**: Il numero di chunk si adatta alla dimensione dell'input
- **Ottimizzazione delle rotazioni**: Scelta intelligente tra `ra`/`rra` basata sulla posizione

Per maggiori dettagli sull'implementazione, consulta [ALGORITHM.md](ALGORITHM.md).

## 🚀 Installazione

### Prerequisiti

- GCC compiler
- Make
- Git

### Compilazione

```bash
# Clona il repository
git clone <your-repo-url> push_swap
cd push_swap

# Compila il progetto
make

# Pulisci i file oggetto
make clean

# Pulisci tutto (incluso l'eseguibile)
make fclean

# Ricompila da zero
make re
```

## 💻 Utilizzo

### Sintassi

```bash
./push_swap <numbers>
```

### Esempi

```bash
# Esempio con numeri separati da spazi
./push_swap 4 67 3 87 23

# Esempio con numeri in una stringa
./push_swap "4 67 3 87 23"

# Esempio con numeri negativi
./push_swap -5 2 -8 15 0 42
```

### Output

Il programma stampa la sequenza di operazioni necessarie per ordinare i numeri:

```bash
$ ./push_swap 3 2 1
sa
rra
```

### Gestione Errori

Il programma stampa `"Error"` su stderr nei seguenti casi:
- ❌ Argomenti non numerici
- ❌ Numeri duplicati
- ❌ Numeri fuori dal range di INT
- ❌ Sintassi errata

## 📚 Operazioni

### Stack A e B

- `sa` : **swap a** - Scambia i primi 2 elementi dello stack a
- `sb` : **swap b** - Scambia i primi 2 elementi dello stack b
- `ss` : **swap both** - Esegue `sa` e `sb` simultaneamente

### Push

- `pa` : **push a** - Prende il primo elemento da b e lo mette in cima ad a
- `pb` : **push b** - Prende il primo elemento da a e lo mette in cima a b

### Rotate

- `ra` : **rotate a** - Sposta tutti gli elementi di a verso l'alto di 1 posizione
- `rb` : **rotate b** - Sposta tutti gli elementi di b verso l'alto di 1 posizione
- `rr` : **rotate both** - Esegue `ra` e `rb` simultaneamente

### Reverse Rotate

- `rra` : **reverse rotate a** - Sposta tutti gli elementi di a verso il basso di 1 posizione
- `rrb` : **reverse rotate b** - Sposta tutti gli elementi di b verso il basso di 1 posizione
- `rrr` : **reverse rotate both** - Esegue `rra` e `rrb` simultaneamente

## 📊 Performance

### Benchmark

| Dimensione Input | Operazioni Medie | Operazioni Max (per 100%) |
|------------------|------------------|---------------------------|
| 3 numeri         | ≤ 3              | 3                         |
| 5 numeri         | ≤ 12             | 12                        |
| 100 numeri       | ~700             | < 700 (5 punti)           |
| 500 numeri       | ~5500            | < 5500 (5 punti)          |

### Ottimizzazioni Implementate

- ✅ Indicizzazione per confronti O(1)
- ✅ Divisione in chunk dinamica
- ✅ Scelta ottimale direzione rotazione
- ✅ Minimizzazione operazioni doppie (rr, rrr, ss)

## 🧪 Testing

### Script di Test Manuale

```bash
# Test con 3 numeri casuali
ARG="4 67 3"; ./push_swap $ARG | wc -l

# Test con 5 numeri casuali
ARG="2 1 5 4 3"; ./push_swap $ARG | wc -l

# Test con 100 numeri casuali
ARG=$(seq 1 100 | shuf | tr '\n' ' '); ./push_swap $ARG | wc -l

# Test con 500 numeri casuali
ARG=$(seq 1 500 | shuf | tr '\n' ' '); ./push_swap $ARG | wc -l
```

### Validazione Sorting

Usa il checker fornito da 42 (se disponibile):

```bash
ARG="4 67 3 87 23"; ./push_swap $ARG | ./checker $ARG
```

### Test Automatizzato

Vedi [test.sh](test.sh) per uno script di testing completo.

## 📁 Struttura del Progetto

```
push_swap/
├── 📄 README.md              # Questo file
├── 📄 ALGORITHM.md           # Documentazione dettagliata algoritmo
├── 📄 CHANGELOG.md           # Storia delle modifiche
├── 📄 CONTRIBUTING.md        # Linee guida per contribuire
├── 📄 LICENSE                # Licenza MIT
├── 📄 Makefile               # Build configuration
├── 📄 test.sh                # Script di testing completo
│
├── 📂 src/                   # File sorgente
│   ├── push_swap.c           # Main program
│   ├── stack_init.c          # Inizializzazione stack
│   ├── errors_detector.c     # Gestione errori
│   ├── utils.c               # Utility functions
│   ├── util2.c               # Additional utilities
│   ├── index_list.c          # Indicizzazione elementi
│   ├── for_chunks.c          # Logica chunk-based
│   ├── insertion_sort.c      # Insertion sort ottimizzato
│   ├── push.c                # Operazioni push
│   ├── swap.c                # Operazioni swap
│   ├── rotate.c              # Operazioni rotate
│   └── reverse_rotate.c      # Operazioni reverse rotate
│
├── 📂 include/               # Header files
│   └── push_swap.h           # Header principale
│
├── 📂 obj/                   # File oggetto (generati)
│
└── 📂 libft/                 # Libreria custom 42
```

### Moduli Principali

| File | Descrizione |
|------|-------------|
| `push_swap.c` | Entry point e logica principale |
| `stack_init.c` | Parsing argomenti e inizializzazione |
| `for_chunks.c` | Algoritmo chunk-based |
| `insertion_sort.c` | Sorting finale ottimizzato |
| `index_list.c` | Sistema di indicizzazione |
| `errors_detector.c` | Validazione input |

## 👨‍💻 Autore

**Giovanni Nicolo** - [@gnicolo](https://github.com/gnicolo)
- 42 Firenze - gnicolo@student.42firenze.it

---

<div align="center">

**[⬆ Torna su](#-push-swap)**

Made with ❤️ at [42 Firenze](https://42firenze.it/)

</div>
