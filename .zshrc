source ~/.antigen.zsh
antigen use oh-my-zsh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

antigen bundle git
antigen bundle adb
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme fishy
antigen apply

cat ~/.cache/wal/sequences
. ~/.cache/wal/colors.sh

export PATH=$PATH:~/Tools/:~/.cargo/bin:~/.gem/ruby/2.6.0/bin

get-pgp-key()
{
	sudo pacman-key --recv-keys $1
}

alias 7zja="env LANG=C 7z"

vidlen()
{
	ffmpeg -i $1 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//
}

vidsize()
{
	ffmpeg -i $1 2>&1 | fgrep Video: | egrep -o '[0-9]+x[0-9]+'
}

vidwidth()
{
	vidsize $1 | egrep -o '[0-9]+' | head -1
}

vidheight()
{
	vidsize $1 | egrep -o '[0-9]+' | tail -1
}

sign-apk()
{
	java -jar ~/android_sign_apk/signapk.jar ~/android_sign_apk/certificate.pem ~/android_sign_apk/key.pk8 $1 $1-signed
}

alias mpvcaca="mpv -vo caca -really-quiet"
alias mpvtct="mpv -vo tct -really-quiet"
