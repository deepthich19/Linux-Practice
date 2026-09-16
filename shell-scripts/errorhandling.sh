#!/bin/bash
#ErrorHanadling

file="$1"
if [ -z "$file" ];then
	echo "Error:No file provided"
	exit 1
fi

if [ ! -f "$file" ];then
	echo "Error:'file does not exist'"
	exit 1
fi

echo "'$file' found,  processing"

