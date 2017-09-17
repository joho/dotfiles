#!/bin/bash

if [ ! -f ~/.zshrc ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


ln -sf "$PWD/vimrc" ~/.vimrc
ln -sf "$PWD/gvimrc" ~/.gvimrc
ln -sf "$PWD/bashrc" ~/.bashrc
ln -sf "$PWD/zshrc" ~/.zshrc
ln -sf "$PWD/profile" ~/.bash_profile
ln -sf "$PWD/gitconfig" ~/.gitconfig
ln -sf "$PWD/gitignore_global" ~/.gitignore_global
ln -sf "$PWD/gemrc" ~/.gemrc
ln -sf "$PWD/ackrc" ~/.ackrc
