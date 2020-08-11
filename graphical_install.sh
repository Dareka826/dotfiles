#!/bin/sh

DIALOGW=50
DIALOGH=6

# Atelier lakeside theme
if [ "$TERM" = "linux" ]; then
	printf '%b' '\e]P0161B1D
				 \e]P85A7B8C
				 \e]P1D22D72
				 \e]P9D22D72
				 \e]P2568C3B
				 \e]PA568C3B
				 \e]P38A8A0F
				 \e]PB8A8A0F
				 \e]P4257FAD
				 \e]PC257FAD
				 \e]P55D5DB1
				 \e]PD5D5DB1
				 \e]P62D8F6F
				 \e]PE2D8F6F
				 \e]P77EA2B4
				 \e]PFEBF8FF
				 \ec'
else
	echo -ne   '\e]11;#161B1D\e\\' #BG
	echo -ne   '\e]10;#7EA2B4\e\\' #FG
	echo -ne  '\e]4;0;#161B1D\e\\' #C0
	echo -ne  '\e]4;8;#5A7B8C\e\\' #C8
	echo -ne  '\e]4;1;#D22D72\e\\' #C1
	echo -ne  '\e]4;9;#D22D72\e\\' #C9
	echo -ne  '\e]4;2;#568C3B\e\\' #C2
	echo -ne '\e]4;10;#568C3B\e\\' #C10
	echo -ne  '\e]4;3;#8A8A0F\e\\' #C3
	echo -ne '\e]4;11;#8A8A0F\e\\' #C11
	echo -ne  '\e]4;4;#257FAD\e\\' #C4
	echo -ne '\e]4;12;#257FAD\e\\' #C12
	echo -ne  '\e]4;5;#5D5DB1\e\\' #C5
	echo -ne '\e]4;13;#5D5DB1\e\\' #C13
	echo -ne  '\e]4;6;#2D8F6F\e\\' #C6
	echo -ne '\e]4;14;#2D8F6F\e\\' #C14
	echo -ne  '\e]4;7;#7EA2B4\e\\' #C7
fi

# Run confirmation dialog
printf '> Do you really want to continue? [N/y]: '
read ANS
[ "$ANS" = "y" -o "$ANS" = "Y" -o "$ANS" = "yes" ] || exit

# Ask if installing essentials
MINIMAL="yes"
printf '> Install only the essentials? [Y/n]: '
read ANS
[ "$ANS" = "n" -o "$ANS" = "N" -o "$ANS" = "no" ] && MINIMAL="no"

GRAPHICAL="no"
if [ "$MINIMAL" = "no" ]; then
	# Ask if installing graphical
	printf '> Install a graphical environment? [N/y]: '
	read ANS
	[ "$ANS" = "y" -o "$ANS" = "Y" -o "$ANS" = "yes" ] && GRAPHICAL="yes"
fi

# Ask if copying dotfiles
CONFCOPY="yes"
printf '> Copy the dotfiles? [Y/n]: '
read ANS
[ "$ANS" = "n" -o "$ANS" = "N" -o "$ANS" = "no" ] && CONFCOPY="no"

# Install

# Base
sudo pacman -Syu
sudo pacman -S zsh neovim python3 gcc clang git elinks curl aria2 ranger make \
	fakeroot cmake vim

if [ "$MINIMAL" = "no" ]; then
	# Install extra
	sudo pacman -S mpv cmus ffmpeg alsa pulseaudio pulseaudio-alsa imagemagick \
		python-pywal go
	go get -u git.sr.ht/~ft/unflac

	# Install yay
	git clone https://aur.archlinux.org/yay.git
	cd yay ; makepkg -si
	cd .. ; rm -rf yay
fi

if [ "$GRAPHICAL" = "yes" ]; then
	# Instal grpahical environment
	sudo pacman -S xorg-server chromium i3-gaps dunst alacritty xfce4-terminal \
		leafpad nitrogen lxappearance sxiv ueberzug picom mupdf
	# polybar + oomox/themix
	yay -S polybar themix-git
fi

[ "$CONFCOPY" = "yes" ] && ./install.sh

