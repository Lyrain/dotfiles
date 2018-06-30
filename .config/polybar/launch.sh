#!/bin/sh
#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the process have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#for i in $(polybar -m | awk -F: '{print $1}'); do
#  MONITOR=$i polybar example -c ~/.config/polybar/config &
#done

if uname -r | awk '/ARCH$/'; then
  polybar DVI &
  polybar HDMI-1 &
else
  polybar eDP &
  polybar HDMI-1-1 &
fi

feh --bg-scale ~/.config/wall.png

