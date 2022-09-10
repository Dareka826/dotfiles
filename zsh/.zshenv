# Zsh Env

# Change zsh config location
export ZDOTDIR=$HOME/.config/zsh

# Fcitx
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export SDL_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"

# Qt style
export QT_STYLE_OVERRIDE="kvantum"

# Path
export PATH=$PATH:~/.local/bin

export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$(yarn global bin)
export PATH=$PATH:/mnt/DATA/android/apktool

# Rust
. "$HOME/.cargo/env"

# dbus
export DBUS_SESSION_BUS_ADDRESS="unix:abstract=/${UID}/dbus"

# Config for bemenu
export BEMENU_OPTS="-i -l 10 -p '' --tb '#6600ff' --tf '#ffffff' --fb '#111111' --ff '#ffffff' --cb '#111111' --cf '#ffffff' --nb '#111111' --nf '#ffffff' --hb '#6600ff' --hf '#ffffff' --sb '#222222' --sf '#ffffff'"

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export PAGER="less"
export WM="i3"

# FZF
export FZF_DEFAULT_OPTS="--preview-window=right:50%:sharp"

# KVM
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Disable less history
export LESSHISTFILE=-

# Colors in less
LESS_TERMCAP_md=$'\e[34m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[0;41m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[0;36m'

