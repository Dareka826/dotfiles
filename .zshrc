# Dareka826's .zshrc

# Antigen stuff
source ~/.antigen.zsh
antigen use oh-my-zsh
_ANTIGEN_WARN_DUPLICATES=false

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"
CASE_SENSITIVE="false"

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme fishy
antigen apply

# Path variable
export PATH=$PATH:~/Tools/:~/.cargo/bin:~/.gem/ruby/2.6.0/bin:~/go/bin

# Wal theme
cat ~/.cache/wal/sequences
. ~/.cache/wal/colors.sh
. ~/.cache/wal/colors-tty.sh

# Some functions
get-pgp-key()
{
	sudo pacman-key --recv-keys $1
}

vidlen()
{
	ffprobe "$1" 2>&1 | fgrep Duration | perl -pe 's|^.*?Duration: (.*?),.*?$|\1|'
}

sign-apk()
{
	java -jar ~/android_sign_apk/signapk.jar ~/android_sign_apk/certificate.pem ~/android_sign_apk/key.pk8 $1 $1-signed
}

# Some aliases
alias 7zc="env LANG=C 7z"
alias curllo="curl -L -O"
alias clo="curl -L -O"
alias ytd="youtube-dl"
alias ytdx="youtube-dl -x"
alias adfhd="anime dl -q 1080p"
alias awfhd="anime dl -q 1080p --play mpv"
alias aria2t="aria2c --max-upload-limit=1 --max-overall-upload-limit=1 --seed-time=0"
# 7z split into 7.99MB volumes for discord upload
alias 7zds="7z -v8181K"

# personal
alias nyaa="cat"
