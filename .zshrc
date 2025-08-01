export EDITOR=nvim

for file in ~/.config/zsh/user/*; do
  source $file
done

eval "$(zoxide init zsh --cmd cd)"

# hyde user stuff
source ~/.config/zsh/user.zsh
