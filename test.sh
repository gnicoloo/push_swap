#!/bin/bash

# ============================================================================ #
#                              PUSH_SWAP TESTER                                #
# ============================================================================ #

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Program name
PUSH_SWAP="./push_swap"

# Check if push_swap exists
if [ ! -f "$PUSH_SWAP" ]; then
    echo -e "${RED}Error: $PUSH_SWAP not found. Please compile first.${RESET}"
    exit 1
fi

# ============================================================================ #
#                                  FUNCTIONS                                   #
# ============================================================================ #

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${CYAN}                    $1${RESET}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}"
}

print_test() {
    echo -e "${PURPLE}[TEST]${RESET} $1"
}

print_result() {
    local moves=$1
    local limit=$2
    local test_name=$3
    
    echo -e "  ${YELLOW}Moves:${RESET} $moves"
    
    if [ $moves -le $limit ]; then
        echo -e "  ${GREEN}✓ PASS${RESET} ($moves ≤ $limit)\n"
        return 0
    else
        echo -e "  ${RED}✗ FAIL${RESET} ($moves > $limit)\n"
        return 1
    fi
}

# ============================================================================ #
#                               ERROR TESTS                                    #
# ============================================================================ #

test_errors() {
    print_header "ERROR HANDLING TESTS"
    
    local pass=0
    local total=8
    
    # Test 1: Non-numeric argument
    print_test "Non-numeric argument"
    if $PUSH_SWAP 1 2 three 4 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 2: Duplicate numbers
    print_test "Duplicate numbers"
    if $PUSH_SWAP 1 2 3 2 4 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 3: Number too large (> INT_MAX)
    print_test "Number exceeds INT_MAX"
    if $PUSH_SWAP 2147483648 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 4: Number too small (< INT_MIN)
    print_test "Number below INT_MIN"
    if $PUSH_SWAP -2147483649 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 5: Empty string
    print_test "Empty string"
    if $PUSH_SWAP "" 2>&1 | grep -q "Error\|^$"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 6: Only spaces
    print_test "Only spaces"
    if $PUSH_SWAP "   " 2>&1 | grep -q "Error\|^$"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 7: Special characters
    print_test "Special characters"
    if $PUSH_SWAP 1 2 @ 4 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    # Test 8: Mixed valid/invalid in string
    print_test "Mixed valid/invalid in quoted string"
    if $PUSH_SWAP "1 2 abc 4" 2>&1 | grep -q "Error"; then
        echo -e "  ${GREEN}✓ PASS${RESET}\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET}\n"
    fi
    
    echo -e "${CYAN}Error Tests: $pass/$total passed${RESET}\n"
}

# ============================================================================ #
#                              IDENTITY TESTS                                  #
# ============================================================================ #

test_identity() {
    print_header "IDENTITY TESTS (Already Sorted)"
    
    local pass=0
    local total=4
    
    # Test 1: Single number
    print_test "Single number"
    local output=$($PUSH_SWAP 42 | wc -l)
    if [ $output -eq 0 ]; then
        echo -e "  ${GREEN}✓ PASS${RESET} (no moves)\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET} ($output moves)\n"
    fi
    
    # Test 2: Two sorted numbers
    print_test "Two sorted numbers"
    output=$($PUSH_SWAP 1 2 | wc -l)
    if [ $output -eq 0 ]; then
        echo -e "  ${GREEN}✓ PASS${RESET} (no moves)\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET} ($output moves)\n"
    fi
    
    # Test 3: Three sorted numbers
    print_test "Three sorted numbers"
    output=$($PUSH_SWAP 1 2 3 | wc -l)
    if [ $output -eq 0 ]; then
        echo -e "  ${GREEN}✓ PASS${RESET} (no moves)\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET} ($output moves)\n"
    fi
    
    # Test 4: Five sorted numbers
    print_test "Five sorted numbers"
    output=$($PUSH_SWAP 1 2 3 4 5 | wc -l)
    if [ $output -eq 0 ]; then
        echo -e "  ${GREEN}✓ PASS${RESET} (no moves)\n"
        ((pass++))
    else
        echo -e "  ${RED}✗ FAIL${RESET} ($output moves)\n"
    fi
    
    echo -e "${CYAN}Identity Tests: $pass/$total passed${RESET}\n"
}

# ============================================================================ #
#                              SIMPLE TESTS                                    #
# ============================================================================ #

