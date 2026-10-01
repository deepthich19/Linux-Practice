#!/bin/bash
#backup a folder

src="$1"
if [ -z "$src" ];then	
	echo "Please provide the arguments"
	exit 1
fi

if [ -d "$src" ];then
	echo "Directory exists"

else
	echo "Directory does not exist"
	exit 1
fi

timestamp=$(date +%y-%m-%d)
tar -czf ~/backups/backup_$timestamp.tar.gz "$src"
