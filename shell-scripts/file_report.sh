#!/bin/bash
#Checking if a directory exists

if [ -z "$1" ];then
	echo "Please provide the arguments"
	exit 1
fi

if [ -d "$1" ]; then
    echo "$1 directory exists"
else
    echo "The directory you are looking for doesn't exist"
    exit 1
fi

#Extension(.sh or .txt or .md etc) counting and adding timestamp
#tee - it prints to the screen and writes to a file
timestamp=$(date +%Y-%m-%d)
ls "$1" | grep -oP '\.[^.]+$' | sort | uniq -c | tee report_$timestamp.log
