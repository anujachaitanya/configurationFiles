#! /bin/bash

#### APPLICATIONS ####

applications=(
  brave
  visual-studio-code
  intellij-idea
  zoom
  alacritty
  1password
  flycut
  numi
  emacs
  kitty
)

for i in "${applications[@]}"; do
  echo "installing" "$i";
  brew install --cask "$i"
done
