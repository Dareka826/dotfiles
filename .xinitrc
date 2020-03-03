#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0

# Start the input method
fcitx &
# animated-wallpaper ~/Wallpapers/Nitori_geddan_youmu.mp4 &

# Load Xresources
xrdb ~/.Xresources

# Start jack
# jackd -d alsa &

# Keyboard light effects
ckb-next -b &

# Notification daemon
dunst &

# Restore wallpaper, compton
nitrogen --restore
compton &

# Restore colors and start discord
wal -R
discord &

# Polybar
. ~/.config/polybar/start-polybar.sh &

leafpad open.txt &

# Start the wm
exec i3
