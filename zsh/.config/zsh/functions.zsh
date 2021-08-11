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

