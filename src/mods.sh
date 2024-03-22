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
            if [[ "$main_script" == *.py ]]; then
                python3 "$main_script"
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Using $mod_to_use.')"
            elif [[ "$main_script" == *.sh ]]; then
                bash "$main_script"
                python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Using $mod_to_use.')"
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
            python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Mod $info_abt doesn't have info file.')"
            echo "Mod" $info_abt "doesn't have info file."
        fi
    else
        output sad
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('WARNING', 'Mod $info_abt doesn't exist or is not installed.')"
        echo "Mod $info_abt doesn't exist or is not installed"
    fi
}


