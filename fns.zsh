#!bin/zsh

nv() {
if [[ $# -eq 0 ]]; then
		nvim .
	else
		nvim "$@"
	fi
}

hx() {
	if [[ $# -eq 0 ]]; then
		helix .
	else
		helix "$@"
	fi
}

findbin() {
  local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  if (( ${#entries[@]} > 0 )); then
      printf "${bright}$1${reset} may be found in the following packages:\n"
      local pkg
      for entry in "${entries[@]}"; do
          local fields=( ${(0)entry} )
          if [[ "$pkg" != "${fields[2]}" ]]; then
              printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
          fi
          printf '    /%s\n' "${fields[4]}"
          pkg="${fields[2]}"
      done
  fi
  return 127
}

workon() {
	source $1/bin/activate
}
