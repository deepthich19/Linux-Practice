# Day 8 - Shell Scripting (Validation, Reporting, Automation)

## Quoting Variables

```
Always quote variable expansions: "$1" not $1

Unquoted "$1" with no argument passed becomes [ -d ]
                which test reads as true — false "exists"

Unquoted "$1" with a space in it splits into two words
                and breaks the command
```

Rule: quote every variable expansion unless there's a specific reason not to.

---

## Exit Codes

```
Every command returns a number when it finishes
0 = success, non-zero = failure
Check it with: echo $?

A script with no exit statement in its failure branch
                still exits 0 (from the last command run, e.g. echo)

This breaks chaining:
./check.sh folder && rm -rf folder/*
                runs rm even when the check "failed", if exit code was never set
```

Rule: always add `exit 1` in every failure branch.

---

## Debugging Habit — Environment Before Code

```
Before editing a script in response to unexpected output, run:
pwd

Confirm:
Where am I right now?
Does the path I'm passing actually resolve from here?
```

Most "broken script" mistakes this week were actually wrong-directory mistakes, not logic bugs.

---

## Absolute vs Relative Paths

```
Absolute path — starts with /
/home/deepthi/Linux-Practice/file1.txt
                always points to the same place, regardless of current directory

Relative path — no leading /
Linux-Practice/file1.txt
                resolved from pwd — changes meaning depending on where you run it
```

Rule: anything that will run unattended (cron, scheduled jobs) must use absolute paths only.

---

## File Tests

```
-z "$var"     true if the string is empty
-f "$path"    true if it exists AND is a regular file (false for directories)
-d "$path"    true if it exists AND is a directory (false for files)
```

---

## Redirect Operators

```
>     overwrite — wipes the file first, then writes new output
>>    append — adds to the end, keeps what's already there
```

```bash
echo "First line" > demo.txt     # demo.txt: First line
echo "second line" > demo.txt    # demo.txt: second line (First line is gone)
echo "First line" >> demo.txt    # demo.txt: second line / First line (both kept)
```

---

## Counting File Extensions

```bash
ls "$1" | grep -oP '\.[^.]+$' | sort | uniq -c
```

```
ls "$1"                 lists filenames only
grep -oP '\.[^.]+$'     -o prints only the match, -P enables the pattern,
                        '\.[^.]+$' = a dot, then non-dot chars, to end of line
sort                    required before uniq — it only merges ADJACENT duplicates
uniq -c                 counts occurrences of each unique line
```

---

## tee — Avoiding Duplicated Pipelines

```bash
ls "$1" | grep -oP '\.[^.]+$' | sort | uniq -c | tee report_$timestamp.log
```

```
tee prints to the screen AND writes to a file, from one pipeline
              — avoids writing the same command twice (once bare, once with >)
```

---

## file_report.sh — Final Script

```bash
#!/bin/bash
if [ -z "$1" ]; then
    echo "Please provide the arguments"
    exit 1
fi

if [ -d "$1" ]; then
    echo "$1 directory exists"
else
    echo "The directory you are looking for doesn't exist"
    exit 1
fi

timestamp=$(date +%Y-%m-%d)
ls "$1" | grep -oP '\.[^.]+$' | sort | uniq -c | tee /home/deepthi/Linux-Practice/shell-scripts/report_$timestamp.log
```

Validates input, counts extensions, logs with a timestamp. Log path is absolute — required for cron (see below).

---

## log-analyzer.sh — Final Script

```bash
#!/bin/bash
log="$1"
if [ -z "$log" ]; then
    echo "Error: no file provided"
    exit 1
fi

if [ ! -f "$log" ]; then
    echo "Error: '$log' does not exist"
    exit 1
fi

echo "Total lines: $(wc -l < "$log")"
echo "Error count: $(grep -c "ERROR" "$log")"
echo "Warning count: $(grep -c "WARNING" "$log")"
```

```
grep -c "PATTERN" file    counts matching LINES, not total matches
wc -l < file               the < redirect drops the filename from the output
                            needed so echo "Total lines: $(...)" prints cleanly
```

---

## backup.sh — Final Script

```bash
#!/bin/bash
src="$1"
if [ -z "$src" ]; then
    echo "Please provide the arguments"
    exit 1
fi

if [ -d "$src" ]; then
    echo "Directory exists"
else
    echo "Directory does not exist"
    exit 1
fi

mkdir -p ~/backups
timestamp=$(date +%y-%m-%d)
tar -czf ~/backups/backup_$timestamp.tar.gz "$src"
```

```
tar -czf destination source     -c create, -z compress, -f filename follows
mkdir -p                        creates missing parent folders,
                                 no error if the folder already exists
```

Don't assume a destination folder exists just because it does on your machine right now — the script must create it.

---

## Cron — Scheduling + The Relative-Path Bug

```
crontab -e      opens the cron editor
crontab -l      lists current jobs

minute  hour  day-of-month  month  day-of-week
00      09    *             *      *          = every day at 9:00 AM
```

```bash
00 09 * * * /home/deepthi/Linux-Practice/shell-scripts/file_report.sh /home/deepthi/Linux-Practice/shell-scripts/test
```

Real bug found: `file_report.sh` wrote its log with a relative filename (`report_$timestamp.log`). Worked fine run manually from inside `shell-scripts/` — but cron's working directory is the home folder, not the script's folder. The 9 AM job silently wrote the log to `~/report_2026-09-17.log` instead.

Fix: use the full absolute path for every path inside a script, not just the paths used to invoke it.

```
Confirmed the exact cron run with hard evidence, not memory:
ls -l --time-style=full-iso <file>
```

---

## .gitignore — Repo Cleanup

```
*.log
shell-scripts/test/
```

```
.gitignore only stops NEW files from being tracked going forward
                it does not remove files already committed
                (that needs: git rm --cached <file>)
```

---

## Git — Commit and Push

```bash
git add .
git commit -m "Day 8: file_report.sh, log-analyzer.sh, backup.sh, cron job, .gitignore"
git push
```
