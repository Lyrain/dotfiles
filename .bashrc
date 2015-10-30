#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# OS Specific
if [[ "$(uname)" == 'Darwin' ]]; then
  # Show and hide hidden files
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
  killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
  killall Finder /System/Library/CoreServices/Finder.app'

  alias py='python3'

  # Pretty code copy function
  function hl() {
      if [ -z "$1" ]; then
          echo Your doing things wrong...
      else
          highlight -O rtf -t 2 -K 11 "$1" | pbcopy
      fi
  }
elif [[ "$(uname)" == 'Linux' ]]; then
  alias sysupdate ='sudo pacman -Syu'
fi

alias cl='clear'
alias ll='ls -lah'
alias tree='tree -I *.pyc'

