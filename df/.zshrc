# Rin's .zshrc
export EDITOR=nvim

# Antigen stuff
source ~/.antigen.zsh
_ANTIGEN_WARN_DUPLICATES=false

antigen use oh-my-zsh
CASE_SENSITIVE="false"

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle softmoth/zsh-vim-mode

antigen theme fishy
antigen apply

MODE_INDICATOR_VIINS='I'
MODE_INDICATOR_VICMD='N'
MODE_INDICATOR_REPLACE='R'
MODE_INDICATOR_SEARCH='S'
MODE_INDICATOR_VISUAL='V'
MODE_INDICATOR_VLINE='L'
PROMPT="$MODE_INDICATOR_PROMPT $PROMPT"

# Path variable
export PATH=$PATH:~/.local/bin:~/go/bin

# Wal theme
[ $(tty | grep -o tty) ] && . ~/.cache/wal/colors-tty.sh || cat ~/.cache/wal/sequences

# Functions
get-pgp-key() { sudo pacman-key --recv-keys $1 }
file_perms() { chmod a-x,a=rwX,og-w -R * }

# Aliases
alias clo="curl -L -O"
alias ytd="youtube-dl"
alias ytdx="youtube-dl -x"
alias aria2t="aria2c --max-upload-limit=1 --max-overall-upload-limit=1 --seed-time=0"
alias 7zd="7z -v8181K" # 7z split for discord upload
alias sd="shred -uvz"

# Confirm remove, cp and mv
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

