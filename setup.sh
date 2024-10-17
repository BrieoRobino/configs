#!/bin/bash

# List of apps to install
apps=(
  git
  curl
  neovim
  zsh
  htop
  powertop
  tmux
  # Add more apps here
)

# Update package lists and install apps
echo "Updating package lists..."
sudo apt update

echo "Installing apps..."
sudo apt install -y "${apps[@]}"

# Install zsh if not installed
if ! command -v zsh &> /dev/null
then
  echo "Installing zsh..."
  sudo apt install -y zsh
else
  echo "zsh is already installed"
fi

# Set zsh as the default shell for the current user
echo "Changing shell to zsh for user $USER..."
chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  # Using curl to download and install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed"
fi

# Get the current directory
current_dir=$(pwd)

# Ensure the ~/.config/nvim directory exists
mkdir -p "$HOME/.config/nvim"

# Create symbolic links for init.vim, .zshrc, and .tmux.conf.local
echo "Creating symbolic links for init.vim, .zshrc, and .tmux.conf.local..."

if [ -f "$current_dir/init.vim" ]; then
  ln -sf "$current_dir/init.vim" "$HOME/.config/nvim/init.vim"
  echo "Symbolic link created for init.vim"
else
  echo "init.vim not found in current directory"
fi

if [ -f "$current_dir/.zshrc" ]; then
  ln -sf "$current_dir/.zshrc" "$HOME/.zshrc"
  echo "Symbolic link created for .zshrc"
else
  echo ".zshrc not found in current directory"
fi

if [ -f "$current_dir/.tmux.conf.local" ]; then
  ln -sf "$current_dir/.tmux.conf.local" "$HOME/.tmux.conf.local"
  echo "Symbolic link created for .tmux.conf.local"
else
  echo ".tmux.conf.local not found in current directory"
fi

echo "Installing vim-plug"
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Configure Tmux"
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .


echo "All tasks completed!"
