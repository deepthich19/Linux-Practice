#!/bin/bash
#string operations

name="Deepthi Kalluru"

# String length
echo "Length: ${#name}"

# Convert to uppercase
echo "uppercase: ${name^^}"

# Convert to lowercase 
echo "lowercase: ${name,,}"

# Extract substring
echo "First 6 letters:${name:0:6}"

# Replace part of string
echo "Replaced the name:${name/Deepthi/Divya}"

# Check if string is empty
empty=""
if [ -z "$empty" ]
then
	echo "String is empty"
fi

# Check if string is not empty
if [ -n "$name" ]
then
    echo "String is not empty: $name"
fi

