#!/bin/sh
#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the process have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#for i in $(polybar -m | awk -F: '{print $1}'); do
#  MONITOR=$i polybar example -c ~/.config/polybar/config &
#done
polybar eDP &
polybar HDMI &
feh --bg-scale ~/.config/wall.png

echo "Bars launched..."
