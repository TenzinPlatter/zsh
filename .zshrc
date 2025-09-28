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
)

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=""

export EDITOR="nvim"
export NIXPKGS_ALLOW_UNFREE=1

export PATH="${(j/:/)path}"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-13.0/lib64

# export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.cache/lazygit-theme.yml"

setopt NO_AUTO_CD

bindkey '^ ' autosuggest-accept

zle -N menu-search
zle -N recent-paths

 #  Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/tenzin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
