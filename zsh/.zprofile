#
#  ~/.zprofile
#

if [[ "$(uname)" == 'Linux' ]]; then
  # Starts the X server
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

if [[ "$(uname)" == 'Darwin' ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
