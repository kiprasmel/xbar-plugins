#!/bin/bash

# hacking to fix python paths

UV_DIR="$HOME/.local/bin"
DIRNAME="$(realpath "$(dirname "$0")")"
SCRIPT_PATH="$(realpath "$DIRNAME/sun.1m.sh")" # symlinked from ~/Library/Application Support/xbar/plugins/sun.1m.sh to real location of this script
REAL_SCRIPT_PATH="$(dirname "$SCRIPT_PATH")/sun.1m.py" # replace wrapper .sh script to real .py script

"$UV_DIR/uv" run "$REAL_SCRIPT_PATH"
