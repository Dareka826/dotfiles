#!/bin/sh

for i in $(find -maxdepth 0 . -type f | grep -v "opus"); do
	ffmpeg -i "$i" -b:a 128k -c:a libopus "$(echo "$i" | rev | cut -d. -f2- | rev).opus"
	rm "$i"
done
