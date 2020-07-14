#!/bin/sh

rm -rf df
mkdir df

# ZSH
cp ~/.zshrc				df/.zshrc
# VIM
cp ~/.vimrc				df/.vimrc
cp ~/.ycm_extra_conf.py	df/.ycm_extra_conf.py
# XINITRC
cp ~/.xinitrc			df/.xinitrc
# XRESOURCES
cp ~/.Xresources			df/.Xresources

# ~/.config
mkdir -p df/.config/alacritty
mkdir -p df/.config/cmus
mkdir -p df/.config/dunst
mkdir -p df/.config/i3
mkdir -p df/.config/mpv
mkdir -p df/.config/oomox/colors
mkdir -p df/.config/polybar
mkdir -p df/.config/ranger
mkdir -p df/.config/vis/colors
mkdir -p df/.config/xfce4/terminal
mkdir -p df/.config/gtk-3.0
mkdir -p df/.config/kitty

# alacritty
cp ~/.config/alacritty/alacritty.yml						df/.config/alacritty/alacritty.yml
# CMUS
cp ~/.config/cmus/drk826.theme								df/.config/cmus/drk826.theme
# dunst
cp ~/.config/dunst/dunstrc									df/.config/dunst/dunstrc
# i3
cp ~/.config/i3/config										df/.config/i3/config
# mpv
cp ~/.config/mpv/mpv.conf									df/.config/mpv/mpv.conf
cp ~/.config/mpv/input.conf									df/.config/mpv/input.conf
# oomox
cp ~/.config/oomox/colors/Rin								df/.config/oomox/colors/Rin
cp ~/.config/oomox/colors/RinN								df/.config/oomox/colors/RinN
# polybar
cp ~/.config/polybar/*										df/.config/polybar/
# ranger
cp ~/.config/ranger/rc.conf									df/.config/ranger/rc.conf
# vis
cp ~/.config/vis/colors/*									df/.config/vis/colors/
cp ~/.config/vis/config										df/.config/vis/config
# xfce4-terminal
cp ~/.config/xfce4/terminal/terminalrc						df/.config/xfce4/terminal/terminalrc
# chromium flags
cp ~/.config/chromium-flags.conf							df/.config/chromium-flags.conf
# picom
cp ~/.config/picom.conf										df/.config/picom.conf

# gtk.css
cp ~/.config/gtk-3.0/gtk.css								df/.config/gtk-3.0/gtk.css

# kitty
cp ~/.config/kitty/kitty.conf								df/.config/kitty/kitty.conf

# firefox
cp ~/.mozilla/firefox/a4a2pjuk.default-release/chrome/*		df/.mozilla/firefox/ur-profile/chrome/


# Lockscreen
cp ~/Wallpapers/lockscreen*									df/Wallpapers/
cp ~/.local/bin/lock.sh										df/.local/bin/lock.sh
