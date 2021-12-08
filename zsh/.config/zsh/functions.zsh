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

