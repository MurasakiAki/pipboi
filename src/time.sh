#!/bin/bash

source output_pip.sh

function echo_time() {
    script_command=$(python3 -c "from time_funcs import tell_time; print(tell_time())")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing time.')"
    echo "$script_command"
}

function echo_day() {
    script_command=$(python3 -c "from time_funcs import tell_day; print(tell_day())")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing day.')"
    echo "$script_command"
}

function echo_daytime() {
    script_command=$(python3 -c "from time_funcs import tell_dt; print(tell_dt())")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing daytime.')"
    echo "$script_command"
}

function echo_calendar() {
    type="$1"
    if [ -n "$type" ]; then
        if [ "$type" == "year" ]; then
            read -p "Please enter year: " year
            script_command=$(python3 -c "from time_funcs import tell_y_calendar; print(tell_y_calendar('$year'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing calendar - year.')"
            echo Calendar of the year "$year" 
            echo "$script_command"
        elif [ "$type" == "month" ]; then
            read -p "Please enter year: " year
            read -p "Please enter month: " month
            script_command=$(python3 -c "from time_funcs import tell_m_calendar; print(tell_m_calendar('$year', '$month'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing calendar - month.')"
            echo Calendar of the year "$year", month "$month"
            echo "$script_command"
        fi
    fi
}
