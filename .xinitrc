#! /bin/sh

# Binds escape to caps lock key cause I don't have alien fingers
setxkbmap -option caps:escape

# Disable the screen from going black
xset s off -dpms

# Tell X to load ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

session=${1:-i3}

case $session in
  i3  ) exec i3 # -d all --shmlog-size 26214400;;
  kde ) exec startkde;;
esac

