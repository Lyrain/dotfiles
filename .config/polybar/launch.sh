#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the process have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#for i in $(polybar -m | awk -F: '{print $1}'); do
#  MONITOR=$i polybar example -c ~/.config/polybar/config &
#done

case $(hostname) in
zeus)
  MONITOR=DVI-I-1 polybar DVI &
  polybar HDMI-1 &
  ;;
daportbd1)
  MONITOR=eDP-1 polybar daportbd &
  MONITOR=HDMI-1 polybar daportbd &
  ;;
esac

feh --bg-scale ~/.config/wall.png

