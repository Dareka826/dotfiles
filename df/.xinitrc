#!/bin/sh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

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

# Restore colors, wallpaper, compton
wal -R -n
nitrogen --restore
#compton &
picom &

# Start discord
discord &

# Polybar
. ~/.config/polybar/start-polybar.sh &

redshift &
~/Tools/i3_save_5min &

# Start the wm
exec i3
#exec bspwm
