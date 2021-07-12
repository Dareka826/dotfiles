# Youtube-dl
alias ytd="youtube-dl --no-mtime --embed-thumbnail"
alias ytdx="youtube-dl --no-mtime -x -f 'bestaudio[acodec=opus]/best[acodec=opus]/bestaudio/best'"

# Mpv
alias mpva="mpv --video=no"
alias mpvy="mpv --ytdl --script-opts=ytdl_hook-ytdl_path=yt-dlp"

# Mega
alias mgg="mega-get"
alias mdl="megatools dl"

# Rename file with taffy according to metadata
alias trfs="taffy --rename-fs \"%R - %T\""

# Audacity no network
alias audacity="firejail --net=none audacity"

# FFMpeg & FFProbe
alias ffmpeg="ffmpeg -hide_banner"
alias ffpp="ffprobe -hide_banner -pretty"

