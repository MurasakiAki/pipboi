#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/output_pip.sh

function echo_whereami() {
    is_conn=$(python3 -c "from network_funcs import check_connection; print(check_connection())")
    if [ "$is_conn" == "1" ]; then
        script_command=$(python3 -c "from geo_funcs import tell_location; print(tell_location('$logged_in_usr'))")
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing location.')"
        echo "$script_command"
    else
        output sad
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Whereami - No internet connection.')"
        echo No internet connection :/
    fi
}

function echo_whereip() {
    ip_add="$1"
    if [ -n "$ip_add" ]; then
        is_conn=$(python3 -c "from network_funcs import check_connection; print(check_connection())")
        if [ "$is_conn" == "1" ]; then
            script_command=$(python3 -c "from geo_funcs import whereip; print(whereip('$ip_add'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing location of Ip address.')"
            echo "$script_command"
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Whereip - No internet connection.')"
            echo No internet connection :/
        fi
    else
        output angry
        echo Enter valid IPv4 address
    fi
}

function echo_whereloc() {
    loc_name="$1"
    if [ -n "$loc_name" ]; then
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing location $loc_name.')"
        script_command=$(python3 -c "from geo_funcs import whereloc; print(whereloc('$logged_in_usr', '$loc_name'))")
        echo "$script_command"
    fi
}

function echo_addloc() {
    if [ "$1" == "here" ]; then
        read -p "Locations name: " name
        lat=$(python3 -c "from geo_funcs import tell_latitude; print(tell_latitude())")
        lng=$(python3 -c "from geo_funcs import tell_longitude; print(tell_longitude())")
        script_command=$(python3 -c "from geo_funcs import add_location; print(add_location('$logged_in_usr', '$name', '$lat', '$lng'))")
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Adding location - here.')"
        echo "$script_command"
    elif [[ $1 == *"/"* ]]; then
        read -p "Locations name: " name
        lat=$(echo "$1" | cut -d '/' -f1)
        lng=$(echo "$1" | cut -d '/' -f2)
        number_regex='^[+-]?[0-9]+\.?[0-9]*$'
        if [[ $lat =~ $number_regex && $lng =~ $number_regex ]]; then
            script_command=$(python3 -c "from geo_funcs import add_location; print(add_location('$logged_in_usr', '$name', '$lat', '$lng'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Adding location $name.')"
            echo "$script_command"
        else
            output angry
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Wrong format of location entered.')"
            echo Enter only numbers or floating points e.x. "[12.34/5.67]"
        fi
    fi
}

function echo_remloc() {
    loc_name="$1"
    if [ -n "$loc_name" ]; then
        script_command=$(python3 -c "from geo_funcs import remove_location; print(remove_location('$logged_in_usr', '$loc_name'))")
        output surprise
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Removing location $loc_name.')"
        echo "$script_command"
    else
        output sad
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Remloc - Location not entered.')"
        echo Enter location name plweas
    fi
}

function echo_showloc() {
    script_command=$(python3 -c "from geo_funcs import show_location; print(show_location('$logged_in_usr'))")
    output surprise
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Removing locations list.')"
    echo "$script_command"
}

function echo_distance() {
    output random
    read -p "Enter latitude and longitude of first location: " lat1 lng1
    output random
    read -p "Enter latitude and longitude of second location: " lat2 lng2
    script_command=$(python3 -c "from geo_funcs import distance; print(distance('$lat1', '$lng1', '$lat2', '$lng2'))")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing distance.')"
    echo "$script_command"
}

function echo_distname() {
    output random
    read -p "Enter name of first location: " name
    output random
    read -p "Enter latitude and longitude of second location: " lat2 lng2
    script_command=$(python3 -c "from geo_funcs import distname; print(distname('$logged_in_usr', '$name', '$lat2', '$lng2'))")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing distance between name and location.')"
    echo "$script_command"
}

function echo_distnames() {
    output random
    read -p "Enter name of first location: " name1
    output random
    read -p "Enter name of first location: " name2
    script_command=$(python3 -c "from geo_funcs import distnames; print(distnames('$logged_in_usr', '$name1', '$name2'))")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing distance between names.')"
    echo "$script_command"
}

function echo_disthere() {
    loc="$1"
    if [ -n "$loc" ]; then
        script_command=$(python3 -c "from geo_funcs import disthere; print(disthere('$logged_in_usr', '$loc'))")
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing distance between here and $loc.')"
        echo "$script_command"
    fi
}

function echo_getlocname() {
    output random
    read -p "Enter latitude: " lat
    output random
    read -p "Enter longitude: " lng
    script_command=$(python3 -c "from geo_funcs import get_location_name; print(get_location_name('$lat', '$lng'))")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing get location name.')"
    echo "$script_command"
    loc_name="$script_command"

    until [ "$ans" == "no" ]; do
        read -p "Do you want to save this location? [yes|no] " ans
        if [ "$ans" == "yes" ]; then
            script_command=$(python3 -c "from geo_funcs import add_location; print(add_location('$logged_in_usr', '$loc_name', '$lat', '$lng'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Saving get location.')"
            echo "$script_command"
            break
        elif [ "$ans" != "no" ]; then
            output angry
            echo "Only [yes|no]!"
        fi
    done
}

function echo_getloc() {
    output random
    read -p "Enter name of location: " name
    script_command=$(python3 -c "from geo_funcs import get_lat_lng; print(get_lat_lng('$name'))")
    output normal
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing get location name.')"
    echo "Latitude and longitude of $name is $script_command"
    latlng="$script_command"
    lat=$(echo "$latlng" | cut -d '/' -f1)
    lng=$(echo "$latlng" | cut -d '/' -f2)

    until [ "$ans" == "no" ]; do
        read -p "Do you want to save this location? [yes|no] " ans
        if [ "$ans" == "yes" ]; then
            script_command=$(python3 -c "from geo_funcs import add_location; print(add_location('$logged_in_usr', '$name', '$lat', '$lng'))")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Saving get location.')"
            echo "$script_command"
            break
        elif [ "$ans" != "no" ]; then
            output angry
            echo "Only [yes|no]!"
        fi
    done
}