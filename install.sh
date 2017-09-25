#!/bin/bash

if [ ! -f ~/.zshrc ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ "$uname 2> /dev/null" == "Linx" ]]; then
  ln -sf "$PWD/vscode/settings.json" ~/.config/Code/User/settings.json
  ln -sf "$PWD/vscode/snippets" ~/.config/Code/User/snippets
elif
  ln -sf "$PWD/vscode/settings.json" "~/Library/Application Support/Code/User/settings.json"
  ln -sf "$PWD/vscode/snippets" "~/Library/Application Support/Code/User/snippets"
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
