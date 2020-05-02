foreground="#FFFFFF"
foreOff="#FF0000"
background="#222222"
ADDR="8.8.8.8"

printf "%%{B$background}"
[ "$(ping -c 1 $ADDR 2>&1 | grep '100% packet loss')" != "" ] && printf "%%{F$foreOff} Network disconnected %%{F$foreground}" || printf "%%{F$foreground} Network connected "

