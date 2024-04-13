#!/bin/bash

# Find the full path to src/pipboi.sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PIPBOI_SCRIPT="$SCRIPT_DIR/src/pipboi.sh"

# Check if the script exists
if [ ! -x "$PIPBOI_SCRIPT" ]; then
    echo "Error: $PIPBOI_SCRIPT does not exist or is not executable."
    exit 1
fi

# Execute the script with provided arguments
"$PIPBOI_SCRIPT" "$1" "$2"
