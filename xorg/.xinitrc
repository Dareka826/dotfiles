# vim: ft=sh

# Xinitrc
xrandr --dpi 96

# Start dbus
eval `dbus-launch --sh-syntax --exit-with-session`

# Dual-monitor setup (couldn't achieve this in xorg.conf files)
#xrandr --output DVI-D-0 --mode 1920x1080 --rate 144 --output HDMI3 --mode 1920x1200 --left-of DVI-D-0

# Disable power saving and mouse acceleration
xset s off
xset -dpms
xset m 0 0

# Pipewire
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &
# Load Xresources
xrdb ~/.Xresources

# Unclutter
unclutter --timeout 1 -b

# Xob
XOBSOCK="${XDG_RUNTIME_DIR}/xob.sock"
rm -f "${XOBSOCK}" && mkfifo "${XOBSOCK}" && tail -f "${XOBSOCK}" | xob -t 1000 &

# Notification daemon
dunst &

# Restore wallpaper, run picom
#nitrogen --restore
#~/Wallpapers/_rand_time.sh &
picom &

# Copy bashrc to /mnt/tmp
#cp ~/.bashrc /mnt/tmp/

# Newsboat
#alacritty --class Newsboat -e newsboat &

# Additional hotkeys
sxhkd &
keynav &

# Start the input method
fcitx5 &

# Make capslock act like backspace
setxkbmap -option caps:backspace
# Enable Shift+NumLock mouse emulation
setxkbmap -option keypad:pointerkeys
# Compose key
xmodmap -e "keysym Insert = Multi_key"

# Monitor battery
#battery_mon.sh &
#kmonad ~/kmonad-laptop-kbd.kbd &

# Start the wm
exec awesome
