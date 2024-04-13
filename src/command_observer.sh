#!/bin/bash

history_file="../logs/.command_history"

function load_history() {
    if [ -f "$history_file" ]; then
        history -r "$history_file"
    fi
}

function save_history() {
    history -w "$history_file"
}

function document() {
    if [ -f "$history_file" ]; then
        echo "$@" >>  "$history_file"
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Documented command - $@.')"
    else
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Log file $history_file is missing.')"
        touch "$"
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Created $history_file')"
        echo "$1" >> "$history_file"
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Documented command - $@.')"
    fi
}

function observe() {
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Observing command - $@.')"
    document "$@"
}

function handle_input() {
    if IFS= read -r -e -p ">" input1 input2; then
        history -s "$input1" "$input2"
        if [ -n "$input1" ]; then
            save_history
        fi

        echo "$input1"
        echo "$input2"
    fi
}




