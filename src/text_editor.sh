#!/bin/bash

source output_pip.sh

function check_kilo() {
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Checking Kilo compilation.')"
    if [ -d "../vendor" ]; then
        if [ -f "../vendor/kilo" ]; then
            echo 1
        else
            echo 0
        fi
    else
        echo 0
    fi
}

function start_kilo() {
    file_to_edit="$1"
    if [ -n $file_to_edit ]; then
        if [ $(check_kilo) == 1 ]; then
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Starting Kilo text editor.')"
            ./"../vendor/kilo" $file_to_edit
        else
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Kilo was not complied, compiling now.')"
            gcc -o "../vendor/kilo" "../vendor/kilo.c"
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Kilo complied, starting now.')"
            ./"..vendor/kilo" $file_to_edit
        fi
    else
        output angry
        echo "Missing file name!"
    fi
}
