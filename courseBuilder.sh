#!/bin/bash

############################################################
# Help                                                     #
############################################################

Help() {
    echo -e "Usage: ./makeClasses [-c][number] [-w][number]\n"
    echo "[-c][number]     Specify number of courses you are taking."
    echo "[-w][number]     Specify number of weeks for the respective semester."
}

############################################################
# Main program                                             #
############################################################

# Determine if a valid number of arguments are given
case $# in 
	0 ) 
    Help >&2
    exit 1
    ;;
esac

numCourses=0
numWeeks=0

# Handle options and arguments
while getopts ":c:w:" opt; do
    case ${opt} in 
        c ) 
        numCourses=$OPTARG
        ;;
        w )
        numWeeks=$OPTARG
        ;;
        \? ) 
        echo -e "Invalid option: $OPTARG is not a valid option.\n"
        Help >&2
        exit 1
        ;;
        : )
        echo -e "Invalid option: [-$OPTARG] missing argument\n"
        Help >&2
        exit 1
        ;;
    esac
done

declare -a courses
count=0

# Prompt the user to enter a course code for each course
while [ $count -lt $numCourses ]
do
    i=$((count+1))
	echo -n "Enter course code for course $i: "
	read value
	courses+=($value)
	((count++))
done

# Loop through the array and make directory for each course
# Create the folders for given weeks in each course directory
for i in "${courses[@]}"
do
   mkdir $i
   eval mkdir $i/week{1..$numWeeks}
done

echo "Created $numCourses courses with folders for $numWeeks weeks."
exit 0