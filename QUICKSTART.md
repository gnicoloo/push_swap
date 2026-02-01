# 🎯 Push Swap - Quick Start Guide

## Installazione Rapida

```bash
# 1. Clona il repository
git clone <your-repo-url> push_swap
cd push_swap

# 2. Compila
make

# 3. Esegui
./push_swap 4 67 3 87 23
```

## Test Rapido

```bash
# Test automatico completo
./test.sh

# Test specifici
make test100
make test500
make bench
```

## Comandi Essenziali

| Comando | Descrizione |
|---------|-------------|
| `make` | Compila il progetto |
| `make clean` | Rimuove file oggetto |
| `make fclean` | Rimuove tutto |
| `make re` | Ricompila da zero |
| `make test100` | Test con 100 numeri |
| `make bench` | Esegui tutti i test |
| `make help` | Mostra aiuto |

## Esempi

```bash
# Semplice
./push_swap 2 1 3

# Con numeri negativi
./push_swap -5 2 -8 15 0 42

# Con stringa quotata
./push_swap "4 67 3 87 23"

# Test performance
ARG=$(seq 1 100 | shuf | tr '\n' ' ')
./push_swap $ARG | wc -l
```

## Documentazione

- 📖 [README completo](README.md)
- 🧮 [Documentazione Algoritmo](ALGORITHM.md)
- 📝 [Changelog](CHANGELOG.md)
- 🤝 [Contributing](CONTRIBUTING.md)

## Performance Target

- ✅ 3 numeri: ≤ 3 mosse
- ✅ 5 numeri: ≤ 12 mosse
- ✅ 100 numeri: < 700 mosse (5 punti)
- ✅ 500 numeri: < 5500 mosse (5 punti)

---

**42 Firenze** | Made by gnicolo
