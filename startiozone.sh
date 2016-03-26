#!/bin/bash

echo 'Options for running iOzone: '
PS3='Please enter your choice: '
options=("Quick test with graphs" "Automatic mode" "Optimized test" "Enter your own arguments(-h for help)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Quick test with graphs")
            /usr/bin/iozone -a -g 4m  > /tmp/test_analysis
            ./Generate_Graphs /tmp/test_analysis
            ;;
        "Automatic mode")
			/usr/bin/iozone -a
			;;
        "Optimized test")
            /usr/bin/iozone -R -l 5 -u 5 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 | tee -a /tmp/results.txt &
            ;;
        "Enter your own arguments(-h for help)")
            read userinput
            /usr/bin/iozone $userinput
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done