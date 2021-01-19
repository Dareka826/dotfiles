# Rin's .zshrc
export EDITOR=nvim

# Antigen stuff
source ~/.antigen.zsh
_ANTIGEN_WARN_DUPLICATES=false

# TODO: remove oh-my-zsh
antigen use oh-my-zsh
CASE_SENSITIVE="false"

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-you-should-use

antigen theme fishy
antigen apply

bindkey -v

# Path variable
export PATH=$PATH:~/.local/bin:~/go/bin

# Functions
get-pgp-key() { sudo pacman-key --recv-keys $1 }
file_perms() { chmod a-x,a=rwX,og-w -R * }

# Aliases
alias clo="curl -L -O"
alias ytd="youtube-dl --embed-thumbnail"
alias ytdx="youtube-dl -x"
alias aria2t="aria2c --max-upload-limit=1 --max-overall-upload-limit=1 --seed-time=0"
alias mpva="mpv --video=no"

# Confirm rm and mv
alias rm="rm -i"
alias mv="mv -i"

# Directory aliases
alias ce="cd /mnt/drive_e"
alias cm="cd /mnt/drive_e/Music"
alias ct="cd /mnt/drive_e/_T"
alias cc="cd ~/.config"
alias cb="cd ~/.local/bin"
alias cr="cd /mnt/drive_e/repos"
alias ca="cd /mnt/drive_e/a"
alias cs="cd /mnt/drive_e/src"
alias cg="cd /mnt/drive_e/Games"
alias csc="cd /mnt/drive_e/_school"

alias mgg="mega-get --ignore-quota-warn"

# ls -> exa
alias ls="exa -F"
alias ll="exa -lF"
alias l="exa -halF"
alias la="exa -aF"

# Music tools
otr() {
	for o in *.opus; do taffy --rename-fs "%N. %R - %T" "$o"; done
}

cto() {
	for f in $@; do ffmpeg -i "$f" -c:a libopus -b:a 128k "$(echo "$f" | rev | cut -d'.' -f2- | rev).opus"; done
}

alias trfs="taffy --rename-fs \"%R - %T\""

# Xournal++ theme
xournalpp() {
	XDG_CONFIG_HOME=/home/$USER/.xournalpp/theme /usr/bin/xournalpp $@
}

# Colored man
man() {
	LESS_TERMCAP_md=$'\e[34m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[0;41m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[0;36m' \
	command man "$@"
}

alias v="nvim"
alias r="ranger"

alias dvtm="dvtm -m ^a"

