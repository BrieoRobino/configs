#!/bin/bash

# install packages

sudo apt install neofetch neovim powertop zsh -y

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# move dot files
ln -s .zshrc ~/.zshrc
ln -s init.vim ~/init.vim
