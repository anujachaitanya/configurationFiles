#! /bin/bash

coreUtils=(
    starship
    alacritty
    tmux
    tree
    colima
    docker
    tig
    autojump
    go
    node
    tldr
    define
)

for i in "${coreUtils[@]}"; do
    echo "installing" "$i";
    brew install "$i"
done
