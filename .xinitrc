#! /bin/sh

# Binds escape to caps lock key cause I don't  have alien fingers
setxkbmap -option caps:escape

# Disable the screen from going black
xset s off -dpms

# Tell X to load ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Background Image
feh --bg-scale ~/arch-bg.png

while true; do
  # User and hostname
  USER_NAME=$( whoami );
  HOST_NAME=$( hostname );

  USER_HOST="$USER_NAME : $HOST_NAME";

  # Date and Time
  DWM_CLOCK=$( date '+%e %b %Y %a | %k:%M' );

  # Output command
  DWM_STATUS="$USER_HOST | $DWM_CLOCK";
  xsetroot -name "$DWM_STATUS";
  sleep 1m;
done &

exec dwm
