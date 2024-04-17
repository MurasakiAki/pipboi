#!/bin/bash

# Find the full path to src/pipboi.sh
export SCRIPT_DIR="$(dirname "$0")/src"
PIPBOI_SCRIPT="$SCRIPT_DIR/pipboi.sh"

# Execute the script with provided arguments
bash "$PIPBOI_SCRIPT" "$1" "$2"
