#!/usr/bin/env zsh

yir() {
	sudo apt install ros-jazzy-$1
}

sr() {
	source /opt/ros/jazzy/setup.zsh
	source /home/tenzin/greenroom/rosdep/install/setup.zsh
	source /home/tenzin/greenroom/pwmdriver/install/setup.zsh

	if [[ -f ./install/setup.zsh ]]; then
		source ./install/setup.zsh
	fi
}

foxglove() {
	if ! command -v "ros2" >/dev/null 2>&1; then
		source /opt/ros/jazzy/setup.zsh
	fi

	ros2 launch foxglove_bridge foxglove_bridge_launch.xml > /dev/null  2>&1 &
}

set-nv() {
	BUFFER="nv $BUFFER"
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
    for d in */ ; do
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
