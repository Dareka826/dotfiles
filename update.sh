#!/bin/sh

rm -rf df
mkdir df

# ZSH
cp -i ~/.zshrc				df/.zshrc
# VIM
cp -i ~/.vimrc				df/.vimrc
cp -i ~/.ycm_extra_conf.py	df/.ycm_extra_conf.py
# XINITRC
cp -i ~/.xinitrc			df/.xinitrc
# XRESOURCES
cp -i ~/.Xresources			df/.Xresources

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

# alacritty
cp -i ~/.config/alacritty/alacritty.yml		df/.config/alacritty/alacritty.yml
# CMUS
cp -i ~/.config/cmus/drk826.theme			df/.config/cmus/drk826.theme
# dunst
cp -i ~/.config/dunst/dunstrc				df/.config/dunst/dunstrc
# i3
cp -i ~/.config/i3/config					df/.config/i3/config
# mpv
cp -i ~/.config/mpv/mpv.conf				df/.config/mpv/mpv.conf
cp -i ~/.config/mpv/input.conf				df/.config/mpv/input.conf
# oomox
cp -i ~/.config/oomox/colors/Rin			df/.config/oomox/colors/Rin
cp -i ~/.config/oomox/colors/RinN			df/.config/oomox/colors/RinN
# polybar
cp -i ~/.config/polybar/*					df/.config/polybar/
# ranger
cp -i ~/.config/ranger/rc.conf				df/.config/ranger/rc.conf
# vis
cp -i ~/.config/vis/colors/*				df/.config/vis/colors/
cp -i ~/.config/vis/config					df/.config/vis/config
# xfce4-terminal
cp -i ~/.config/xfce4/terminal/terminalrc	df/.config/xfce4/terminal/terminalrc
# chromium flags
cp -i ~/.config/chromium-flags.conf			df/.config/chromium-flags.conf
# picom
cp -i ~/.config/picom.conf					df/.config/picom.conf

