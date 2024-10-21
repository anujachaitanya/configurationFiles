#! /bin/bash

coreUtils=(
    starship
    alacritty
    tmux
    tree
    openjdk@17
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
