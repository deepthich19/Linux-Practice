#!/bin/bash
# Arrays practice

# Define array
FRUITS=("apple" "banana" "orange" "grape" "mango")

# Access single element
echo "First fruit: ${FRUITS[0]}"
echo "Second fruit: ${FRUITS[1]}"
echo "Last fruit: ${FRUITS[-1]}"

# All elements
echo "All fruits: ${FRUITS[@]}"

# Array length
echo "Total fruits: ${#FRUITS[@]}"

# Loop through array
echo "--- All Fruits ---"
for FRUIT in "${FRUITS[@]}"
do
    echo "Fruit: $FRUIT"
done

# Add element
FRUITS+=("strawberry")
echo "After adding: ${FRUITS[@]}"
