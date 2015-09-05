setxkbmap -option caps:escape

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
