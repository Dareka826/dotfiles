#!/bin/sh

# zsh
cp -i df/.zshrc ~/.zshrc
curl -L git.io/antigen > ~/.antigen.zsh

# vim
cp -i df/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ~/.vim/colors
curl -L https://raw.githubusercontent.com/ciaranm/inkpot/master/colors/inkpot.vim -o ~/.vim/colors/inkpot.vim

# xinitrc
cp -i df/.xinitrc ~/.xinitrc
# xresources
cp -i df/.Xresources ~/.Xresources

# ~/.config
cp -ri df/.config ~/.config

# wal + wallpaper
mkdir -p ~/Wallpapers
curl -L https://i.imgur.com/z4ffOWb.png -o ~/Wallpapers/71123408_p0.png
wal -i ~/Wallpapers/71123408_p0.png

# oomox
oomox-cli -m all ~/.config/oomox/colors/Rin

# cursor
mkdir -p ~/.icons
cd ~/.icons
curl -LO https://github.com/Dareka826/Suwako_Cursor_Linux_Port/blob/master/Suwako_Cursor.tar.gz
tar -xf Suwako_Cursor.tar.gz
rm -rf Suwako_Cursor.tar.gz

