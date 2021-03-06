#   Caroline Ta
#   CS2600.02 - Homework 3
#   05/17/21

# ------------------------------- Sample Run 0 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh June 21
# Invalid month, please try again (example: Jan, Feb, Mar,...)

# ------------------------------- Sample Run 1 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh 0 5
# Invalid month, must be between 1-12

# ------------------------------- Sample Run 2 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh 5 0
# Invalid year, must be greater than 0

# ------------------------------- Sample Run 3 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh 5 2021

#        May, 2021
#  Su Mo Tu We Th Fr Sa
#                     1
#   2  3  4  5  6  7  8
#   9 10 11 12 13 14 15
#  16 17 18 19 20 21 22
#  23 24 25 26 27 28 29
#  30 31

# ------------------------------- Sample Run 4 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh Apr 2021

#        April, 2021
#  Su Mo Tu We Th Fr Sa
#               1  2  3
#   4  5  6  7  8  9 10
#  11 12 13 14 15 16 17
#  18 19 20 21 22 23 24
#  25 26 27 28 29 30

# ------------------------------- Sample Run 5 ------------------------------
# qdttdev@DESKTOP-3LNQCIN:~$ ./cal.sh Jun 21

#        June, 2021
#  Su Mo Tu We Th Fr Sa
#         1  2  3  4  5
#   6  7  8  9 10 11 12
#  13 14 15 16 17 18 19
#  20 21 22 23 24 25 26
#  27 28 29 30

#!/bin/bash

# This function returns the first weekday of the target year
startDay() # Params: year
{
	year=$1
	
    (( x1 = ($year - 1) / 4 ))
    (( x2 = ($year - 1) / 100 ))
    (( x3 = ($year - 1) / 400 ))    
    (( day = ($year + x1 - x2 + x3) % 7 ))

	return $day
}

# This function returns the number of days in the month
daysInMonth() # Params: monthNumber, year
{
	monthNumber=$1
	year=$2

	# January
	if [ "$monthNumber" == 1 ]; then
		return 31
	fi
	
	# February - Check for Leap year
    (( yearMod400 = $year % 400 ))
    (( yearMod4 = $year % 4 ))
    (( yearMod100 = $year % 100 ))

	if [ "$monthNumber" == 2 ]; then        
		if [ $yearMod400 -eq 0 ]; then
            return 29
        elif [ $yearMod4 -eq 0 -a $yearMod100 -ne 0 ]; then
            return 29
        else
			return 28
		fi
	fi
	
	# March
	if [ "$monthNumber" == 3 ]; then
		return 31
	fi
	
	# April
	if [ "$monthNumber" == 4 ]; then
		return 30
	fi
	
	# May
	if [ "$monthNumber" == 5 ]; then
		return 31
	fi
	
	# June
	if [ "$monthNumber" == 6 ]; then
		return 30
	fi
	
	# July
	if [ "$monthNumber" == 7 ]; then
		return 31
	fi
	
	# August
	if [ "$monthNumber" == 8 ]; then
		return 31
	fi
	
	# September
	if [ "$monthNumber" == 9 ]; then
		return 30
	fi
	
	# October
	if [ "$monthNumber" == 10 ]; then
		return 31
	fi
	
	# November
	if [ "$monthNumber" == 11 ]; then
		return 30
	fi
	
	# December
	if [ "$monthNumber" == 12 ]; then
		return 31
	fi
	
}

# This function prints the month's name
printMonthName() # Params: month
{
    m=$1
    y=$2
    (( m = $m - 1 ))

    months=( "January" "February" "March" "April" "May" "June" 
             "July" "August" "September" "October" "November" "December" )
    
    echo
    echo "       ${months[$m]}, $y"
    echo " Su Mo Tu We Th Fr Sa"
}

# This function prints the days of the target month in Calendar format
printMonth() # Params: year, month
{
    year=$1
    month=$2

    # Finds the current weekday
    startDay $year
    current=$?

    # Loop through all 12 months
    for (( i = 1; i <= 12; i++ ))
    do
        # Finds the number of days in the month
        daysInMonth $i $year
        days=$?

        # Only output target month
        if [ $i -eq $month ]; then
            printMonthName $i $year
        fi

        # Print spaces to display first weekday correctly
        for (( k = 0; k < current; k++ ))
        do            
            if [ $i -eq $month ]; then
                echo -n "   "
            fi
        done

        # Print the days in the month
        for (( j = 1; j <= days; j++ ))
        do
            if [ $i -eq $month ]; then
                printf "%3d" "$j"
            fi           
            
            # Print newline to display calendar correctly
            if (( ++k > 6 )); then
                (( k = 0 ))
                if [ $i -eq $month ]; then
                    echo
                fi
            fi
        done

        # Update current weekday
        current=$k
    done    
}

# --------------------------------- Driver --------------------------------- #
# Input month and year

# Month should be a number between 1 and 12
month=$1
year=$2

# String value for month converted into integer 
re='^[0-9]+$'
if ! [[ $month =~ $re ]]; then
    case "$month" in
    "Jan")  month=1
    ;;
    "Feb")  month=2
    ;;
    "Mar")  month=3
    ;;
    "Apr")  month=4
    ;;
    "May")  month=5
    ;;
    "Jun")  month=6
    ;;
    "Jul")  month=7
    ;;
    "Aug")  month=8
    ;;
    "Sep")  month=9
    ;;
    "Oct")  month=10
    ;;
    "Nov")  month=11
    ;;
    "Dec")  month=12
    ;;
    *)      echo "Invalid month, please try again (example: Jan, Feb, Mar,...)"
            exit 0
    ;;
    esac
fi

# Error check for month input
if [ $month -gt 12 -o $month -lt 1 ]; then
    echo "Invalid month, must be between 1-12"
    exit 0
fi

# Error check for year input
if [ $year -lt 1 ]; then
    echo "Invalid year, must be greater than 0"
    exit 0
fi

# If year input is a 2 digit number, convert into 4 digit
if [ $year -lt 100 ]; then
    (( year = year + 2000 ))
fi

printMonth $year $month
echo
echo