unalias gama 2>/dev/null

cdp() {
    cd /home/tenzin/Repositories/platform/packages/platform_$1
}

missim() {
    # Unset the function temporarily to check for the real command
    unset -f missim

    # Check if missim command exists
    if command -v missim > /dev/null 2>&1; then
        # Call the actual missim command with all arguments
        missim "$@"
    else
        # Source the virtual environment
        local venv_path="$HOME/Repositories/missim/missim"

        if [[ ! -f "$venv_path/bin/activate" ]]; then
            echo "Error: Virtual environment not found at $venv_path"
            # Restore the function before returning
            source "$HOME/.config/zsh/user/fns/gr.zsh"
            return 1
        fi

        # Source the virtual environment and call missim
        source "$venv_path/bin/activate"

        # Check if missim is now available
        if command -v missim > /dev/null 2>&1; then
            missim "$@"
            # Deactivate venv after command execution
            deactivate
        else
            echo "Error: missim command not found even after sourcing virtual environment"
            # Deactivate venv and restore the function before returning
            deactivate
            source "$HOME/.config/zsh/user/fns/gr.zsh"
            return 1
        fi
    fi

    # Restore the function for next time
    source "$HOME/.config/zsh/user/fns/gr.zsh"
}

lookout() {
    # Unset the function temporarily to check for the real command
    unset -f lookout

    # Source the virtual environment first
    local venv_path="$HOME/Repositories/lookout/lookout"

    if [[ ! -f "$venv_path/bin/activate" ]]; then
        echo "Error: Virtual environment not found at $venv_path"
        # Restore the function before returning
        source "$HOME/.config/zsh/user/fns/gr.zsh"
        return 1
    fi

    # Source the virtual environment and call lookout
    source "$venv_path/bin/activate"

    # Check if lookout is now available
    if command -v lookout > /dev/null 2>&1; then
        command lookout "$@"
        # Deactivate venv after command execution
        deactivate
    else
        echo "Error: lookout command not found even after sourcing virtual environment"
        # Deactivate venv and restore the function before returning
        deactivate
        source "$HOME/.config/zsh/user/fns/gr.zsh"
        return 1
    fi

    # Restore the function for next time
    source "$HOME/.config/zsh/user/fns/gr.zsh"
}

gama() {
    # Unset the function temporarily to check for the real command
    unset -f gama

    # Source the virtual environment first
    local venv_path="$HOME/Repositories/gama/gama"

    if [[ ! -f "$venv_path/bin/activate" ]]; then
        echo "Error: Virtual environment not found at $venv_path"
        # Restore the function before returning
        source "$HOME/.config/zsh/user/fns/gr.zsh"
        return 1
    fi

    # Source the virtual environment and call gama
    source "$venv_path/bin/activate"

    # Check if gama is now available
    if command -v gama > /dev/null 2>&1; then
        command gama "$@"
        # Deactivate venv after command execution
        deactivate
    else
        echo "Error: gama command not found even after sourcing virtual environment"
        # Deactivate venv and restore the function before returning
        deactivate
        source "$HOME/.config/zsh/user/fns/gr.zsh"
        return 1
    fi

    # Restore the function for next time
    source "$HOME/.config/zsh/user/fns/gr.zsh"
}

set_platform_module() {
    local dir_name="${PWD:t}"
    export PLATFORM_MODULE="$dir_name"
}

pbc() {
    if [[ "$(which rosdep)" == "/usr/bin/rosdep" ]]; then
        sr
    fi

    if [[ "$1" == "-i" ]]; then
        platform pkg install-deps
    fi

    echo Running: colcon build --merge-install --install-base "/opt/greenroom/$PLATFORM_MODULE" --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

    colcon build --merge-install --install-base "/opt/greenroom/$PLATFORM_MODULE" --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

    unset PLATFORM_MODULE
}

autoload -U add-zsh-hook
add-zsh-hook chpwd set_platform_module
