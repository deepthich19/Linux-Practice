# Day 1

##Navigation Commands

```
pwd           # shows current directory
whoami        # shows current user
hostname      # Shows the name of your machine
ls            # lists files
ls -l         # Long format — shows permissions, owner, size, date
ls -a	      # Shows hidden files (files starting with .)
ls -la        # lists all files with details
cd ~          # go to home
cd ..         # go one level up
cd /          # Go to root directory — the top of the entire file system
cd -          # go to previous directory

```

# Linux File system

```
## Linux File System

| Folder | Description |
|--------|-------------|
| bin | Essential commands - ls, cd, pwd, cat |
| boot | Files needed to start Linux |
| cdrom | Mount point for CD/DVD drive |
| dev | Hardware represented as files |
| etc | All system configuration files |
| home | Personal folders for each user |
| lib | Shared libraries |
| lost+found | Recovered files after a system crash |
| media | Auto-mount for removable drives |
| mnt | Manual mount point |
| proc | Virtual folder - running processes |
| root | Home directory of root user |
| sbin | System admin commands |
| swapfile | Virtual memory file |
| sys | Exposes kernel and hardware info |
| tmp | Temporary files - cleared every reboot |
| usr | User programs and utilities |
| var | Variable data - logs, databases |
```

#Most Important Ones

```
/etc          # config files — "how is the system configured?"
/var/log      # log files — "what happened on this system?"
/home         # user files — "where does user data live?"
/bin          # basic commands — "where do commands come from?"
/proc         # running processes — "what is the system doing right now?"
/dev          # devices — "what hardware exists?"
/tmp          # temp files — "cleared every reboot"

```

# Absolute path — full path from root
```
cd /home/deepthi/Linux-Practice
```
# Relative path — from where you currently are
```
cd Linux-Practice
```
# Hardware Info Commands
```
nproc           # shows number of CPU cores
lscpu           # shows detailed CPU information
```
# Device Files
```
/dev/cpu/0,1,2  # each number = one CPU core
/dev = device files folder — Linux represents hardware as files
/dev/cpu = represents your CPU cores
A CPU is the physical chip on your motherboard — there is only one physical chip.
A core is an independent processing unit inside that one chip.
So 10 cores = one physical chip that can do 10 things simultaneously
```


