[[ -f ~/.zsh/machine.zsh ]] && source ~/.zsh/machine.zsh

alias capson="sudo systemctl start udevmon"
alias capsoff="sudo systemctl stop udevmon"

alias dk="docker"
alias dl="docker logs -f"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"

alias srz="source $ZDOTDIR/.zshrc"
alias new="exec zsh"

alias killpgad="kill $(pidof /home/tenzin/.scripts/open_pgadmin.sh)"
alias workoff="deactivate"
alias cinit='eval "$(/home/tenzin/anaconda3/bin/conda shell.zsh hook)" && conda init'
alias pgres="sudo -u postgres -i /bin/bash"

alias gdb="gdb --tui"
alias cx="chmod u+x"
alias ff="pokego -r 1 --no-title | fastfetch --file-raw -"
alias c="clear"
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

alias pkginfo="pacman -Qq | fzf --preview 'pacman -Qil {} | bat -fpl yml' --layout=reverse  --bind 'enter:execute(pacman -Qil {} | less)'"

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
