#!/usr/bin/env bash
# /opt/homebrew/bin/bash
# /bin/bash

# Define the name of the virtual environment
VENV_NAME="$HOME/.venv"
# Check if the virtual environment already exists
if [[ ! -d "$VENV_NAME" ]]; then
    # Create the virtual environment if it doesn't exist
    python3 -m venv "$VENV_NAME" --system-site-packages
fi

# Start a new shell with the virtual environment activated
# Use a subshell to temporarily modify the environment
bash --rcfile <(echo "source /etc/profile;\
source $HOME/.bashrc;\
source $VENV_NAME/bin/activate")