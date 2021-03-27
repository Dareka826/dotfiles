#!/bin/sh

# Zsh
cp -i df/.zshrc ~/
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

# Neovim
mkdir -p ~/.config/nvim #/colors
cp -i df/.config/nvim/init.vim ~/.config/nvim/init.vim
#curl -L https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > ~/.config/nvim/colors/molokai.vim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# X files
cp -i df/.xinitrc ~/
cp -i df/.Xresources ~/

# Nice Wallpapers:
#   https://www.pixiv.net/en/artworks/71123408
#   https://www.pixiv.net/en/artworks/83517721
#   https://www.pixiv.net/en/artworks/67492833
#   https://www.pixiv.net/en/artworks/62335563
#   https://www.pixiv.net/en/artworks/62524130
#   https://www.pixiv.net/en/artworks/69580898

# Console themes
mkdir ~/themes
cp -ir df/themes/* ~/themes/

# Suwako cursor
mkdir ~/.icons
cd ~/.icons
curl -LO https://github.com/Dareka826/Suwako_Cursor_Linux_Port/raw/master/Suwako_Cursor.tar.gz
tar -xf Suwako_Cursor.tar.gz
rm -rf Suwako_Cursor.tar.gz

