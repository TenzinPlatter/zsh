if [[ $- == *i* ]]; then
  pokego -r 1 --no-title 2>/dev/null | fastfetch --file-raw - 2>/dev/null

  source $ZSH/oh-my-zsh.sh 2>/dev/null
  . "$HOME/.cargo/env" 2>/dev/null
	eval "$(zoxide init zsh --cmd cd)" 2>/dev/null

  bindkey '^ ' autosuggest-accept

  zle -N set-nv
  bindkey '' set-nv

  zle -N set-cd
  bindkey '' set-cd

  zle -N prepend-sudo
  bindkey '\e\e' prepend-sudo

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

