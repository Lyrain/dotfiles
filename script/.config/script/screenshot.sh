#!/usr/bin/env bash

# Change alacritty's opacity to opaque before taking any screenshots,
# then revert it back once the screenshot has been taken.
# Makes for nicer screenshots, regardless of my background image.
#
# This is bound in i3 to Ctrl+Shift+s.

config=$HOME/.config/alacritty/alacritty.yml

changeopacity=0
if grep 'opacity: 0.82' $config; then
  changeopacity=1
fi

if [ $changeopacity -eq 1 ]; then
  sed -i 's/opacity: 0.82/opacity: 1.0/g' $config
fi

scrot --select --exec 'mv $f ~/Downloads/'

if [ $changeopacity -eq 1 ]; then
  sed -i 's/opacity: 1.0/opacity: 0.82/g' $config
fi
