#!/bin/bash

isMac=0
if [ "$(uname)" = 'Darwin' ]; then
  isMac=1
fi

echo "deploying dotfiles..."
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/rc ~/.vim/
ln -sf ~/dotfiles/colors ~/.vim/
ln -sf ~/dotfiles/.vim/.cheatsheet.md ~/.vim/.cheatsheet.md
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ $isMac -eq 1 ]; then
  if !( type brew > /dev/null 2>&1 ); then
    echo "install homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  echo "start brew update"
  brew update
  echo "start brew upgrade"
  brew upgrade
  echo "start brew install from Brewfile"
  brew bundle install --file mac/Brewfile
fi
