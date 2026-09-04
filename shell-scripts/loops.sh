#!/bin/bash
#loops

# For loop through list
echo "--- For Loop Names ---"
for name in sia ria kia maya haya
do
	echo "Hello $name"
done

echo "---For loop number---"
for i in 1 2 3 4 5
do
	echo "$i"
done

echo "--while loop--"
count=1
while [ $count -le 6 ]
do
	echo "count:$count"
	count=$((count+1))
done

