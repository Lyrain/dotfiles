#!/usr/bin/env bash

# Change alacritty's opacity to opaque before taking any screenshots,
# then revert it back once the screenshot has been taken.
# Makes for nicer screenshots, regardless of my background image.
#
# This is bound in i3 to Ctrl+Shift+s.

sed -i 's/background_opacity: 0.82/background_opacity: 1.0/g' $HOME/.config/alacritty/alacritty.yml
scrot --select --exec 'mv $f ~/Downloads/'
sed -i 's/background_opacity: 1.0/background_opacity: 0.82/g' $HOME/.config/alacritty/alacritty.yml
