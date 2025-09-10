#!/usr/bin/env zsh

# Load modules from ~/.config/zsh/modules.yaml using Python YAML parser
load_modules() {
    local python_script="${ZDOTDIR:-$HOME/.config/zsh}/load-modules.py"
    
    if [[ ! -f "$python_script" ]]; then
        echo "Error: Python module loader not found at $python_script" >&2
        return 1
    fi
    
    # Execute the Python script and evaluate its output
    eval "$(python3 "$python_script")"
}

load_modules