test_simple() {
    print_header "SIMPLE TESTS (2-5 numbers)"
    
    local pass=0
    
    # Test with 2 numbers
    print_test "2 numbers (reversed)"
    local moves=$($PUSH_SWAP 2 1 | wc -l)
    if print_result $moves 1 "2 numbers"; then ((pass++)); fi
    
    # Test with 3 numbers
    print_test "3 numbers (3 2 1)"
    moves=$($PUSH_SWAP 3 2 1 | wc -l)
    if print_result $moves 3 "3 numbers"; then ((pass++)); fi
    
    print_test "3 numbers (2 3 1)"
    moves=$($PUSH_SWAP 2 3 1 | wc -l)
    if print_result $moves 3 "3 numbers"; then ((pass++)); fi
    
    # Test with 5 numbers
    print_test "5 numbers (5 4 3 2 1)"
    moves=$($PUSH_SWAP 5 4 3 2 1 | wc -l)
    if print_result $moves 12 "5 numbers"; then ((pass++)); fi
    
    print_test "5 numbers (1 5 2 4 3)"
    moves=$($PUSH_SWAP 1 5 2 4 3 | wc -l)
    if print_result $moves 12 "5 numbers"; then ((pass++)); fi
    
    echo -e "${CYAN}Simple Tests: $pass/5 passed${RESET}\n"
}

# ============================================================================ #
#                            PERFORMANCE TESTS                                 #
# ============================================================================ #

test_100() {
    print_header "PERFORMANCE TEST: 100 Numbers"
    
    local total_moves=0
    local iterations=10
    local pass=0
    
    echo -e "${YELLOW}Running $iterations iterations...${RESET}\n"
    
    for i in $(seq 1 $iterations); do
        ARG=$(seq 1 100 | shuf | tr '\n' ' ')
        local moves=$($PUSH_SWAP $ARG | wc -l)
        total_moves=$((total_moves + moves))
        
        echo -e "  Iteration $i: ${CYAN}$moves${RESET} moves"
        
        if [ $moves -lt 700 ]; then
            ((pass++))
        fi
    done
    
    local avg=$((total_moves / iterations))
    echo -e "\n${PURPLE}Average:${RESET} $avg moves"
    echo -e "${PURPLE}Success rate:${RESET} $pass/$iterations (< 700 moves)"
    
    if [ $avg -lt 700 ]; then
        echo -e "${GREEN}✓ EXCELLENT${RESET} (avg < 700)\n"
    else
        echo -e "${RED}✗ NEEDS IMPROVEMENT${RESET} (avg ≥ 700)\n"
    fi
}

test_500() {
    print_header "PERFORMANCE TEST: 500 Numbers"
    
    local total_moves=0
    local iterations=10
    local pass=0
    
    echo -e "${YELLOW}Running $iterations iterations...${RESET}\n"
    
    for i in $(seq 1 $iterations); do
        ARG=$(seq 1 500 | shuf | tr '\n' ' ')
        local moves=$($PUSH_SWAP $ARG | wc -l)
        total_moves=$((total_moves + moves))
        
        echo -e "  Iteration $i: ${CYAN}$moves${RESET} moves"
        
        if [ $moves -lt 5500 ]; then
            ((pass++))
        fi
    done
    
    local avg=$((total_moves / iterations))
    echo -e "\n${PURPLE}Average:${RESET} $avg moves"
    echo -e "${PURPLE}Success rate:${RESET} $pass/$iterations (< 5500 moves)"
    
    if [ $avg -lt 5500 ]; then
        echo -e "${GREEN}✓ EXCELLENT${RESET} (avg < 5500)\n"
    else
        echo -e "${RED}✗ NEEDS IMPROVEMENT${RESET} (avg ≥ 5500)\n"
    fi
}

# ============================================================================ #
#                                   MAIN                                       #
# ============================================================================ #

main() {
    clear
    
    echo -e "${BLUE}"
    echo "  ____            _       ____                       "
    echo " |  _ \\ _   _ ___| |__   / ___|_      ____ _ _ __   "
    echo " | |_) | | | / __| '_ \\  \\___ \\ \\ /\\ / / _\` | '_ \\  "
    echo " |  __/| |_| \\__ \\ | | |  ___) \\ V  V / (_| | |_) | "
    echo " |_|    \\__,_|___/_| |_| |____/ \\_/\\_/ \\__,_| .__/  "
    echo "                                            |_|     "
    echo -e "${RESET}\n"
    
    if [ "$1" == "errors" ]; then
        test_errors
    elif [ "$1" == "identity" ]; then
        test_identity
    elif [ "$1" == "simple" ]; then
        test_simple
    elif [ "$1" == "100" ]; then
        test_100
    elif [ "$1" == "500" ]; then
        test_500
    else
        test_errors
        test_identity
        test_simple
        test_100
        test_500
    fi
    
    print_header "TESTING COMPLETE"
}

# Run main with arguments
main "$@"
