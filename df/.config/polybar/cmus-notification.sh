#!/bin/sh

# tracknum, title, artist, album

cmus-remote -C status | grep "cmus is not running" >/dev/null 2>&1 && notify-send "cmus off" && exit 0

notify-send "$(cmus-remote -C status | awk '
$1=="file" { $1=""; sub(/.*\//,""); title = $0 }
$1=="tag" && $2=="title" { sub("tag title ",""); title = $0 }
$1=="tag" && $2=="album" { sub("tag album ",""); album = $0 }
$1=="tag" && $2=="tracknumber" { tracknum = $3 }
$1=="tag" && $2=="albumartist" { sub("tag albumartist ",""); albumartist = $0 }
$1=="tag" && $2=="artist" { sub("tag artist ",""); artist = $0 }
END {
	if(tracknum == 0) tracknum = "?"
	lef = dur-pos
	printf("%s. %s - %s\n[%s] %s", tracknum, artist, title, albumartist, album)
}')"
