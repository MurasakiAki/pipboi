#!/bin/bash

source output_pip.sh

function echo_whoami() {
    output love
    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing identity.')"
    echo "You are" $logged_in_usr
}

function echo_help() {
    section="$1"
    content=$(cat ../.help.txt)
    if [ -n "$section" ]; then
        sec_to_check="#$(echo "$section" | tr '[:lower:]' '[:upper:]')#"
        if grep -q "$sec_to_check" ../.help.txt; then
            output love
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Echoing $section of help file.')"
            echo Displaying "$section" of help file
            output_sec=$(echo "$content" | sed -n "/^$sec_to_check$/,/^*/p" | sed '1d;$d')
            echo '////////////////////'
            echo "$sec_to_check"
            echo "$output_sec"
            echo '////////////////////'
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Section not found in help file.')"
            echo "No section '$section' found"
        fi
    else
        output love
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Displaying help file.')"
        echo Here is all commands:
        cat ../.help.txt
    fi
}

function write_file() {
    file_to_write="$1"
    if [ -n "$file_to_write" ]; then
        if [ -f "../.${logged_in_usr}/${file_to_write}" ]; then
            output normal
            read -p "Please enter text: " text
            echo "$text" >> "../.${logged_in_usr}/${file_to_write}"
            output love
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Wrote into file $file_to_write.')"
            echo Text saved to file "$file_to_write"
        else 
            output surprise
            touch "../.${logged_in_usr}/${file_to_write}"
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Created file $file_to_write.')"
            echo Created file "$file_to_write" in your folder
        fi
    fi
}

function read_file() {
    file_to_read="$1"
    if [ -n "$file_to_read" ]; then
        if [ "$file_to_read" == "../.usrdata.ini" ]; then
            output angry
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'You dont't have access to read system files.')"
            echo You don\'t have access to this file 
        elif [ -f "../.${logged_in_usr}/${file_to_read}" ]; then
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Reading file $file_to_read.')"
            cat "../.${logged_in_usr}/${file_to_read}"
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'File $file_to_read does not exist.')"
            echo File "$file_to_read" doesn\'t exist
        fi
    fi
}

function remove_file() {
    file_to_remove="$1"
    if [ -n "$file_to_remove" ]; then
        if [ "$file_to_remove" == "../.usrdata.ini" ]; then
            output angry
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'You don't have access to delete system files.')"
            echo You can\'t remove this file
        elif [ -f "../.${logged_in_usr}/${file_to_remove}" ]; then
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Removed $file_to_remove file.')"
            rm -f "../.${logged_in_usr}/${file_to_remove}"
            echo File "$file_to_remove" removed
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'File $file_to_remove does not exist.')"
            echo File "$file_to_remove" doesn\'t exist
        fi 
    fi
}

function make_directory() {
    dir_name="$1"
    if [ -n "$dir_name" ]; then
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Creating $dir_name directory.')"
        mkdir "../.${logged_in_usr}/${dir_name}"
        echo Directory "$dir_name" created
    else
        output angry
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Directory name not entered.')"
        echo Fill in directory name!
    fi
}

function remove_directory() {
    dir_to_rem="$1"
    if [ -d "../.${logged_in_usr}/${dir_to_rem}" ]; then
        if [ -n "$dir_to_rem" ]; then
            read -p "Are you sure you want to delete "$dir_to_rem" and all its contents? [yes|no]" ans
            if [ "$ans" == "yes" ]; then
                rm -rf "../.${logged_in_usr}/${dir_to_rem}"
                output sad
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Deleting directory $dir_to_rem.')"
                echo Directory "$dir_to_rem" deleted
            elif [ "$ans" == "no" ]; then
                output disappointment
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Abandoning $dir_to_rem directory deletion.')"
                echo Won\'t delete "$dir_to_rem" directory
            else
                output angry
                echo Only "[yes|no]!"
            fi
        else
            output angry
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Direcory name not entered.')"
            echo Fill in directory name!
        fi
    else
        output disappointment
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Direcory $dir_to_rem does not exist.')"
        echo Direcory "$dir_to_rem" doens\'t exist
    fi
}

function list() {
    dir_name="$1"
    if [ -n "$dir_name" ]; then
        directory_to_list="../.${logged_in_usr}/${dir_name}"
        if [ -d "$directory_to_list" ]; then
            list_output=$(ls "$directory_to_list")
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Listing files and directories in $directory_to_list.')"
            echo "$list_output"
        else
            output disappointment
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Directory $directory_to_list does not exist.')"
            echo "Directory '$dir_name' does not exist."
        fi
    else
        list_output=$(ls ../.${logged_in_usr})
        output normal
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Listing user files.')"
        echo "$list_output"
    fi
}

function update_pipboi() {
    is_conn=$(python3 -c "from network_funcs import check_connection; print(check_connection())")
    if [ "$is_conn" == "1" ]; then
        cd ..
        git pull
        output love
        echo Your PIPBOI is updated '<3'
    else
        output sad
        echo No internet connection :/
    fi
}