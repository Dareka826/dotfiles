#!/bin/sh

# Zsh
cp -i df/.zshrc							~/
curl -L git.io/antigen > ~/.antigen.zsh

# Vim
cp -i df/.vimrc							~/
mkdir -p ~/.vim/colors
curl -L https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp -i df/.vim/.ycm_extra_conf.py		~/.vim/

# X files
cp -i df/.xinitrc						~/
cp -i df/.Xresources					~/

# Tmux
cp -i df/.tmux.conf						~/

# Color palette
cp -i df/.palette.txt					~/

# Config
cp -ri df/.config						~/

# Wallpapers
mkdir ~/Wallpapers
cp df/Wallpapers/*						~/Wallpapers
curl -L https://i.imgur.com/z4ffOWb.png -o ~/Wallpapers/71123408_p0.png

# Wal
wal -i ~/Wallpapers/71123408_p0.png

# Oomox
# oomox-cli -m all ~/.config/oomox/colors/RinN

# Suwako cursor
mkdir ~/.icons
cd ~/.icons
curl -LO https://github.com/Dareka826/Suwako_Cursor_Linux_Port/raw/master/Suwako_Cursor.tar.gz
tar -xf Suwako_Cursor.tar.gz
rm -rf Suwako_Cursor.tar.gz

# Custom scripts
mkdir -p ~/.local/bin
cp -i df/.local/bin/*					~/.local/bin/

# Themes
mkdir ~/themes
cp -i df/themes/*						~/themes/

# Minecraft
mkdir ~/.minecraft
cp -i df/.minecraft/*					~/.minecraft/

