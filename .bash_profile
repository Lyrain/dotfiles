#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

# Starts the X server
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

