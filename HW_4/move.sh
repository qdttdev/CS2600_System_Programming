#   Caroline Ta
#   CS2600.02 - Homework 4
#   05/17/21

# ------------------------- Sample Run 1 -------------------------

# qdttdev@DESKTOP-3LNQCIN:~$ ls
# cal.sh  des.txt  des.txt.1  des.txt.2  move.sh  src.txt
# qdttdev@DESKTOP-3LNQCIN:~$ chmod 777 move.sh
# qdttdev@DESKTOP-3LNQCIN:~$ ./move.sh src.txt des.txt
# move src.txt des.txt is performed successfully
# qdttdev@DESKTOP-3LNQCIN:~$ ls
# cal.sh  des.txt  des.txt.1  des.txt.2  des.txt.3  move.sh

# ------------------------- Sample Run 2 -------------------------

# qdttdev@DESKTOP-3LNQCIN:~$ ./move.sh src.txt des.txt
# src.txt does not exist, please try again
# qdttdev@DESKTOP-3LNQCIN:~$ touch src.txt
# qdttdev@DESKTOP-3LNQCIN:~$ ./move.sh src.txt des.txt
# move src.txt des.txt is performed successfully
# qdttdev@DESKTOP-3LNQCIN:~$ ls
# cal.sh  des.txt  des.txt.1  des.txt.2  des.txt.3  des.txt.4  move.sh
# qdttdev@DESKTOP-3LNQCIN:~$


#!/bin/bash

# Command line parameters
src=$1  # name of file on system
dst=$2  # new name for that file

# Check if source file exists
if ! [ -f "$src" ]; then
    echo "$src does not exist, please try again"
    exit 1
fi

i=1 # Increment variable for new destination file name
dstName=$dst # Destination file name to be concatenated with increment variable
# Check if destination file exists, if so, rename file with increment
while [ -f "$dst" ]; do
    dst="$dstName.$i"
    (( i++ ))
done

# Driver to perform mv
mv $src $dst
echo "move $src $dstName is performed successfully"
exit 0