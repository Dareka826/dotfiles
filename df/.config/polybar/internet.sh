#!/bin/sh
foreground="#FFFFFF"
foreOff="#FF0000"
background="#333333"
ADDR="8.8.8.8"

printf "%%{B$background}"
[ "$(ping -c 1 $ADDR 2>&1 | grep -E '(100% packet loss)|(Network is unreachable)')" != "" ] && printf "%%{F$foreOff}Ex %%{F$foreground}" || printf "%%{F$foreground}E^ "

