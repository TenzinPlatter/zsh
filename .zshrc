export EDITOR=nvim

for file in ~/.config/zsh/user/*; do
  source $file
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
)

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME=""

export PATH="${(j/:/)path}"
export EDITOR="nvim"
export NIXPKGS_ALLOW_UNFREE=1

setopt NO_AUTO_CD 

plugins=(
	zsh-autosuggestions
	you-should-use
)

eval "$(zoxide init zsh --cmd cd)"

# hyde user stuff
source ~/.config/zsh/user.zsh
