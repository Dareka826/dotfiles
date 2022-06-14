# Download vods
dvod() {
	[ $# = "0" ] && echo "dvod link out_filename" || \
	streamlink "$1" "best" -o "$2"
}

# Rename all opus files in directory according to their metadata
otr() {
	for o in *.opus; do
		taffy --rename-fs "%N. %R - %T" "$o"
	done
}

# Convert all files passed as arguments to opus
cto() {
	for f in "$@"; do
		ffmpeg -i "$f" -c:a libopus -b:a 128k \
			"$(echo "$f" | rev | cut -d'.' -f2- | rev).opus"
	done
}

bell() { printf "\a" }

# Cat range
catr() {
	tail -n "+$1" "$3" | head -n "$(( $2 - $1 + 1 ))"
}

# List all git object hashes
goh() {
	for object in .git/objects/??/*; do
		echo $object;
	done | sed 's/^.*\([a-zA-Z0-9]\{2\}\)\/\([a-zA-Z0-9]\+\)$/\1\2/'
}

# Pretty print all git objects
gop() {
	for obj in $(goh | sort); do
		printf "==== OBJECT: %s\n" "$obj"
		git cat-file -p $obj
		printf "\n"
	done
}

# Show all git objects
gos() {
	for obj in $(goh | sort); do
		printf "==== OBJECT: %s\n" "$obj"
		git show $obj
		printf "\n"
	done
}

# Check which program is used by xdg-open on a file
xdg-which() {
	TYPE="$(xdg-mime query filetype "$1")"
	APP="$(xdg-mime query default "$TYPE")"

	printf "File: %s\n" "$1"
	printf "Type: %s\n" "$TYPE"
	printf "App:  %s\n" "$APP"
}

# Play last replay buffer
lrb() {
	cd /mnt/IDATA/OBS_Videos
	ls Replay_* | sort -r | head -1 | xargs mpv
}

# fd/find + vim/nvim
fv() {
    FV_VIM="vim"
    command -v nvim && FV_VIM="nvim"

    # If fd exists
    command -v fd && {
        fd "$@" -X $FV_VIM \;
        true # Prevent trigerring the find block

    } || { # else
        find "$@" -exec $FV_VIM \{\} +
    }
}

# Display random nvim help page
v_randhelp() {
    HELP_NUM="$(cat /usr/share/nvim/runtime/doc/usr_toc.txt | tr '\t' ' ' | grep -E '^  \|[0-9]+\.[0-9]+\|' | grep -Eo '[0-9]+\.[0-9]+' | sort -R | head -1)"
    nvim --cmd "help ${HELP_NUM}" --cmd "only"
}

reset_mt7921e() {
    # Reload driver for wifi chip
    doas rmmod mt7921e
    doas modprobe mt7921e

    # Restart connman
    doas s6-svc -r /run/service/connmand-srv
}

find_gainless() {
    fd --print0 -t f '\.(opus|flac|wav|mp3)$' \
        | xargs -0 -n 1 \
            dash -c 'ffprobe -hide_banner -pretty "$1" 2>&1 | grep R128 >/dev/null || printf "No gain? : %s\n" "$1"' ''
}

# vim ls time
vlt() {
    ls --sort=time -r | nvim
}
