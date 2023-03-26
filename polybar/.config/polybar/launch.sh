#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the process have been shut down
while pgrep polybar >/dev/null; do sleep 1; done

~/.screenlayout/layout.sh && sleep 2

for i in $(polybar -m | awk -F: '{print $1}'); do
  MONITOR=$i polybar main -c ~/.config/polybar/config & disown
done
