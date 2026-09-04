#!/bin/bash
#Functions

# Define function
greet() {
	echo "Hello $1"
	echo "Welcome to the Functions $1"
}

# Function with two parameters
addition() {
	result=$(($1+$2))
	echo "The sum of $1 and $2 is: $result"
}

# Call functions
greet "Deepthi"
greet "Alice"
addition 10 15
addition -3 -10
