#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the process have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

for i in $(polybar -m | awk -F: '{print $1}'); do
  MONITOR=$i polybar main -c ~/.config/polybar/config &
done
