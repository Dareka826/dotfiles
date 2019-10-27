#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Restore wallpaper, Run compositor, run polybar
nitrogen --restore
compton -c &
polybar drkbar &
# mpd

# Restore colors and start discord
wal -R
apulse discord &

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0

# Start the input method
fcitx &
# animated-wallpaper ~/Wallpapers/Nitori_geddan_youmu.mp4 &

# Open a file with workspace layout
leafpad ~/_________open_windows.txt &

# Load the x resources
xrdb ~/.Xresources

# Start jack
# jackd -d alsa &

# Keyboard light effects
ckb-next -b &

# Notification daemon
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# Start the wm
exec i3 
