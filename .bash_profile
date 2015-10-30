#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

if [[ "$(uname)" == 'Linux' ]]; then
  # Starts the X server
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

