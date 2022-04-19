# Xinitrc
xrandr --dpi 96

# Start dbus
eval `dbus-launch --sh-syntax --exit-with-session`

# Dual-monitor setup (couldn't achieve this in xorg.conf files)
#xrandr --output DVI-D-0 --mode 1920x1080 --rate 144 --output HDMI3 --mode 1920x1200 --left-of DVI-D-0

# Disable power saving and mouse acceleration
xset -dpms
xset s off
xset m 0 0

# Load Xresources
xrdb ~/.Xresources

# Keyboard light effects
#ckb-next -b &

# Unclutter
unclutter --timeout 1 -b

# Notification daemon
dunst &

# Restore wallpaper, run picom
#nitrogen --restore
#~/Wallpapers/_rand_time.sh &
picom &

# Polybar
#~/.config/polybar/start-polybar.sh &

# Copy bashrc to /mnt/tmp
#cp ~/.bashrc /mnt/tmp/

# Newsboat
#alacritty --class Newsboat -e newsboat &

# Additional hotkeys
sxhkd &
keynav &

# Start the input method
fcitx &

# Make capslock act like backspace
setxkbmap -option caps:backspace

# Update dwm status
#dwm_status.sh &

# Monitor battery
#battery_mon.sh &

# Start the wm
exec awesome
#exec dwm
