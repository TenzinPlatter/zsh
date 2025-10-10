bindkey -e

export EDITOR=nvim

source "${ZDOTDIR:-$HOME}/load-modules.zsh"

path=(
    $PATH
    ~/.cargo/bin
    ~/.npm-packages
    ~/scripts
    /home/tenzin/.spicetify
    /home/tenzin/.local/bin
    /usr/bin
    /usr/local/bin
    /usr/local/cuda-13.0/bin
    /home/tenzin/bin
)

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=""

export EDITOR="nvim"
export NIXPKGS_ALLOW_UNFREE=1

export PATH="${(j/:/)path}"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-13.0/lib64
export POKEGO_CACHE_AGE=300

setopt NO_AUTO_CD

bindkey '^ ' autosuggest-accept

zle -N menu-search
zle -N recent-paths
