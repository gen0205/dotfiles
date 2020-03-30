#!/bin/bash

isMac=0
if [ "$(uname)" = 'Darwin' ]; then
  isMac=1
fi

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/rc ~/.vim/
ln -sf ~/dotfiles/colors ~/.vim/
ln -sf ~/dotfiles/.vim/.cheatsheet.md ~/.vim/.cheatsheet.md
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ $isMac -eq 1 ]; then
  brew bundle install --file mac/Brewfile
fi
