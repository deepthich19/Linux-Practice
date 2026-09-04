#!/bin/bash
# System information script

echo "================================"
echo "       SYSTEM INFORMATION"
echo "================================"
echo "Hostname    : $(hostname)"
echo "Date/Time   : $(date)"
echo "Logged in as: $(whoami)"
echo "Current Dir : $(pwd)"
echo "================================"
echo "CPU Cores   : $(nproc)"
echo "================================"
echo "DISK USAGE"
df -h /
echo "================================"
echo "MEMORY USAGE"
free -h
echo "================================"
echo "TOP 5 PROCESSES BY CPU"
ps aux --sort=-%cpu | head -6
echo "================================"
