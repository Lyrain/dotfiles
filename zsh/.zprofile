#
#  ~/.zprofile
#

if [[ "$(uname)" == 'Linux' ]]; then
  # Starts the X server
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

if [[ "$(uname)" == 'Darwin' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
