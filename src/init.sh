#!/bin/bash

UT_FLDR=unit_tests/*

pids=()

clear
echo "//Unit test init begin//"

for file in $UT_FLDR; do
    python3 $file &
    pids+=($!)
done

while true; do
    clear
    echo "//Unit test init begin//"
    echo "$(<../logs/.test-log.txt)"

    all_finished=true
    for pid in "${pids[@]}"; do
        if ps -p $pid > /dev/null; then
            all_finished=false
            break
        fi
    done

    if $all_finished; then
        break
    fi

    sleep 2
    
done

echo "//Unit test init end//"
echo "" > ../logs/.test-log.txt

sleep 5