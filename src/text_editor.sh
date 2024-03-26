#!/bin/bash

source output_pip.sh

function check_kilo() {
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
            ./"../vendor/kilo" $file_to_edit
        else
            output disappointment
            echo "Kilo not compiled!"
        fi
    else
        output angry
        echo "Missing file name!"
    fi
    
}
