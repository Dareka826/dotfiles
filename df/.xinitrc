#!/bin/sh

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0

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

# Start discord
discord &

# Polybar
~/.config/polybar/start-polybar.sh &

# Copy zshrc in /tmp
cp ~/.zshrc /tmp/

# Pulseaudio force mic to be at 55% (because of WebRTC)
while sleep 0.1; do pacmd set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo 36045; done &

# Newsboat
alacritty -e "newsboat" &

# Start the wm
exec i3

