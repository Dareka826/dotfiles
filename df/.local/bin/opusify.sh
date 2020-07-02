#!/bin/sh
ffmpeg -i "$1" -b:a 128k -c:a libopus "$(echo "$1" | rev | cut -d. -f2- | rev).opus"
