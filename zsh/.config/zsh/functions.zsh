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

