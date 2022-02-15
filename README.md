# Concept
Setup fast dev environment.

## Environment
Mac PC (Big Sur 11.4)

## Usage
```

$ curl -o - https://raw.githubusercontent.com/comu2e/dotfiles/master/install.sh | sh
```

```
$ brew start service start skhd
$ brew start service start yabai
```

window management is configured detail of keybindings with skhdrc(packages/keybindings/skhd/skhrdrc).


## fish/Alacritty/nvim  configuration

alias has set with below.

```
fish -> $ fcon #fish configuration
Alacritty -> $ alcon #Alacritty configuration
nvim -> $ vcon # vim configuration
vim plugin configure -> $ vpcon # vim plugin configuration

```

### Keybindings configuration
Edit skhdrc

If not working keybindings,execute below command,and debug.
```
$ skhd -V
```

### Vim
Set up <Leader> is <Space>
```
usage 
$ vim
$ #normal mode
$ <Space> + (f,or ....)
```

#### Dein

```
$ vim
$ <Esc> :call dein#Update()
```

#### sonic-template
```
$vim main.go
$<insert mode> main<C-l> 
```
