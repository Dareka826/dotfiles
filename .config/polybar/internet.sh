foreground="#FFFFFF"
foreOff="#FF0000"
background="#222222"

INT="enp5s0"
ADDR="8.8.8.8"

printf "%%{B$background}"
if [[ "$(ping -c 1 $ADDR 2>&1 | grep '100% packet loss')" != "" ]]
then
	printf "%%{F$foreOff} $INT disconnected %%{F$foreground}"
else
	printf "%%{F$foreground} $INT connected "
fi
