#!/bin/bash
# Variables

#Defining Variables
Name="Deepthi"
Organisation="Hitachi"
Age=25

#Using Variables

echo "Name:$Name"
echo "Organisation:$Organisation"
echo "Age:$Age"

# Variable from command output
currentdate=$(date)
username=$(whoami)

# User input
echo "Enter your name: " 
read username
echo "Hello $username"

