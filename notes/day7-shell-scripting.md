# Day 7 - Shell Scripting Basics

## What is a Shell Script
```
A shell script = a text file containing Linux commands
                 that run automatically in sequence

Instead of typing commands one by one manually
Write them once in a script
Run the script = all commands execute automatically
```

---

## Shebang Line
```
#!/bin/bash

Must be FIRST line of every script
Tells Linux which interpreter to use
/bin/bash = use bash shell to run this script

Without shebang = Linux doesnt know how to run the script
```

---

## Comments
```
# This is a comment
= Lines starting with # are ignored by bash
= Use comments to explain what your script does
= Good habit for readability
```

---

## Why chmod +x is Needed
```
New files have no execute permission by default
chmod +x = add execute permission to owner
Without it: bash: ./script.sh: Permission denied
```

## Why ./ Before Script Name
```
./ = run from current directory
Without ./ Linux looks in system PATH for the command
Your script is not in PATH
So ./ tells Linux exactly where to find it
```

---

## Variables

### Defining and Using Variables
```bash
# Defining - no $ sign, no spaces around =
NAME="Deepthi"
AGE=25
CITY="Hyderabad"

# Using - always $ before variable name
echo $NAME
echo $AGE
echo "I live in $CITY"
```

### Variable Rules
```
NAME="Deepthi"    ✅ correct
NAME = "Deepthi"  ❌ wrong - no spaces around =
$NAME             = use variable ($ prefix)
NAME              = just the word NAME (no $)

Variables are case sensitive:
$NAME ≠ $name ≠ $Name
```

### Command Substitution in Variables
```bash
CURRENTDATE=$(date)    # runs date command, stores output
USERNAME=$(whoami)     # runs whoami, stores output
echo "Date: $CURRENTDATE"
echo "User: $USERNAME"
```

### User Input
```bash
echo "Enter your name:"
read USERNAME           # waits for user to type, stores in USERNAME
echo "Hello $USERNAME"
```

### $() vs $(())
```
$()   = command substitution - runs a COMMAND
        USERNAME=$(whoami)   runs whoami command

$(()) = arithmetic - does MATH
        RESULT=$((5 + 3))   calculates 8

One bracket  = command
Two brackets = math/calculation
```

---

## Conditions - if else

### Structure
```bash
if [ condition ]
then
    commands if true
else
    commands if false
fi

fi = closes the if block (if written backwards)
```

### Common Mistakes
```bash
if [$age -gt 18]      # ❌ no spaces inside brackets
if [ $age -gt 18 ]    # ✅ spaces required after [ and before ]

[ is a command itself - needs space after it
```

### Number Comparison Operators
```
-gt = greater than        ( > )
-lt = less than           ( < )
-ge = greater than equal  ( >= )
-le = less than equal     ( <= )
-eq = equal to            ( == )
-ne = not equal           ( != )
```

### String Comparison
```
=  = equal
!= = not equal
```

### File Test Operators
```
-f = is a regular file and exists
-d = is a directory and exists
-e = exists (file or directory)
-r = file exists and is readable
-w = file exists and is writable
-x = file exists and is executable
-s = file exists and is not empty

-f vs -e:
-e = exists as anything (file or directory)
-f = exists specifically as a regular file (not directory)
```

### Examples
```bash
# Number check
if [ $AGE -gt 18 ]
then
    echo "Adult"
else
    echo "Minor"
fi

# File check
if [ -f hello.sh ]
then
    echo "file exists"
fi

# Directory check
if [ -d notes ]
then
    echo "directory exists"
fi
```

---

## Loops

### For Loop - Through List
```bash
for NAME in Alice Bob Charlie
do
    echo "Hello $NAME"
done
```

### For Loop - Through Numbers
```bash
for i in 1 2 3 4 5
do
    echo "Number: $i"
done
```

### While Loop
```bash
COUNT=1
while [ $COUNT -le 5 ]
do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))
done
```

### Loop Structure
```
for VARIABLE in list    while [ condition ]
do                      do
    commands                commands
done                    done

do   = start of loop body
done = end of loop body
```

### Common Mistake in While Loop
```bash
while [ count -le 6 ]    # ❌ wrong - count is just a word
while [ $count -le 6 ]   # ✅ correct - $count is the variable value

Rule: Every time you READ a variable = use $
      Every time you SET a variable  = no $
```

### Arithmetic in Bash
```bash
COUNT=$((COUNT + 1))   # add 1
COUNT=$((COUNT - 1))   # subtract 1
COUNT=$((COUNT * 2))   # multiply
COUNT=$((COUNT / 2))   # divide
COUNT=$((COUNT % 3))   # remainder

$(( )) = arithmetic expression
Always wrap math inside $(( ))
```

### How COUNT=$((COUNT + 1)) Works
```
COUNT=1
COUNT=$((COUNT + 1))
= take current value of COUNT (1)
= add 1
= store result back into COUNT
= COUNT is now 2

Without $(()) bash treats it as text not math
COUNT=COUNT+1 would store the string "COUNT+1" not the number 2
```

---

## Functions

### Structure
```bash
# Define function
function_name() {
    commands
}

# Call function
function_name argument1 argument2
```

### Function Parameters
```
$1 = first argument passed to function
$2 = second argument passed to function
$0 = script name itself
$# = total number of arguments passed
```

### Example
```bash
greet() {
    echo "Hello $1!"
}

add_numbers() {
    RESULT=$(($1 + $2))
    echo "Sum of $1 and $2 = $RESULT"
}

greet "Deepthi"       # $1 = Deepthi
add_numbers 10 20     # $1 = 10, $2 = 20
```

---

## echo Command
```bash
echo "Hello World"          # print text
echo "Name: $NAME"          # print with variable
echo "Date: $(date)"        # print with command output
echo "================================"  # print separator line
```

---

## read Command
```bash
read USERNAME     # wait for user input, store in USERNAME

echo "Enter name:"
read NAME         # user types, stored in NAME
echo "Hello $NAME"
```

### read vs hardcoded value
```bash
read age      # gets value FROM user at runtime
age=25        # sets value directly in script

Never use both for same variable one after another
Second one always overwrites the first
```

---

## Common Mistakes Summary
```
1. Missing space after echo
   echo"text"       ❌
   echo "text"      ✅

2. Missing $ when using variable
   echo name        ❌ prints word "name"
   echo $name       ✅ prints variable value

3. Spaces around = when defining variable
   NAME = "Deepthi" ❌
   NAME="Deepthi"   ✅

4. Missing spaces inside [ ]
   if [$age -gt 18] ❌
   if [ $age -gt 18 ] ✅

5. Missing $ in while condition
   while [ count -le 5 ] ❌
   while [ $count -le 5 ] ✅

6. Using $() for math instead of $(())
   RESULT=$(5 + 3)    ❌
   RESULT=$((5 + 3))  ✅
```

---

## Scripts Practiced Today
```
hello.sh       = first script, echo, command substitution
variables.sh   = defining, using, reading variables
conditions.sh  = if else, number comparison, file checks
loops.sh       = for loop list, for loop numbers, while loop
functions.sh   = define function, parameters, call function
system-info.sh = practical script combining all concepts
```
