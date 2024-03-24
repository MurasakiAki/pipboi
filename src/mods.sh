#!/bin/bash

source output_pip.sh

function echo_mods() {
    if [ -d ../mods ]; then
        if [ "$(ls -A ../mods)" != "" ]; then
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Listing mods.')"
            ls ../mods
        else
            output surprise
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'No mods installed.')"
            echo "No mods installed!"
        fi
    fi
}

function use_mod() {
    mod_to_use="$1"
    if [ -n "$mod_to_use" ]; then
        main_script=$(find "../mods/$mod_to_use" -type f \( -name "main.py" -o -name "main.sh" \) -print -quit)
        if [ -n "$main_script" ]; then
            output normal
            echo "Okay using $main_script script."
            sleep 3
            clear
            if [[ "$main_script" == *.py ]]; then
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Using $mod_to_use.')"
                python3 "$main_script"
                output normal
            elif [[ "$main_script" == *.sh ]]; then
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Using $mod_to_use.')"
                bash "$main_script"
                output normal
            else
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', '$mod_to_use has invalid main script format.')"
                echo "Invalid file format. File must be .py or .sh"
            fi
        else
            output sad
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Main script was not found in $mod_to_use.')"
            echo "Main script not found in $mod_to_use folder."
        fi
    else
        output sad
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Mod folder not specified.')"
        echo "Mod folder not specified."
    fi
}

function echo_modinfo() {
    info_abt="$1"
    if [ -n "$info_abt" ]; then
        if [ -f "../mods/$info_abt/info.txt" ]; then
            output normal
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Telling info about $info_abt.')"
            echo "Info about" $info_abt
            cat ../mods/$info_abt/info.txt
            echo
        else
            output disappointment
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Mod $info_abt does not have info file.')"
            echo "Mod" $info_abt "does not have info file."
        fi
    else
        output sad
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Mod $info_abt does not exist or is not installed.')"
        echo "Mod $info_abt does not exist or is not installed"
    fi
}

function include_mod() {
    folder_to_include="$1"
    if [ -n "$folder_to_include" ]; then
        if [ -d "../.$logged_in_usr/$folder_to_include" ]; then
            if [ -f "../.$logged_in_usr/$folder_to_include/main.py" ] || [ -f "../.$logged_in_usr/$folder_to_include/main.sh" ]; then
                mv "../.$logged_in_usr/$folder_to_include" "../mods"
                if [ -d "../mods/$folder_to_include" ]; then
                    output normal
                    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Folder $folder_to_include included into mods folder.')"
                    echo "Succesfully included $folder_to_include"
                else
                    output sad
                    python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Error while including $folder_to_include into mods folder.')"
                    echo "Something went wrong :c"
                fi
            else
                output angry
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Folder $folder_to_include does not have executable file.')"
                echo "$folder_to_include does not have main.py/.sh file"
            fi
        else
            output disappointment
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Folder $folder_to_include does not exist.')"
            echo "Folder, $folder_to_include to include into mods, was not found"
        fi
    else
        output angry
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Folder name to include not entered.')"
        echo "Enter folder name to include!"
    fi
}

function remove_mod() {
    mod_to_remove="$1"
    if [ -n "$mod_to_remove" ]; then
        if [ -d "../mods/$mod_to_remove" ]; then
            rm -rf "../mods/$mod_to_remove"
            if [ -d "../mods/$mod_to_remove" ]; then
                output sad
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Error while removing $mod_to_remove from mods folder.')"
                echo "something went wroing with removing $mod_to_remove"
            else
                output normal
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Mod $mod_to_remove removed from mods folder.')"
                echo "$mod_to_remove removed"
            fi
        else
            output disappointment
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Mod $mod_to_remove does not exist.')"
            echo "$mod_to_remove does not exist"
        fi
    else
        output angry
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('ERROR', 'Mod name to remove not entered.')"
        echo "Enter name of the mod you want to remove!"
    fi
}