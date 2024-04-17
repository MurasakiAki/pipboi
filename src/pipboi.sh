#!/bin/bash

source $SCRIPT_DIR/output_pip.sh
source $SCRIPT_DIR/farewell_pip.sh
source $SCRIPT_DIR/basics.sh
source $SCRIPT_DIR/mods.sh
source $SCRIPT_DIR/time.sh
source $SCRIPT_DIR/weather.sh
source $SCRIPT_DIR/location.sh
source $SCRIPT_DIR/command_observer.sh
source $SCRIPT_DIR/sensor.sh
source $SCRIPT_DIR/image.sh

PASSWD_PATH="$SCRIPT_DIR/passwd_funcs.py"

export logged_in_usr=""

stty_settings=$(stty -g)

enable_input() {
    # Restore terminal settings
    stty "$stty_settings"
}

bash $SCRIPT_DIR/init.sh

if [ "$1" == "register" ]; then
    username="$2"

    if [ -z "$2" ]; then
        output disappointment
        echo Fill in your name too dummy
    
    elif [ -d  "$SCRIPT_DIR/../.$username" ]; then
        output sad
        echo Username already exists silly
    
    else
        password=""
        is_sure=0
        
        until [ $is_sure -eq 1 ]; do
            output normal
            read -s -p "Enter password: " password 
            echo ""
            ans=""
            until [ "$ans" = "yes" ] || [ "$ans" = "no" ]; do
                output surprise
                read -p "Are you sure? [yes|no] " ans
            done
            
            if [ "$ans" = "yes" ]; then
                is_sure=1
            fi
        done

        mkdir ../.$username
        #.userdata.ini file
        touch $SCRIPT_DIR/../.$username/.usrdata.ini
        echo "[Data]" >> $SCRIPT_DIR/../.$username/.usrdata.ini
        echo "username=$username" >> $SCRIPT_DIR/../.$username/.usrdata.ini
        hashedpw=$(python3 -c "from passwd_funcs import hash_password; print(hash_password('$password'))" "$PASSWD_PATH")
        echo "password=$hashedpw" >> $SCRIPT_DIR/../.$username/.usrdata.ini
        #.locations.json file
        touch $SCRIPT_DIR/../.$username/.locations.json
        echo '{"locations" : [] }' > $SCRIPT_DIR/../.$username/.locations.json
        output normal
        echo yay user created   
    fi

elif [ "$1" == "login" ]; then
    username="$2"

    if [ -z "$2" ]; then
        output disappointment
        echo Fill in your name too dummy

    elif ! [ -d  "$SCRIPT_DIR/../.$username" ]; then
        output sad
        echo Username doesn\'t exists silly

    else
        input_pw=""
        file="$SCRIPT_DIR/../.${username}/.usrdata.ini"
        hashed_pw=$(grep -E "^\[Data\]" -A 1000 "$file" | grep -E "password=" | cut -d'=' -f2-)

        while true; do
            output surprise
            read -s -p "What's your password? " input_pw
            echo

            if [ "$(python3 -c "from passwd_funcs import check_password; print(check_password('$input_pw', '$hashed_pw'))" "$PASSWD_PATH")" = "True" ]; then
                output normal         
                echo "Password is correct!"
                logged_in_usr="$username"
                stty -echo
                sleep 3
                enable_input
                output random
                echo "Welcome, for more info type: help"
                break
            else
                output sad                 
                echo "Password is incorrect. Please try again."
                stty -echo
                sleep 5
                enable_input
            fi
        done

        until [ "$input1" == "quit" ]; do
            echo
            load_history
            input_commands=($(handle_input "$@"))
            input1="${input_commands[0]}"
            input2="${input_commands[1]}"

            # Time
            if [ "$input1" == "time" ]; then
                echo_time
            elif [ "$input1" == "day" ]; then
                echo_day
            elif [ "$input1" == "dt" ]; then
                echo_daytime
            elif [ "$input1" == "calendar" ]; then
                echo_calendar "$input2"
            
            # Sensors
            elif [ "$input1" == "s-dist" ]; then
                apply_job_dist
            elif [ "$input1" == "s-temp" ]; then
                apply_job_temp

            # Mods
            elif [ "$input1" == "mods" ]; then
                echo_mods
            elif [ "$input1" == "use" ]; then
                use_mod "$input2"
            elif [ "$input1" == "modinfo" ]; then
                echo_modinfo "$input2"
            elif [ "$input1" == "include" ]; then
                include_mod "$input2"
            elif [ "$input1" == "removem" ]; then
                remove_mod "$input2"

            # Basic manipulation
            elif [ "$input1" == "hello" ] || [ "$input1" == "hi" ]; then
                echo_hello
            elif [ "$input1" == "help" ]; then
                echo_help "$input2"
            elif [ "$input1" == "whoami" ]; then
                echo_whoami
            elif [ "$input1" == "write" ]; then
                write_file "$input2"
            elif [ "$input1" == "read" ]; then
                read_file "$input2"
            elif [ "$input1" == "removef" ]; then
                remove_file "$input2"
            elif [ "$input1" == "makedir" ]; then
                make_directory "$input2"
            elif [ "$input1" == "removed" ]; then
                remove_directory "$input2"
            elif [ "$input1" == "list" ]; then
                list "$input2"
            #elif [ "$input1" == "goto" ]; then
            #    goto_folder "$input2"
            elif [ "$input1" == "update" ]; then
                update_pipboi
            elif [ "$input1" == "sus" ]; then
                sus
                clear
                output random
                echo "What was that!"
            
            # Image
            elif [ "$input1" == "draw" ]; then
                draw_image $logged_in_usr $input2 

            # Weather
            elif [ "$input1" == "weather" ]; then
                echo_weather "$input2"

            #IP Location
            elif [ "$input1" == "whereami" ]; then
                echo_whereami
            elif [ "$input1" == "whereip" ]; then
                echo_whereip "$input2"
            elif [ "$input1" == "whereloc" ]; then
                echo_whereloc "$input2"
            elif [ "$input1" == "addloc" ]; then
                echo_addloc "$input2"
            elif [ "$input1" == "remloc" ]; then
                echo_remloc "$input2"
            elif [ "$input1" == "showloc" ]; then
                echo_showloc
            elif [ "$input1" == "distance" ]; then
                echo_distance
            elif [ "$input1" == "distname" ]; then
                echo_distname
            elif [ "$input1" == "distnames" ]; then
                echo_distnames
            elif [ "$input1" == "disthere" ]; then
                echo_disthere "$input2"
            elif [ "$input1" == "getlocname" ]; then
                echo_getlocname
            elif [ "$input1" == "getloc" ]; then
                echo_getloc
            else
                if [ "$input1" == "quit" ]; then
                    cat "" > "$SCRIPT_DIR/../logs/.command_history"
                    output sad
                    tell_farewell
                else
                    output random
                    echo ">" $input1 $input2
                fi
                
            fi

        done

    fi

fi