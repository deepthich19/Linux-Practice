#!/bin/bash
#checking the logs

log="$1"
if [ -z "$log" ]
then
	echo "Please pass arguments"
	exit 1
fi

if [ ! -f "$log" ]
then 
	echo "the above is not a file"
	exit 1
fi

echo "file found"

echo "total lines:$(wc -l <  "$log")"
echo "total errors:$(grep -c ERROR "$log")"
echo "total warning:$(grep -c WARNING "$log")"


