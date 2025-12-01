#! /bin/bash

coreUtils=(
    starship
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
    docker-compose
    k9s
)

for i in "${coreUtils[@]}"; do
    echo "installing" "$i";
    brew install "$i"
done
