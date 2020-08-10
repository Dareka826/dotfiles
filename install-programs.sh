#!/bin/sh

if [ $(id -u) = "0" ]; then
	# We're root (1st stage)
	# Update
	pacman -Syu
	# Essential
	pacman -S zsh mpv neovim python3 gcc clang git cmus alsa pulseaudio ffmpeg \
		elinks curl aria2 go
	# Graphical
	pacman -S chromium i3-gaps dunst alacritty xfce4-terminal leafpad
else
	# We're not root (2nd stage)
	# yay
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	cd yay ; makepkg -si
	cd .. ; rm -rf yay
	# polybar
	yay -S polybar
	# unflac
	go get -u git.sr.ht/~ft/unflac
fi
