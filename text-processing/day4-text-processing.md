# Day 4 - Text Processing

## Practice Files Created

### How to Create Files Using cat
```
cat > filename << 'EOF'
content here
EOF

cat  = create and write into file
>    = redirect output to file
EOF  = marks start and end of content
```

### sample.log - Fake Application Log File
```
2026-06-01 INFO Application started
2026-06-01 ERROR Database connection failed
2026-06-02 INFO User login successful
2026-06-02 WARNING Low memory detected
2026-06-03 ERROR Null pointer exception
2026-06-03 INFO Backup completed
2026-06-04 ERROR Timeout error
2026-06-04 INFO Application stopped

Column 1 = Date
Column 2 = Log Level (INFO/ERROR/WARNING)
Column 3 onwards = Message
```

### data.txt - Fake Employee Data File
```
Alice 25 Developer
Bob 30 Tester
Charlie 28 DevOps
Diana 35 Manager
Eve 27 Developer
Frank 32 Tester

Column 1 = Name
Column 2 = Age
Column 3 = Role
```

### duplicates.txt - File With Repeated Lines
```
apple
banana
apple
orange
banana
grape
orange
apple
```

---

## grep - Search Inside Files

### What is grep
```
grep = search for a pattern inside a file
Like Ctrl+F in a document but more powerful
```

### grep Commands
```
grep "ERROR" sample.log          # find lines containing ERROR
grep -i "error" sample.log       # case insensitive (-i ignores case)
grep -n "ERROR" sample.log       # show line numbers with matches
grep -c "ERROR" sample.log       # count matching lines only
grep -v "ERROR" sample.log       # invert - show lines WITHOUT ERROR
grep -B 2 "ERROR" sample.log     # show 2 lines Before each match
grep -A 2 "ERROR" sample.log     # show 2 lines After each match
grep "ERROR" *.log               # search all .log files
grep -r "ERROR" ~/Linux-Practice # search recursively in folder
grep -o "INFO" sample.log        # print only matched word not full line
```

### grep flags summary
```
-i  = ignore case
-n  = show line numbers
-c  = count matches
-v  = invert (show non-matching lines)
-B  = lines before match
-A  = lines after match
-o  = show only matched word
-r  = recursive search in folders
```

### grep with pipe
```
grep "INFO" sample.log | wc -l        # count how many INFO lines
grep -o "INFO" sample.log | wc -l     # count how many times INFO appears
grep "Developer" data.txt | awk '{print $1}'  # find developers, show names
```

### Difference between wc flags after grep
```
grep "INFO" sample.log | wc -w   # counts all words in matching lines = 17
grep "INFO" sample.log | wc -l   # counts how many lines matched = 4
grep -o "INFO" sample.log | wc -l # counts how many times INFO appears = 4

Use wc -l to count matching lines
Use grep -o with wc -l to count word occurrences
```

---

## awk - Extract and Process Columns

### What is awk
```
awk = extract and process specific columns from a file
Treats each line as a table with columns separated by spaces
```

### How awk sees columns
```
Alice   25   Developer
  $1    $2      $3

$1  = first column
$2  = second column
$3  = third column
$0  = entire line
NR  = current line number
NF  = total number of columns in that line
```

### awk Commands
```
awk '{print $1}' data.txt              # print column 1 (names)
awk '{print $2}' data.txt              # print column 2 (ages)
awk '{print $3}' data.txt              # print column 3 (roles)
awk '{print $1, $3}' data.txt          # print name and role
awk '{print $1 " is a " $3}' data.txt  # print with custom text
awk '{print NR, $0}' data.txt          # print with line numbers
awk 'END {print NR}' data.txt          # count total lines
awk '{print $NF}' data.txt             # print last column
```

### awk with conditions
```
awk '$2 > 28 {print $0}' data.txt   # rows where age > 28
awk '$2 < 34 {print $0}' data.txt   # rows where age < 34

Important: always verify column number first
awk '{print $1, $2, $3}' data.txt   # check columns before filtering

If column doesnt exist awk returns empty value
Empty value compared to number = 0
0 < 34 is always true = prints everything (wrong result)
Always use correct column number
```

### awk with pipe
```
awk '{print $2}' sample.log | sort | uniq -c | sort -rn
# extract log levels, sort, count each, show highest first

awk '{print $1}' data.txt | sort | uniq -c
# extract names, sort, count occurrences
```

