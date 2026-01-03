# Youtube-dl
YTD="yt-dlp --no-mtime -w -o '[%(webpage_url_domain)s]_[%(upload_date)s]_[%(uploader_id)s]_[%(id)s]_%(title)s.%(ext)s' --write-info-json --write-thumbnail --extractor-args 'youtube:lang=en' --extractor-args 'youtube:player-client=default,mweb'"

alias  ytd="${YTD} -f 'bestvideo*[height<=?1080]+bestaudio'"
alias ytdx="${YTD} -x -f 'bestaudio[acodec=opus]/best[acodec=opus]/bestaudio/best'"

# Mpv
alias mpva="mpv --video=no"

# Mega
alias mdl="megadl"

# FFMpeg & FFProbe
alias ffmpeg="ffmpeg -hide_banner"
alias ffpp="ffprobe -hide_banner -pretty"

alias pac="pacman"
alias sue="sudoedit"

# URI decode/encode
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

# gallery-dl
alias gdl="${HOME}/.local/bin/gallery-dl --sleep 1 --ugoira-conv-lossless --write-metadata"

alias cal="cal -3 -m"
alias c="cal"

alias w="when c m"
alias ww="when c w"
alias we="when e"

alias dnd="dragon-drop"
