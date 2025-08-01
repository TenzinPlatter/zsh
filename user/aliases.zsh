alias gvr="gama vessel down && gama vessel up"
alias gv="gama vessel"
alias dk="docker"

alias cbuild="colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
alias cbuilds="colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

alias srz="source ~/.zshrc"

alias ssr="ssh rock@rock-5b"
alias ssb="ssh gr@blueboat"
# alias ssr="ssh rock@10.71.11.117"

alias killpgad="kill $(pidof /home/tenzin/.scripts/open_pgadmin.sh)"
alias workoff="deactivate"
alias cinit='eval "$(/home/tenzin/anaconda3/bin/conda shell.zsh hook)" && conda init'
alias pgres="sudo -u postgres -i /bin/bash"

alias l='eza -lh --icons auto' # long list
alias ls='eza -1 --icons auto -a' # short list
alias sl='ls'
alias ll='eza -lha --icons auto --sort name --group-directories-first' # long list all
alias ld='eza -lhD --icons auto' # long list dirs
alias lt='eza --icons auto --tree' # list folder as tree

alias gdb="gdb --tui"
alias cx="chmod u+x"
alias ff="pokego -r 1 --no-title | fastfetch --file-raw -"
alias c="clear"
alias lg='lazygit'
alias cat='bat'
alias mk="make"
alias cc="clang"
alias p='python'
alias mkdir="mkdir -p"
alias rmd="rm -rf"

alias rbug="RUST_BACKTRACE=1"
alias cr="cargo run"
alias ct="cargo test"

alias db='distrobox'
alias dbr="distrobox enter ros"

alias tmuxkill="tmux kill-session"
alias srtx="tmux source ~/.tmux.conf"
alias tx="tmux"

alias fzfd="find . -type d -print | fzf"
alias pkginfo="pacman -Qq | fzf --preview 'pacman -Qil {} | bat -fpl yml' --layout=reverse  --bind 'enter:execute(pacman -Qil {} | less)'"

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gP='git push'
alias gp='git pull'
alias gc='git commit'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "' 
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcl='git clone'
alias pca="pre-commit run --all"

alias nv="nvim"
alias vn="nv"
alias nvfd='nv $(fzfd)'
alias nvsh='nv ~/.zshrc && source ~/.zshrc'
alias nvenv='nv ~/.zshenv && source ~/.zshenv'
alias nvhl='nv ~/.config/hypr/.'
alias nvcf='nv ~/.config/nvim/.'
alias nval='nv ~/.zsh/aliases.zsh && source ~/.zshrc'
alias nvfn='nv ~/.zsh/fns.zsh && source ~/.zshrc'
alias nvsc='nv ~/.scripts'
alias nvzsh='nv ~/.zsh && source ~/.zshrc'
alias nvcl="nv ~/.clang-format"
alias nvtx="nv ~/.tmux.conf"

alias xh="hx"
alias hxf='hx $(fzf)'
alias hxfd='hx $(fzfd)'
alias hxsh='hx ~/.zshrc && source ~/.zshrc'
alias hxenv='hx ~/.zshenv && source ~/.zshenv'
alias hxhl='hx ~/.config/hypr/.'
alias hxcf='hx ~/.config/helix/.'
alias hxal='hx ~/.zsh/aliases.zsh && source ~/.zshrc'
alias hxfn='hx ~/.zsh/fns.zsh && source ~/.zshrc'
alias hxsc='hx ~/.scripts'
alias hxzsh='hx ~/.zsh && source ~/.zshrc'
alias hxcl="hx ~/.clang-format"
alias hxtx="hx ~/.tmux.conf"

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

[[ -f ~/.zsh/machine.zsh ]] && source ~/.zsh/machine.zsh

