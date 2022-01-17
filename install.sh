#!/bin/bash
set -eu

# homebrew がインストールされていない場合インストール
if [ ! -f /usr/local/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew has installed."
fi

#dotfile ないときはgit clone 
if [ ! -d ~/dotfiles ]; then
  cd ~
  git clone git@github.com:comu2e/dotfiles.git
else
  echo "dotfile is already exist."
fi 

# install software from BrewBundle.
brew bundle -v --file=~/dotfiles/Brewfile

# if .config has not made ,error will occur.
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

# symlink each config file.
stow -v -d ~/dotfiles/packages/termial/ -t ~ alacritty fish omf starship tmux
stow -v -d ~/dotfiles/packages/virual_environment/ -t ~ docker
stow -v -d ~/dotfiles/packages/versioning -t ~ git-templates
stow -v -d ~/dotfiles/packages/editor -t ~ coc nvim
stow -v -d ~/dotfiles/packages/wm -t ~ limelight yabai
stow -v -d ~/dotfiles/packages/keybindings -t ~ karabiner
ln -sf "~/.config/yabai/yabairc" "~/.yabairc"
ln -sf "~/.config/yabai/skhdrc" "~/.skhdrc"
cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
