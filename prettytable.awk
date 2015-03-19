#!/usr/bin/awk -f
# 
# prettytable -- print a "pretty" table
# 
# Copyright 2014 Haibo Qiu. All rights reserved.
# 
# Creator       : Haibo Qiu
# Created       : 2014-11-09 20:57:56+0800
# Last Modifier : Haibo Qiu
# Last Modified : 2014-11-09 20:57:56+0800
#  

BEGIN {
	isReadyToPrint = 0
}

# First time process: Get the max length of every fields
FNR == NR && isReadyToPrint == 0 {
	for (i=1; i<=NF; i++) {
		if (lens_of_field[i] < length($i)) {
			lens_of_field[i] = length($i)
		}
	}
}

# When reading from the second file
FNR == 1 && FNR < NR {
	isReadyToPrint = 1
	# Now this is the first record of the 2nd file.
	# Go to next 'pattern-action'
}

# Print out the second file
isReadyToPrint == 1 && FNR < NR {
	for (i=1; i<=NF; i++) {
		fmt_str=("%-" lens_of_field[i]+2 "s")
		printf fmt_str, $i
	}
	printf "\n"
}

