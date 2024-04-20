#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/output_pip.sh

function apply_job_idle() {
    python3 -c "from sensor_funcs send_job_idle; send_job_idle()"
}

function apply_job_dist() {
    output normal
    echo You can see the distance on the second screen
    python3 -c "from sensor_funcs import send_job_dist; send_job_dist()"
}

function apply_job_temp() {
    output normal
    echo You can see the temp/hum on the second screen
    python3 -c "from sensor_funcs import send_job_temp; send_job_temp()"
}

function apply_job_tilt() {
    python3 -c "from sensor_funcs import send_job_tilt; send_job_tilt()"
}