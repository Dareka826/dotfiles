#!/bin/sh

SAFETY_OPTS="-i"
[ "$1" == "--force" ] && SAFETY_OPTS=""

# Zsh
cp $SAFETY_OPTS df/.zshenv ~/

mkdir -p ~/.config/zsh
cp $SAFETY_OPTS df/.config/zsh/.zshrc ~/.config/zsh/
cp $SAFETY_OPTS df/.zshrc ~/

mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

# Tmux
cp $SAFETY_OPTS df/.tmux.conf ~/

# Neovim
mkdir -p ~/.config/nvim
cp $SAFETY_OPTS df/.config/nvim/init.vim ~/.config/nvim/
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vifm
mkdir -p ~/.config/vifm/colors ~/.config/vifm/scripts
cp $SAFETY_OPTS df/.config/vifm/vifmrc ~/.config/vifm/
cp $SAFETY_OPTS df/.config/vifm/colors/rin.vifm ~/.config/vifm/colors/
cp $SAFETY_OPTS df/.config/vifm/scripts/* ~/.config/vifm/scripts/

# Ranger
#mkdir -p ~/.config/ranger
#cp $SAFETY_OPTS df/.config/ranger/rc.conf ~/.config/ranger/

# Bash
cp $SAFETY_OPTS df/.bashrc ~/

# X files
#cp $SAFETY_OPTS df/.xinitrc ~/
cp $SAFETY_OPTS df/.Xresources ~/

# Nice Wallpapers:
#   https://www.pixiv.net/en/artworks/71123408
#   https://www.pixiv.net/en/artworks/83517721
#   https://www.pixiv.net/en/artworks/67492833
#   https://www.pixiv.net/en/artworks/62335563
#   https://www.pixiv.net/en/artworks/62524130
#   https://www.pixiv.net/en/artworks/69580898

# Console themes
mkdir ~/themes
cp $SAFETY_OPTS -r df/themes/* ~/themes/

# Suwako cursor
#mkdir ~/.icons
#cd ~/.icons
#curl -LO https://github.com/Dareka826/Suwako_Cursor_Linux_Port/raw/master/Suwako_Cursor.tar.gz
#tar -xf Suwako_Cursor.tar.gz
#rm -rf Suwako_Cursor.tar.gz

