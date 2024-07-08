# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path
path=(
	/bin
	/opt/homebrew/bin
	/Library/Frameworks/Python.framework/Versions/3.12/bin
	/usr/local/bin
	/System/Cryptexes/App/usr/bin
	/usr/bin
	/bin
	/usr/sbin
	/sbin
	/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
	/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
	/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
	/Applications/"Visual Studio Code.app"/Contents/Resources/app/bin
	/Users/tenzin/.zshscripts
	/usr/local/lib/python3.7/site-packages:/usr/lib/python3.7/site-packages
	/opt/homebrew/lib/python3.11/site-packages
	$HOME/.cargo/bin
)

# Environment variables
export PATH
export CLICOLOR=1
#export RUST_BACKTRACE=1

alias cpp="clang++ -std=c++20"
alias p="python3"
alias nv="nvim"
alias csw="cd /Users/tenzin/.local/state/nvim/swap"
alias rj="run_java.zsh"
alias rc="run_c.zsh"
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"

nvinit(){
  cd /Users/tenzin/.config/nvim
  nvim init.lua 
}
nvzsh(){
  nvim ~/.zshrc
  source ~/.zshrc
}



eval "$(zoxide init --cmd cd zsh)"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify


bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^f' autosuggest-accept

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
