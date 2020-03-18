#!/bin/sh
PREVCOL="#444444"
COL="#B77AA3" #404385
printf "%%{F$COL B$PREVCOL}%%{F#FFFFFF B$COL} %s " "$(date -Iseconds)"
