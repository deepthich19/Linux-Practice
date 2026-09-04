#!/bin/bash

# Conditions

echo "Enter your age:"
read age

if [ $age -gt 18 ]
then
	echo "You are an adult"
else
	echo "you are a minor"
fi

#Check if file exists
echo "Enter filename:"
read filename

if [ -f $filename ]
then
	echo "File exists"
else
	echo "File doesn't exist"
fi
