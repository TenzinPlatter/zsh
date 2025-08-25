#!/usr/bin/env zsh

txa() {
  if [[ -z "$1" ]]; then
    tmux attach-session
  else
    tmux attach-session -t "$1"
  fi
}

txn() {
  if [[ -z "$1" ]]; then
    tmux new-session
  else
    tmux new-session -s "$1"
  fi
}

nr() {
    if [ $# -eq 0 ]; then
        echo "Usage: nix-remove-many <package1> <package2> ..."
        echo "Example: nix-remove-many firefox git nodejs"
        return 1
    fi
    
    echo "Removing packages: $@"
    for package in "$@"; do
        echo "Removing: $package"
        nix-env -e "$package"
    done
}

ni() {
    # Check if at least one argument is provided
    if [[ $# -eq 0 ]]; then
        echo "Error: At least one package name is required"
        echo "Usage: nix-install <package1> [package2] [package3] ..."
        return 1
    fi
    
    # Loop through all arguments and try to install each package
    for package in "$@"; do
        echo "Installing package: $package"
        
        # Try to install the package using nix-env
        if nix-env -iA nixpkgs.$package; then
            echo "✅ Successfully installed: $package"
        else
            echo "❌ Failed to install: $package"
            echo "   Trying alternative installation method..."
            
            # Try installing without the nixpkgs prefix
            if nix-env -i $package; then
                echo "✅ Successfully installed: $package (alternative method)"
            else
                echo "❌ Failed to install: $package (both methods failed)"
            fi
        fi
        
        echo "---"
    done
    
    echo "Installation process completed for all packages."
}

inr() {
	sudo apt install ros-jazzy-$1
}

sr() {
  if ! command -v ros2 &> /dev/null; then
    source /opt/ros/jazzy/setup.zsh
    echo "Sourced global overlay at /opt/ros/jazzy"
  fi

  if [[ ! "$(which rosdep)" = "/home/tenzin/Repositories/rosdep/install/rosdep/bin/rosdep" ]]; then
    source /home/tenzin/Repositories/rosdep/install/setup.zsh
    echo "Sourced rosdep fork at /home/tenzin/Repositories/rosdep"
  fi

	if [[ -f ./install/setup.zsh ]]; then
		source ./install/setup.zsh
		echo "Sourced local workspace"
	fi
}

foxglove() {
	if ! command -v "ros2" >/dev/null 2>&1; then
		source /opt/ros/jazzy/setup.zsh
	fi

	ros2 launch foxglove_bridge foxglove_bridge_launch.xml > /dev/null  2>&1 &
}

set-nv() {
	if [[ -z $BUFFER ]]; then
		fzf-file-widget
		BUFFER="nv $BUFFER"
		zle accept-line
	else
		LBUFFER="nv "
	fi
}

sudo-command-line () {
        [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
        local WHITESPACE=""
        if [[ ${LBUFFER:0:1} = " " ]]
        then
                WHITESPACE=" "
                LBUFFER="${LBUFFER:1}"
        fi
        {
                local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}
                if [[ -z "$EDITOR" ]]
                then
                        case "$BUFFER" in
                                (sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "" ;;
                                (sudo\ *) __sudo-replace-buffer "sudo" "" ;;
                                (*) LBUFFER="sudo $LBUFFER"  ;;
                        esac
                        return
                fi
                local cmd="${${(Az)BUFFER}[1]}"
                local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
                local editorcmd="${${(Az)EDITOR}[1]}"
                if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"
                then
                        __sudo-replace-buffer "$cmd" "sudo -e"
                        return
                fi
                case "$BUFFER" in
                        ($editorcmd\ *) __sudo-replace-buffer "$editorcmd" "sudo -e" ;;
                        (\$EDITOR\ *) __sudo-replace-buffer '$EDITOR' "sudo -e" ;;
                        (sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "$EDITOR" ;;
                        (sudo\ *) __sudo-replace-buffer "sudo" "" ;;
                        (*) LBUFFER="sudo $LBUFFER"  ;;
                esac
        } always {
                LBUFFER="${WHITESPACE}${LBUFFER}"
                zle && zle redisplay
        }
}

set-cd() {
	if [[ -z $BUFFER ]]; then
		LBUFFER="cd "
	else
		BUFFER="cd $BUFFER"
		zle accept-line
	fi
}

function findbin() {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    PM="pm.sh"
    # Try to find pm.sh in common locations
    if [ ! command -v "${PM}" ] &>/dev/null; then
        for path in "/usr/lib/hyde" "/usr/local/lib/hyde" "$HOME/.local/lib/hyde" "$HOME/.local/bin"; do
            if [[ -x "$path/pm.sh" ]]; then
                PM="$path/pm.sh"
                break
            else
                unset PM
            fi
        done
    fi

    if ! command -v "${PM}" &>/dev/null; then
        printf "${bright}${red}We cannot find package manager script (${purple}pm.sh${red}) from ${green}HyDE${reset}\n"
        return 127
    fi

    if ! "${PM}" fq "/usr/bin/$1"; then
        printf "${bright}${green}[ ${1} ]${reset} ${purple}NOT${reset} found in the system and no package provides it.\n"
        return 127
    else
        printf "${green}[ ${1} ] ${reset} might be provided by the above packages.\n"
        for entry in $entries; do
            # Assuming the entry already has ANSI color codes, we don't add more colors
            printf "  %s\n" "${entry}"
        done

    fi
    return 127
}

workon() {
  # idk from chatgpt
  setopt nullglob
  
  venv=""
  
  if [[ ! -z "$1" ]]; then
    venv=$1
  else
		# match hidden and normal dirs
    for d in */ .*/ ; do
      # $d ends in slash already, so don't include it in path
      if [[ -f "$d"bin/activate ]]; then
        venv=$d
        break
      fi
    done 2>/dev/null
  fi

  if [[ -z $venv ]]; then
    echo no venv found/provided, defaulting to \'venv\'
    venv="venv"
  elif [[ -d $venv && -f $venv/bin/activate ]]; then
    echo found venv \'$venv\', activating...
  else
    echo creating venv \'$venv\'
  fi

  if [[ ! -d $venv ]]; then
    python3 -m venv $venv
  fi  

	source $venv/bin/activate
}

missim() {
    # Unset the function temporarily to check for the real command
    unset -f missim
    
    # Check if missim command exists
    if command -v missim > /dev/null 2>&1; then
        # Call the actual missim command with all arguments
        missim "$@"
    else
        # Source the hardcoded virtual environment
        local venv_path="/home/tenzin/Repositories/missim/missim"
        
        if [[ ! -f "$venv_path/bin/activate" ]]; then
            echo "Error: Virtual environment not found at $venv_path"
            # Restore the function before returning
            source /home/tenzin/.config/zsh/user/fns.zsh
            return 1
        fi
        
        # Source the virtual environment and call missim
        source "$venv_path/bin/activate"
        
        # Check if missim is now available
        if command -v missim > /dev/null 2>&1; then
            missim "$@"
        else
            echo "Error: missim command not found even after sourcing virtual environment"
            # Restore the function before returning
            source /home/tenzin/.config/zsh/user/fns.zsh
            return 1
        fi
    fi
    
    # Restore the function for next time
    source /home/tenzin/.config/zsh/user/fns.zsh
}

lookout() {
    # Unset the function temporarily to check for the real command
    unset -f lookout
    
    # Source the hardcoded virtual environment first
    local venv_path="/home/tenzin/Repositories/lookout/lookout"
    
    if [[ ! -f "$venv_path/bin/activate" ]]; then
        echo "Error: Virtual environment not found at $venv_path"
        # Restore the function before returning
        source /home/tenzin/.config/zsh/user/fns.zsh
        return 1
    fi
    
    # Source the virtual environment and call lookout
    source "$venv_path/bin/activate"
    
    # Check if lookout is now available
    if command -v lookout > /dev/null 2>&1; then
        command lookout "$@"
    else
        echo "Error: lookout command not found even after sourcing virtual environment"
        # Restore the function before returning
        source /home/tenzin/.config/zsh/user/fns.zsh
        return 1
    fi
    
    # Restore the function for next time
    source /home/tenzin/.config/zsh/user/fns.zsh
}

unalias gama 2>/dev/null
gama() {
    # Unset the function temporarily to check for the real command
    unset -f gama
    
    # Source the hardcoded virtual environment first
    local venv_path="/home/tenzin/Repositories/gama/gama"
    
    if [[ ! -f "$venv_path/bin/activate" ]]; then
        echo "Error: Virtual environment not found at $venv_path"
        # Restore the function before returning
        source /home/tenzin/.config/zsh/user/fns.zsh
        return 1
    fi
    
    # Source the virtual environment and call gama
    source "$venv_path/bin/activate"
    
    # Check if gama is now available
    if command -v gama > /dev/null 2>&1; then
        command gama "$@"
    else
        echo "Error: gama command not found even after sourcing virtual environment"
        # Restore the function before returning
        source /home/tenzin/.config/zsh/user/fns.zsh
        return 1
    fi
    
    # Restore the function for next time
    source /home/tenzin/.config/zsh/user/fns.zsh
}

prepend-sudo() {
    # Store current cursor position
    local cursor_pos=$CURSOR
    
    # If buffer is empty or only whitespace, use last command from history
    if [[ -z "${BUFFER// }" ]]; then
        # Get the last command from history
        BUFFER=$(fc -ln -1)
        # Set cursor to end of buffer
        cursor_pos=${#BUFFER}
    fi
    
    # Trim leading whitespace from buffer
    local trimmed_buffer="${BUFFER#"${BUFFER%%[![:space:]]*}"}"
    
    # Check if command already starts with sudo
    if [[ "$trimmed_buffer" =~ ^sudo[[:space:]] ]]; then
        # Command already has sudo, do nothing
        return
    fi
    
    # Calculate how much whitespace was at the beginning
    local leading_space="${BUFFER%"$trimmed_buffer"}"
    
    # If there's any actual command content, prepend sudo
    if [[ -n "$trimmed_buffer" ]]; then
        BUFFER="${leading_space}sudo $trimmed_buffer"
        # Adjust cursor position (+5 for "sudo ")
        cursor_pos=$((cursor_pos + 5))
    else
        # Buffer was empty, just set to "sudo "
        BUFFER="sudo "
        cursor_pos=5
    fi
    
    # Restore cursor position
    CURSOR=$cursor_pos
}
