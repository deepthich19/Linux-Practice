# Day 5 - Process Management

## What is a Process
```
Every program running on Linux is a process
When you open terminal, run a command or start an app = Linux creates a process
Each process gets a unique PID (Process ID)
Process starts = PID assigned
Process ends = PID released
```

---

## ps - Process Snapshot

### What ps does
```
ps = snapshot of processes at that moment
Not live - just a single moment capture
```

### ps commands
```
ps                    # processes in current terminal only
ps aux                # ALL processes on entire system
ps aux | grep nano    # find specific process by name
ps -u deepthi         # processes by specific user
```

### ps output explained
```
PID    TTY      TIME     CMD
10107  pts/0    00:00:00  bash
10176  pts/0    00:00:00  ps

PID     = unique process ID number
TTY     = which terminal window process is running in
          pts/0 = first terminal window
          pts/1 = second terminal window
TIME    = how much CPU time process consumed (not how long running)
CMD     = name of the command running
```

### ps aux output explained
```
USER    PID   %CPU  %MEM  VSZ   RSS  TTY  STAT  START  TIME  COMMAND

USER    = who started the process
PID     = unique process ID
%CPU    = how much CPU it is using
%MEM    = how much RAM it is using
STAT    = process state
START   = when process started
TIME    = total CPU time consumed
COMMAND = full command that is running
```

### Process States (STAT column)
```
S = Sleeping - waiting for something
R = Running - actively using CPU
Z = Zombie - finished but not cleaned up
T = Stopped - suspended/paused
```

### Why plain ps shows only 2 processes
```
ps without options shows ONLY processes in current terminal
bash  = shell keeping terminal alive - always running
ps    = the ps command itself

ps captures itself in output because it was running
when snapshot was taken
By the time you see output, ps process is already gone
```

---

## ps aux | grep process | grep -v grep

### Why grep finds itself
```
ps aux | grep nano

ps aux captures ALL processes including grep command itself
grep's own command = "grep --color=auto nano"
word "nano" exists inside grep's own command
grep finds itself as a match = unwanted result
```

### Fix with grep -v grep
```
ps aux | grep nano | grep -v grep

Step 1: ps aux = list all processes
Step 2: grep nano = filter lines with "nano"
        Result:
        deepthi 1234 nano testfile.txt      ← actual nano
        deepthi 2790 grep --color=auto nano ← grep itself
Step 3: grep -v grep = remove lines containing "grep"
        Result:
        deepthi 1234 nano testfile.txt      ← only real nano remains

Always use | grep -v grep when searching for processes
```

---

## top - Live Process Monitor

```
top = live updating process viewer
Updates every 3 seconds
Like Task Manager in Windows
```

### Controls inside top
```
q = quit
k = kill a process (asks for PID)
M = sort by memory usage
P = sort by CPU usage
u = filter by username
```

---

## htop - Better Version of top

```
sudo apt install htop -y
htop

Color coded, easier to read than top
Arrow keys to navigate
F9 to kill a process
q to quit
```

---

## kill - Stop a Process

```
kill PID        # gracefully stop process (SIGTERM)
kill -9 PID     # force kill immediately (SIGKILL)
kill -l         # list all kill signals
```

### Kill signals explained
```
kill -1  PID = SIGHUP  - reload configuration
kill -2  PID = SIGINT  - same as Ctrl+C
kill -9  PID = SIGKILL - force kill, cannot be ignored
kill -15 PID = SIGTERM - graceful stop (default)
```

### Rule for killing processes
```
Always try kill PID (SIGTERM) first
Only use kill -9 if process doesnt stop
kill -9 = hard kill with no cleanup
```

---

## killall and pkill

```
killall firefox      # kill all processes named firefox
killall -9 firefox   # force kill all firefox processes
pkill nano           # kill process matching name
pkill -u deepthi     # kill all processes by specific user
```

---

## Background and Foreground

### & symbol - Run in Background
```
command &   = start command in background
            = terminal stays free
            = you can type other commands
```

### Why & doesnt work with interactive programs
```
nano file.txt &   = auto stopped

nano needs keyboard and screen to work
Background has no terminal to interact with
Linux automatically suspends it = shows Stopped

& works fine for:
sleep 100 &        = just waits, needs no input
python script.py & = runs script, needs no keyboard

& does NOT work for:
nano file.txt &    = needs keyboard = auto stopped
vim file.txt &     = same problem
```

### Correct way to practice background
```
sleep 100 &    # runs silently in background
jobs           # shows it running, not stopped
fg             # brings it back to foreground
Ctrl+C         # kills it
```

### jobs - See Background Jobs
```
jobs

Output:
[1]+  Stopped    nano file.txt

[1]  = job number
+    = most recent job
-    = second most recent job
Stopped = suspended/paused not running not dead
```

### When two jobs exist
```
[1]-  Stopped    nano file.txt   ← older job, - symbol
[2]+  Stopped    nano file.txt   ← newest job, + symbol
```

### fg and bg
```
fg        # bring most recent job to foreground
fg %1     # bring job number 1 to foreground
bg        # resume suspended job in background
```

### Ctrl+Z vs Ctrl+C vs &
```
Ctrl+C  = kill the running process completely
Ctrl+Z  = suspend/pause process, send to background stopped
&       = start process directly in background running
```

---

## Killing Background Jobs

```
kill %1     # kill job number 1
kill %2     # kill job number 2
jobs        # verify nothing remains
```

---

## System Resource Commands

```
free -h           # RAM usage in human readable format
df -h             # disk space on all partitions
du -sh ~/folder   # size of specific folder
uptime            # how long system has been running
uname -a          # kernel version and system info
lscpu             # detailed CPU information
nproc             # number of CPU cores
```

---

## Process Priority - nice and renice

```
Every process has a priority called nice value
Range: -20 to 19
-20 = highest priority (gets most CPU)
19  = lowest priority (gets least CPU)
0   = default priority

nice -n 10 command     # start command with priority 10
renice 10 -p PID       # change priority of running process
```

---

## What is TTY and pts
```
TTY = TeleTYpewriter = terminal
pts = pseudo terminal slave = virtual terminal

pts/0 = your first terminal window
pts/1 = second terminal window
pts/2 = third terminal window

Each terminal window gets its own pts number
```

---

## Key Differences to Remember

```
ps vs top:
ps  = single snapshot, shows once and exits
top = live view, updates every 3 seconds

kill vs kill -9:
kill    = polite request to stop (process can refuse)
kill -9 = forced kill (process cannot refuse)

Ctrl+Z vs Ctrl+C:
Ctrl+Z = suspend (process paused, can resume)
Ctrl+C = terminate (process killed permanently)

& vs Ctrl+Z:
& = starts in background running
Ctrl+Z = suspends foreground process to background stopped
```

---

## Commands Practiced Today
```
ps
ps aux
ps aux | grep bash
ps -u deepthi
ps aux | grep nano | grep -v grep
nano file.txt &
jobs
kill %1
kill %2
sleep 100 &
fg
top
htop
free -h
df -h
uptime
uname -a
lscpu
nproc
```
