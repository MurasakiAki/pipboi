#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/output_pip.sh

function apply_job_idle() {
    python3 -c "import sensor_funcs; send_job_idle()"
}

function apply_job_dist() {
    python3 -c "import sensor_funcs; send_job_dist()"
}

function apply_job_temp() {
    python3 -c "import sensor_funcs; send_job_temp()"
}

function apply_job_tilt() {
    python3 -c "import sensor_funcs; send_job_tilt()"
}