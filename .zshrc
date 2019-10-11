export TERM="xterm-256color"

source ~/.antigen.zsh
antigen use oh-my-zsh


COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"


antigen bundle git
antigen bundle adb
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting


POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs history time)


POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="001"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="006"

POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="001"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="006"


POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="007"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="001"

POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND="007"
POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND="001"

POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND="007"
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND="001"

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply


cat ~/.cache/wal/sequences
source ~/.cache/wal/colors-tty.sh
. ~/.cache/wal/colors.sh


export PATH=$PATH:~/Tools/

get-pgp-key()
{
	sudo pacman-key --recv-keys $1
}

alias 7zja="env LANG=C 7z"

vidlen()
{
	ffmpeg -i $1 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//
}