---

## sed - Find and Replace

### What is sed
```
sed = Stream Editor
Find and replace text in files
Like Ctrl+H in a text editor but from terminal
```

### sed Commands
```
sed 's/ERROR/CRITICAL/' sample.log      # replace first occurrence per line
sed 's/ERROR/CRITICAL/g' sample.log     # replace ALL occurrences (g=global)
sed -i 's/ERROR/CRITICAL/g' sample.log  # save changes to file (-i = in place)
sed '/WARNING/d' sample.log             # delete lines containing WARNING
sed -n '3p' sample.log                  # print line 3 only
sed -n '2,5p' sample.log                # print lines 2 to 5
sed 's/^/LOG: /' sample.log             # add text at beginning (^ = start)
sed 's/$/ END/' sample.log              # add text at end ($ = end of line)
```

### Important sed flags
```
s   = substitute (find and replace)
g   = global (replace all occurrences per line)
-i  = in place (modify actual file)
-n  = silent mode (suppress all output)
d   = delete
p   = print
```

### sed -n and p work together
```
sed -n '3p' sample.log
-n = suppress everything (print nothing by default)
3p = print line 3 specifically
Together = print ONLY line 3

Without -n:
sed '3p' sample.log
= prints every line normally + prints line 3 twice
```

### Warning about sed -i
```
sed 's/ERROR/CRITICAL/g' sample.log     # file UNCHANGED - shows output only
sed -i 's/ERROR/CRITICAL/g' sample.log  # file PERMANENTLY CHANGED

Always preview without -i first
Add -i only when sure about the change
-i that deletes lines shifts all line numbers below it
```

---

## sort - Sort Lines

### sort Commands
```
sort data.txt           # alphabetical order
sort -r data.txt        # reverse alphabetical order
sort -k2 data.txt       # sort by column 2 alphabetically
sort -k2 -n data.txt    # sort by column 2 numerically
sort -rn data.txt       # reverse numerical order
```

### sort flags
```
-r  = reverse order
-n  = numerical sort (not alphabetical)
-k2 = sort by column 2
-rn = reverse numerical (highest first)
```

---

## uniq - Remove Duplicates

### What is uniq
```
uniq only removes CONSECUTIVE duplicates
Must sort first to remove ALL duplicates
```

### uniq Commands
```
uniq duplicates.txt              # remove consecutive duplicates only
sort duplicates.txt | uniq       # sort first then remove all duplicates
sort duplicates.txt | uniq -c    # count occurrences of each line
sort duplicates.txt | uniq -d    # show only duplicate lines
sort duplicates.txt | uniq -u    # show only unique lines (not duplicated)
```

### uniq flags
```
-c = count occurrences
-d = show only duplicates
-u = show only unique lines
```

---

## wc - Word Count

### wc Commands
```
wc sample.log       # shows lines, words, characters
wc -l sample.log    # lines only
wc -w sample.log    # words only
wc -c sample.log    # characters only
```

### wc flags
```
-l = lines
-w = words
-c = characters
```

---

## Pipes | - Chaining Commands

### What is a pipe
```
command1 | command2

Takes OUTPUT of command1
Sends it as INPUT to command2
```

### Pipe Examples
```
grep "ERROR" sample.log | wc -l
# find ERROR lines, count them

grep "Developer" data.txt | awk '{print $1}'
# find Developer lines, extract names only

awk '{print $2}' sample.log | sort | uniq -c | sort -rn
# extract log levels, sort, count each, show highest count first

sort -k2 -n data.txt | awk '{print $1}'
# sort by age, show names only

sort duplicates.txt | uniq -c | sort -rn
# count duplicates, show most frequent first
```

---

## Difference Between sort -r and sort -rn

### When counts are different
```
sort -r  = reverse ALPHABETICAL order
sort -rn = reverse NUMERICAL order (highest count first)

Example with duplicates.txt:
sort duplicates.txt | uniq -c | sort -r
= alphabetically reversed
  2 orange
  1 grape
  2 banana
  3 apple

sort duplicates.txt | uniq -c | sort -rn
= highest count first
  3 apple
  2 orange
  2 banana
  1 grape
```

### When counts are same
```
If all counts are 1, -r and -rn give same result
Because there is no numerical difference to sort by
```

### Rule
```
Use sort -rn = when you want highest count first (log analysis)
Use sort -r  = when you want reverse alphabetical order
```
