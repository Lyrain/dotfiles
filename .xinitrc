#! /bin/sh

# Binds escape to caps lock key cause I don't  have alien fingers
setxkbmap -option caps:escape

# Tell X to load ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Background Image
feh --bg-scale ~/arch-bg.png

while true; do
  # WiFi
  
  # Date and Time
  DWM_CLOCK=$( date '+%e %b %Y %a | %k:%M' );
  
  # Output command
  DWM_STATUS="$DWM_CLOCK";
  xsetroot -name "$DWM_STATUS";
  sleep 1m;
done &

exec dwm
