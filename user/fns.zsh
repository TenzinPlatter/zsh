#!/usr/bin/env zsh

gfr() {
  dir="$1"
  old="$2"
  new="$3"

  echo "Replacing $old with $new in $dir"
  command="grep -lR ${old} ${dir} | xargs sed -i 's/${old}/${new}/g'"
  echo Running "$command"
  grep -lR ${old} ${dir} | xargs sed -i 's/${old}/${new}/g'
}

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
    ros_path="/opt/ros/jazzy/setup.zsh"
    if [[ -f /opt/ros/humble/setup.zsh ]]; then
      ros_path="/opt/ros/humble/setup.zsh"
    fi
    source $ros_path
    echo "Sourced global overlay at $ros_path"
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
		sr
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

run-ls() {
	BUFFER="ls $BUFFER"
	zle accept-line
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
