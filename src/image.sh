#!/bin/bash

function draw_image() {
    usrnm=$1
    img_file=$2
    if [ -f "../.$usrnm/$img_file" ]; then
        python3 -c "from logger import Logger; Logger('../logs/system-log.txt').log_message('INFO', 'Drawing $img_file')"
        script_command=$(python -c "from image_funcs import image_to_ascii; image_to_ascii('$usrnm', '$img_file')")
        output normal
        echo "$script_command"
        echo "image"
    fi
}