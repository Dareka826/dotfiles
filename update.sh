#!/bin/sh

rm -rf df

mkdir df
cp ~/.zshrc									df/
cp ~/.vimrc									df/
cp ~/.tmux.conf								df/
cp ~/.xinitrc								df/
cp ~/.Xresources							df/
cp ~/.palette.txt							df/

mkdir df/.vim
cp ~/.vim/.ycm_extra_conf.py				df/.vim/

mkdir df/.config
cp ~/.config/chromium-flags.conf			df/.config/
cp ~/.config/picom.conf						df/.config/

mkdir df/.config/alacritty
cp ~/.config/alacritty/alacritty.yml		df/.config/alacritty/

mkdir df/.config/cava
cp ~/.config/cava/config					df/.config/cava/

mkdir df/.config/cmus
cp ~/.config/cmus/drk826.theme				df/.config/cmus/

mkdir df/.config/dunst
cp ~/.config/dunst/dunstrc					df/.config/dunst/

mkdir df/.config/gtk-3.0
cp ~/.config/gtk-3.0/gtk.css				df/.config/gtk-3.0/

mkdir df/.config/i3
cp ~/.config/i3/config						df/.config/i3/

mkdir df/.config/bspwm
cp ~/.config/bspwm/bspwmrc					df/.config/bspwm/
mkdir df/.config/sxhkd
cp ~/.config/sxhkd/sxhkdrc					df/.config/sxhkd/

mkdir df/.config/mpv
cp ~/.config/mpv/mpv.conf					df/.config/mpv/
cp ~/.config/mpv/input.conf					df/.config/mpv/

mkdir -p df/.config/oomox/colors
cp ~/.config/oomox/colors/*					df/.config/oomox/colors/

mkdir df/.config/polybar
cp ~/.config/polybar/*						df/.config/polybar/

mkdir df/.config/ranger
cp ~/.config/ranger/rc.conf					df/.config/ranger/

mkdir df/.minecraft
cp ~/.minecraft/options.txt					df/.minecraft/
cp ~/.minecraft/optionsof.txt				df/.minecraft/
cp ~/.minecraft/optionsshaders.txt			df/.minecraft/
cp ~/.minecraft/.seeds.txt					df/.minecraft/

mkdir df/Wallpapers
cp ~/Wallpapers/lockscreen1.png				df/Wallpapers/
cp ~/Wallpapers/lockscreen1.svg				df/Wallpapers/

mkdir df/themes
cp -r ~/themes/*							df/themes/

mkdir -p df/.local/bin
cp ~/.local/bin/_save-i3.sh					df/.local/bin/
cp ~/.local/bin/_restore-i3.sh				df/.local/bin/
cp ~/.local/bin/animated-wallpaper			df/.local/bin/
cp ~/.local/bin/animated-wallpaper-pan		df/.local/bin/
cp ~/.local/bin/animated-wallpaper-stop		df/.local/bin/
cp ~/.local/bin/baudline_wrapper			df/.local/bin/
cp ~/.local/bin/convert-smol				df/.local/bin/
cp ~/.local/bin/lock.sh						df/.local/bin/
cp ~/.local/bin/lock_sus.sh					df/.local/bin/
cp ~/.local/bin/mahjongsoul					df/.local/bin/
cp ~/.local/bin/resetusb					df/.local/bin/
cp ~/.local/bin/screenshot					df/.local/bin/
cp ~/.local/bin/controller-battery.sh		df/.local/bin/

