#!/bin/sh

#QT_QPA_PLATFORMTHEME=gtk2

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0
xset r rate 300 60

# Start the input method
fcitx &

# Load Xresources
xrdb ~/.Xresources

# Keyboard light effects
ckb-next -b &

# Notification daemon
dunst &

# Restore colors, wallpaper, picom, redshift
wal -R -n
nitrogen --restore
picom &
#redshift &

# Start discord
discord &

# Polybar
. ~/.config/polybar/start-polybar.sh &

# Set saturation to 116%
#vibrant-cli DVI-D-0 1.16

#leafpad ~/___layout.txt &

# Start the wm
exec i3
#exec bspwm
