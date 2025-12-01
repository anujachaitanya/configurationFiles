#! /bin/bash

#### APPLICATIONS ####

applications=(
  brave
  visual-studio-code
  intellij-idea
  zoom
  1password
  emacs
  ghostty
)

for i in "${applications[@]}"; do
  echo "installing" "$i";
  brew install --cask "$i"
done
