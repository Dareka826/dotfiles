# Zsh Env

# Fcitx
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export SDL_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"

# Path
export PATH=$PATH:~/.local/bin:~/go/bin

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

# Qt style
export QT_STYLE_OVERRIDE="kvantum"

