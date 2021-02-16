#!/bin/bash

git clone --separate-git-dir=$HOME/.dotfiles.git \
  https://github.com/Lyrain/dotfiles.git \
  $HOME/dotfiles-tmp

# cp ~/dotfiles-tmp/.gitmodules ~  # If you use Git submodules

rm -r ~/dotfiles-tmp/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config status

config checkout master
config reset --hard
config config --local status.showUntrackedFiles no

