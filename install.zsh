#!/bin/zsh

cd ~
git clone https://github.com/fernandotakai/vim.git .vim
cd ~
ln -s ~/.vim/vimrc ./.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Done."
