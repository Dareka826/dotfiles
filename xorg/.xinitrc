# Xinitrc

# Dual-monitor workaround (couldn't achieve this in xorg.conf files)
#xrandr --output DVI-D-0 --mode 1920x1080 --rate 144 --output HDMI3 --mode 1920x1200 --left-of DVI-D-0
xrandr --output DVI-D-0 --mode 1920x1080_144.0 --output HDMI3 --mode 1920x1200_60.0 --left-of DVI-D-0

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0

# Load Xresources
xrdb ~/.Xresources

# Keyboard light effects
ckb-next -b &

# Notification daemon
dunst &

# Restore wallpaper, run picom
nitrogen --restore
#~/Wallpapers/_rand_time.sh &
picom &

# Polybar
~/.config/polybar/start-polybar.sh &

# Copy bashrc to /mnt/tmp
#cp ~/.bashrc /mnt/tmp/

# Newsboat
#alacritty --class Newsboat -e newsboat &

# Additional hotkeys
#sxhkd &
keynav &

# Start the input method
fcitx &

# Start the wm
exec i3
