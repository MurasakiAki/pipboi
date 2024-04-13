#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/output_pip.sh

function echo_weather() {
    city="$1"
    if [ -n "$city" ]; then
        is_conn=$(python3 -c "from network_funcs import check_connection; print(check_connection())")
        if [ "$is_conn" == "1" ]; then
            if [ "$(python3 -c "from geo_funcs import is_valid_city; print(is_valid_city('$city'))")" == "True" ]; then
                script_command=$(python3 -c "from weather_funcs import tell_weather; print(tell_weather('$city'))")
                output normal
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing weather in $city.')"
                echo Currently in "$city" it\'s "$script_command"
            else
                output disappointment
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Weather - City name missing or is not valid.')"
                echo Please enter a valid city name
            fi
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Weather - No internet connection.')"
            echo No internet connection :/
        fi
    else
        output disappointment
        echo Please enter a city name
    fi
}