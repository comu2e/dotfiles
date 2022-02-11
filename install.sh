#!/bin/bash
set -eu

log() {
    message=$1
    echo 📌 "$message"
}

is_file() {
    path="$1"
    [ -f "$path" ]
}

is_dir() {
    path="$1"
    [ -d "$path" ]
}

ensure_dir() {
    path="$1"
    if ! is_dir "$path"; then
        mkdir -p "$path"
    fi
}

# homebrew がインストールされていない場合インストール
if [ ! -f /usr/local/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew has installed."
fi

#dotfile ないときはgit clone 
if [ ! -d ~/dotfiles ]; then
  cd ~
  git clone git@github.com:comu2e/dotfiles.git
else
  log "dotfile is already exist."
fi 

# install software from BrewBundle.
brew bundle -v --file=~/dotfiles/Brewfile

# if .config has not made ,error will occur.
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

# asdf
for plugin in $(awk '{print $1}' ~/.tool-versions); do
    if ! is_dir ~/.asdf/plugins/"$plugin"; then
        asdf plugin add "$plugin"
    fi
done


log "asdf already finished"

# symlink each config file.
stow -v -d ~/dotfiles/packages/termial/ -t ~ alacritty fish omf starship tmux
stow -v -d ~/dotfiles/packages/versioning -t ~ git-templates
stow -v -d ~/dotfiles/packages/editor -t ~ nvim
 stow -v -d ~/dotfiles/packages/runtime -t ~ runtime
stow -v -d ~/dotfiles/packages/wm -t ~ limelight yabai
stow -v -d ~/dotfiles/packages/keybindings -t ~ karabiner
ln -sf ~/.config/yabai/yabairc ~/.yabairc 
ln -sf ~/.config/yabai/skhdrc ~/.skhdrc

is_runtime_versions_changed () {
    plugin="$1"
    specified=$(grep "$plugin" ~/.tool-versions | awk '{$1=""; print $0}')
    installed=$(asdf list "$plugin" 2>&1)

    is_changed=
    for version in $specified; do
        match=$(echo "$installed" | grep "$version")
        [ -z "$match" ] && is_changed=1
    done

    [ "$is_changed" ]
}

if [ ! -d ~/.local/share/omf/ ];then
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi
# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END

