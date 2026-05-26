# Day 1

#Navigation Commands

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


# Linux File system
ls /          #lists linix root file system EX: bin   etc   home   lib   media   opt   root   tmp   usr   var

bin		#Essential commands like ls, cd, pwd, cat — basic tools every user needs
boot		#Files needed to start Linux — bootloader, kernel
cdrom		#Mount point for CD/DVD drive
dev		#Device hardware is represented as files — CPU, disk, USB, terminal represented as files (you just explored this)
etc		#All system configuration files — network, users, passwords, services
home		#Personal folders for each user — your files live here /home/deepthi
lib		#Shared libraries that bin and sbin programs need to run
lost+found	#Recovered files after a system crash — Linux puts broken file fragments here
media		#Auto-mount point for removable drives — USB, external hard disk appears here
mnt		# Manual mount point — when you manually mount a drive you attach it here
proc		#Virtual folder — shows running processes and system info as files
root		#Virtual folder — shows running processes and system info as files
sbin		#System admin commands — fdisk, reboot, ifconfig — only root can run these
swapfile	#Virtual memory file — used when RAM is full, acts as extra RAM on disk
sys		#Virtual folder — exposes kernel and hardware info as files
temp		#Temporary files — any program can write here, cleared on every reboot
usr		#User programs and utilities — most installed software goes here
var		#Variable data — logs, databases, mail, print queues


#Most Important Ones
/etc          # config files — "how is the system configured?"
/var/log      # log files — "what happened on this system?"
/home         # user files — "where does user data live?"
/bin          # basic commands — "where do commands come from?"
/proc         # running processes — "what is the system doing right now?"
/dev          # devices — "what hardware exists?"
/tmp          # temp files — "cleared every reboot"


# Absolute path — full path from root
cd /home/deepthi/Linux-Practice
# Relative path — from where you currently are
cd Linux-Practice

# Hardware Info Commands
nproc           # shows number of CPU cores
lscpu           # shows detailed CPU information
# Device Files
/dev/cpu/0,1,2  # each number = one CPU core
/dev = device files folder — Linux represents hardware as files
/dev/cpu = represents your CPU cores
A CPU is the physical chip on your motherboard — there is only one physical chip.
A core is an independent processing unit inside that one chip.
So 10 cores = one physical chip that can do 10 things simultaneously



