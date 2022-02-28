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

unlink_packages=
verbose=
for i in "$@"; do
    case "$i" in
       -s|--skip-apps)
            skip_apps=1
            shift ;;
        -v|--verbose)
            verbose=1
            shift ;;
        -u=*|--unlink=*)
            unlink_packages="${i#*=}"
            shift ;;
        *) ;;
    esac
done

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
log "Install APps and CLis"
brew bundle -v --file=~/dotfiles/Brewfile

# if .config has not made ,error will occur.
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

if [ !-d ~/.config/vim ]; then
  mkdir ~/.confgi/vim
fi
if [ !-d ~/.config/vim/plugged ]; then
  mkdir ~/.confgi/vim/plugged
fi


# symlink each config file.
stow -v -d ~/dotfiles/packages/termial/ -t ~ alacritty fish omf starship tmux
stow -v -d ~/dotfiles/packages/versioning -t ~ git-templates git
stow -v -d ~/dotfiles/packages/editor -t ~ nvim
stow -v -d ~/dotfiles/packages/runtime -t ~ runtime
stow -v -d ~/dotfiles/packages/wm -t ~ limelight yabai
stow -v -d ~/dotfiles/packages/keybindings -t ~ karabiner
ln -sf ~/.config/yabai/yabairc ~/.yabairc 
ln -sf ~/.config/yabai/skhdrc ~/.skhdrc
ln -sf ~/dotfiles/packages/versioning/asdf/asdf.fish ~/.asdf/asdf.fish

# asdf
for plugin in $(awk '{print $1}' ~/.tool-versions); do
    if ! is_dir ~/.asdf/plugins/"$plugin"; then
        asdf plugin add "$plugin"
    fi
done

for plugin in $(asdf plugin list); do
    if is_runtime_versions_changed "$plugin"; then
        log "Install runtime: $plugin"
        asdf install "$plugin"
    fi
done

for plugin in $(asdf plugin list); do
    if is_runtime_versions_changed "$plugin"; then

        log "Install runtime: $plugin"
        asdf install "$plugin"
    fi
done
#
log "asdf already finished"

#install omf
if [ ! -d ~/.local/share/omf/ ];then
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

#install dein
if [ ! -d $HOME/.cache/dein ];then
  
  mkdir $HOME/.cache/dein
  cd $HOME/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
  sh ./installer.sh ~/.cache/dein
fi
cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END

