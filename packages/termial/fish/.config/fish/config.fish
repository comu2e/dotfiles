# ~/.config/fish/config.fish

export LSCOLORS=Gxfxcxdxbxegedabagacad

#hub
eval (hub alias -s)

# alias

#atcoder
abbr -a ojt oj t -c \"python3 main.py\"
abbr -a acs acc submit main.py -- --guess-python-interpreter pypy
#git
#docker
abbr -a d docker 
abbr -a dc docker-compose 
abbr -a dcu docker-compose up 
abbr -a dcd docker-compose down
abbr -a dce docker-compose exec
abbr -a dcep docker-compose exec app php artisan 
abbr -a dcbash docker-compose exec app /bin/bash 
#phptest
abbr -a dtest docker-compose exec app vendor/bin/phpunit
abbr -a phptest vendor/bin/phpunit
abbr -a pa php artisan make
#terraform
abbr -a ta terraform apply
abbr -a tp terraform plan
abbr -a ti terraform init
abbr -a td terraform destroy
#Git
#AWSP
function awsp
    AWS_PROFILE="$AWS_PROFILE" _awsp_prompt
    set selected_profile (cat ~/.awsp)
    set -xU AWS_PROFILE $selected_profile
end

alias vim="nvim"
alias ga="git add"
alias gbd="git branch -d"
alias gb='git branch'
alias gcm='git commit -m'
alias gca="git commit --amend"
alias g="git checkout"
alias gcb="git checkout -b"
alias gl="git log --date=iso --decorate"
alias glp="git log --date=iso --decorate --patch"
alias glg="git log --date=iso --graph --decorate --oneline --all"
alias gs="git status"
alias gf="git fetch"
alias gp="git pull"
alias gst="git stash"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gstd="git stash drop"


#exa
alias ls="exa"
alias la="exa -l -g --icons"
alias ll='exa -ahl --git'

#Atcoder
abbr -a acn acc new abc
abbr -a acu acc url
abbr -a .. cd ../..

#lazydocker
abbr -a ld lazydocker
#lazygit
abbr -a lg lazygit
#kubernetes
abbr -a k kubectl
abbr -a po pods
#tmux
alias ide="~/.config/tmux/bin/ide.sh"
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"
abbr -a tas tmux attach-session -t
abbr -a tm tmux
abbr -a tls tmux list-session
#Rust
abbr -a cr cargo run
abbr -a cb cargo build
abbr -a ccn cargo compete new abc
abbr -a cco cargo compete open
abbr -a cct cargo compete test
abbr -a ccs cargo compete submit
#Zellij
abbr -a zj zellij
abbr -a zls zellij list-sessions
abbr -a za zellij attach
#check global ip
abbr -a ip curl ipinfo.io
#setting
alias vcon="vim ~/.config/nvim/init.vim"
alias zcon="vim ~/.config/zellij/config.yaml"
alias fcon="vim ~/.config/fish/config.fish"
alias tcon="vim ~/.config/tmux/.tmux.conf"
alias alcon="vim ~/.config/alacritty/alacritty.yml"
alias m="make"
alias tk="tmux kill-server"
alias vpcon="vim ~/.config/nvim/plug.vim"
#aws
abbr -a awsssm aws ecs update-service \
    --cluster example-cluster \
    --service example-service \
    --enable-execute-command
#peco
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
#vi mode
fish_vi_key_bindings
alias yabai="brew services restart yabai"
#Go
#psql
set -x PATH /usr/local/opt/libpq/bin:$PATH
#bzip2
set -gx LDFLAGS "-L/usr/local/opt/bzip2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/bzip2/include"

#krew
set -gx PATH $PATH $HOME/.krew/bin

#fish message
#set fish_greeting
# Path to z 
set -g Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
abbr -a j z
#exa command
function ls
  command exa -lh --time-style=long-iso --icons --sort=Name $argv
end

## NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end
#switch (uname)

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

source /usr/local/opt/asdf/asdf.fish

starship init fish | source

set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
eval (goenv init - | source)
set -x PATH $GOPATH/bin $PATH
