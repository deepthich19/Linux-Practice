#!/bin/bash
#exitstatus

ls /home
echo "Exit status of ls: $?"

ls /nonexistent
echo "Exit status of nonexistent: $?"

# Check if ping works
ping -c 1 google.com > /dev/null 2>&1
if [ $? -eq 0 ]
then
	echo "Internet is working"
else
	echo "Internet is not working"
fi

