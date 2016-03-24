#!/bin/bash

PS3='Options for running iOzone: '
options=("Automatic mode" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Automatic mode")
			/usr/bin/iozone -a
			;;
        "Option 2")
            echo "you chose choice 2"
            /usr/bin/iozone -R -l 5 -u 5 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 | tee -a /tmp/results.txt &
            ;;
        "Option 3")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done