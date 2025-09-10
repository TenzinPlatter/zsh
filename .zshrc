bindkey -e

export EDITOR=nvim

for entry in ~/.config/zsh/user/*; do
    if [[ -f $entry ]]; then
        source $entry
        continue
    fi

    for file in $entry/*; do
        source $file
    done
done

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
)

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=""

export EDITOR="nvim"
export NIXPKGS_ALLOW_UNFREE=1

export PATH="${(j/:/)path}"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-13.0/lib64

setopt NO_AUTO_CD

eval "$(zoxide init zsh --cmd cd)"

bindkey '^ ' autosuggest-accept

zle -N menu-search
zle -N recent-paths

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
