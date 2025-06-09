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
    kubernetes-cli
    watch
    docker-completion
    autojump
    fzf
    define
)

for i in "${coreUtils[@]}"; do
    echo "installing" "$i";
    brew install "$i"
done
