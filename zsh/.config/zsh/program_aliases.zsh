# Youtube-dl
YTD="youtube-dl"
command -v yt-dlp >/dev/null 2>&1 && YTD="yt-dlp"
YTD+=" --no-mtime -o \"[%(webpage_url_domain)s]_[%(id)s]_%(title)s.%(ext)s\""

alias  ytd="${YTD} --embed-thumbnail"
alias ytdx="${YTD} -x -f 'bestaudio[acodec=opus]/best[acodec=opus]/bestaudio/best'"

# Mpv
alias mpva="mpv --video=no"
alias mpvy="mpv --ytdl --script-opts=ytdl_hook-ytdl_path=yt-dlp"

# Mega
alias mgg="mega-get"
alias mdl="megadl"

# Rename file with taffy according to metadata
alias trfs="taffy --rename-fs \"%_R - %_T\""

# Audacity no network
alias audacity="firejail --net=none audacity"

# FFMpeg & FFProbe
alias ffmpeg="ffmpeg -hide_banner"
alias ffpp="ffprobe -hide_banner -pretty"

# Pacman
alias -g pac="pacman"

alias sue="sudoedit"

alias hyperfine="hyperfine --shell /bin/dash"

# URI decode/encode
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

# gallery-dl
alias gdl="~/.local/bin/gallery-dl --sleep 1 --ugoira-conv-lossless --write-metadata"

alias cal="cal -3 -m"
alias c="cal"

alias w="when c m"
alias ww="when c w"
alias we="when e"
