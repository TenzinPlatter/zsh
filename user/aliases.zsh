[[ -f ~/.zsh/machine.zsh ]] && source ~/.zsh/machine.zsh

alias gvr="gama vessel down && gama vessel up"
alias gv="gama vessel"
alias dk="docker"
alias dl="docker logs"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"

alias cb="colcon build"
alias cbuild="colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
alias cbuilds="colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

alias srz="source $ZDOTDIR/.zshrc"
alias new="exec zsh"

alias ssr="ssh rock@rock-5b"
alias ssb="ssh gr@blueboat"
alias ssp="ssh pandora@pandora"

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
alias python="python3"
alias mkdir="mkdir -p"
alias rmd="rm -rf"

alias rbug="RUST_BACKTRACE=1"
alias cr="cargo run"
alias ct="cargo test"

alias db='distrobox'
alias dbr="distrobox enter ros"
alias dbs="distrobox enter siri"

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
alias nvsh='(cd ~/.config/zsh && nv) && new'
alias nvenv='nv ~/.zshenv && source ~/.zshenv'
alias nvhl='nv ~/.config/hypr/.'
alias nvcf='cd ~/.config/nvim && nv && cd -'
alias nval='nv ~/.config/zsh/user/aliases.zsh && new'
alias nvfn='nv ~/.config/zsh/user/fns.zsh && new'
alias nvsc='nv ~/.scripts'
alias nvzsh='cd ~/.config/zsh && nv && source ~/.config/.zsh/.zshrc && cd -'
alias nvcl="nv ~/.clang-format"
alias nvtx="nv ~/.tmux.conf"

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
