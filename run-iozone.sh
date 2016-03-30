#!/bin/bash

echo 'Options for running iOzone: '
PS3='Please enter your choice: '
options=("Automatic mode" "Optimized test" "Enter your own arguments(-h for help)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Automatic mode")
			/usr/bin/iozone -a
			;;
        "Optimized test")
            /usr/bin/iozone -R -l 5 -u 5 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 | tee -a /tmp/results.txt &
            ;;
        "Enter your own arguments(-h for help)")
# Run iozone 
#  https://communities.bmc.com/docs/DOC-10204
# -a         full automatic mode
# -R         excel compatible text output
# -l and -u  lower and upper limit on threads/processes 
# -r         the record size
# -s         the size of the file that needs to be tested
# -F         the temporary filename that should be used by the iozone during testing
            read userinput
            /usr/bin/iozone $userinput
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done