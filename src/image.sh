#!/bin/bash

function draw_image() {
    usrnm=$1
    img_file=$2
    if [ -f "../.$usrnm/$img_file" ]; then
        pyrthon -c "import image_funcs.py; image_to_ascii('$usrnm', '$img_file')"
    fi
}