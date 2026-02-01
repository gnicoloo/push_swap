#!/bin/bash

# ============================================================================ #
#                           PUSH SWAP SETUP SCRIPT                             #
# ============================================================================ #

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              PUSH SWAP - SETUP & VERIFICATION                 ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${RESET}\n"

# ============================================================================ #
#                            CHECK DEPENDENCIES                                #
# ============================================================================ #

echo -e "${CYAN}[1/5] Checking dependencies...${RESET}"

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "  ${GREEN}✓${RESET} $1 found"
        return 0
    else
        echo -e "  ${RED}✗${RESET} $1 not found"
        return 1
    fi
}

MISSING_DEPS=0

check_command "gcc" || MISSING_DEPS=$((MISSING_DEPS + 1))
check_command "make" || MISSING_DEPS=$((MISSING_DEPS + 1))
check_command "git" || MISSING_DEPS=$((MISSING_DEPS + 1))

if [ $MISSING_DEPS -ne 0 ]; then
    echo -e "\n${RED}Error: Missing dependencies. Please install them first.${RESET}"
    exit 1
fi

echo -e "${GREEN}All dependencies found!${RESET}\n"

# ============================================================================ #
#                              CHECK LIBFT                                     #
# ============================================================================ #

echo -e "${CYAN}[2/5] Checking libft...${RESET}"

if [ ! -d "libft" ]; then
    echo -e "${RED}Error: libft directory not found!${RESET}"
    echo -e "${YELLOW}Please make sure libft is in the project root.${RESET}"
    exit 1
fi

if [ ! -f "libft/Makefile" ]; then
    echo -e "${RED}Error: libft/Makefile not found!${RESET}"
    exit 1
fi

echo -e "${GREEN}✓ libft found${RESET}\n"

# ============================================================================ #
#                                COMPILATION                                   #
# ============================================================================ #

echo -e "${CYAN}[3/5] Compiling project...${RESET}"

make re > /dev/null 2>&1

if [ $? -eq 0 ] && [ -f "./push_swap" ]; then
    echo -e "${GREEN}✓ Compilation successful!${RESET}\n"
else
    echo -e "${RED}✗ Compilation failed!${RESET}"
    echo -e "${YELLOW}Run 'make' manually to see errors.${RESET}"
    exit 1
fi

# ============================================================================ #
#                              QUICK TESTS                                     #
# ============================================================================ #

echo -e "${CYAN}[4/5] Running quick tests...${RESET}"

# Test 1: Already sorted
echo -e "  Testing already sorted..."
RESULT=$(./push_swap 1 2 3 | wc -l)
if [ $RESULT -eq 0 ]; then
    echo -e "  ${GREEN}✓${RESET} Already sorted test: PASS"
else
    echo -e "  ${RED}✗${RESET} Already sorted test: FAIL"
fi

# Test 2: 3 numbers
echo -e "  Testing 3 numbers..."
RESULT=$(./push_swap 3 2 1 | wc -l)
if [ $RESULT -le 3 ]; then
    echo -e "  ${GREEN}✓${RESET} 3 numbers test: PASS ($RESULT moves)"
else
    echo -e "  ${RED}✗${RESET} 3 numbers test: FAIL ($RESULT moves)"
fi

# Test 3: Error handling
echo -e "  Testing error handling..."
if ./push_swap 1 2 2 2>&1 | grep -q "Error"; then
    echo -e "  ${GREEN}✓${RESET} Error handling: PASS"
else
    echo -e "  ${RED}✗${RESET} Error handling: FAIL"
fi

echo ""

# ============================================================================ #
#                               VERIFICATION                                   #
# ============================================================================ #

echo -e "${CYAN}[5/5] Verifying project structure...${RESET}"

check_file() {
    if [ -f "$1" ]; then
        echo -e "  ${GREEN}✓${RESET} $1"
        return 0
    else
        echo -e "  ${RED}✗${RESET} $1 (missing)"
        return 1
    fi
}

check_file "README.md"
check_file "ALGORITHM.md"
check_file "Makefile"
check_file "test.sh"
check_file "src/push_swap.c"
check_file "include/push_swap.h"

echo ""

# ============================================================================ #
#                               SUMMARY                                        #
# ============================================================================ #

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}                    ✓ SETUP COMPLETE!                          ${RESET}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}\n"

echo -e "${YELLOW}Quick start:${RESET}"
echo -e "  • Run a test:     ${CYAN}./push_swap 4 67 3 87 23${RESET}"
echo -e "  • Run all tests:  ${CYAN}./test.sh${RESET}"
echo -e "  • Run benchmark:  ${CYAN}make bench${RESET}"
echo -e "  • Show help:      ${CYAN}make help${RESET}"
echo ""

echo -e "${YELLOW}Documentation:${RESET}"
echo -e "  • README:         ${CYAN}cat README.md${RESET}"
echo -e "  • Algorithm:      ${CYAN}cat ALGORITHM.md${RESET}"
echo -e "  • Quick start:    ${CYAN}cat QUICKSTART.md${RESET}"
echo ""

echo -e "${GREEN}Happy sorting! 🚀${RESET}\n"
