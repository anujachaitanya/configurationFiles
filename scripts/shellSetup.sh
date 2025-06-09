#! /bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# git configuration
git config --global user.name "anujachaitanya"
git config --global user.email "anujachaitanya09@gmail.com"
git clone https://github.com/anujachaitanya/configurationFiles.git

# Linking configuration files
ln -s ./configurationFiles/vimrc .vimrc
ln -s ./configurationFiles/zshrc .zshrc
ln -s ./configurationFiles/conf/alacritty.toml .alacritty.toml
ln -s ./configurationFiles/conf/tmux.conf .tmux.conf

# coyping kitty configuration
mkdir -p ~/.config/kitty
cp ./configurationFiles/conf/kitty.conf ~/.config/kitty/kitty.conf
cp ./configurationFiles/conf/theme.conf ~/.config/kitty/theme.conf



# Installing zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

source "$HOME/.zshrc"
