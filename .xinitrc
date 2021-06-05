#!/bin/bash

# Tell X to load ~/.Xresources
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

# Binds escape to caps lock key cause I don't have alien fingers
setxkbmap -option caps:escape

# Disable the screen from going black
xset s off -dpms

# monitor orientation
xrandr --output HDMI-0 --left-of DVI-I-1

# If udiskie is installed, start the daemon
if type "udiskie" > /dev/null; then
  udiskie &
fi

QT_QPA_PLATFORMTHEME=qt5ct

# session=${1:-i3}
#
# case $session in
#   i3  ) exec i3;; # -d all --shmlog-size 26214400;;
# esac
