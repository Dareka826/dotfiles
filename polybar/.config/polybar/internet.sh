#!/bin/sh
foreground="#FFFFFF"
foreOff="#FF0000"
ADDR="8.8.8.8"

# Check if supplied different arguments
[ "$1" != "" ] && foreOff="$1"
[ "$2" != "" ] && foreground="$2"

[ "$(ping -c 1 $ADDR 2>&1 | grep -E '(100% packet loss)|(Network is unreachable)')" != "" ] && printf "%%{F$foreOff}Ex %%{F$foreground}" || printf "%%{F$foreground}E^ "

