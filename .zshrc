# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xxf"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby rails)

# User configuration

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor
export EDITOR='vim'

# No need to change directory with cd, Can just type dir name an hit enter
setopt autocd

alias cl='clear'
alias ll='ls -lah'
alias ..='cd ..'
alias cpwd='pwd | pbcopy'

# OS Specific
if [[ "$(uname)" == 'Darwin' ]]; then
  # Show and hide hidden files
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
  killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
  killall Finder /System/Library/CoreServices/Finder.app'

  alias py='python3'
  # alias ruby="/usr/local/Cellar/ruby/2.2.3/bin/ruby"

  # Pretty code copy function
  function hl () {
      if [ -z "$1" ]; then
          echo Your doing things wrong...
      else
          highlight -O rtf -t 2 -K 11 "$1" | pbcopy
      fi
  }

  function git () {
      if [ "$1" = push ]; then
          command git push && say -v Whisper "It has been pushed"
      else
          command git "$@"
      fi
  }
elif [[ "$(uname)" == 'Linux' ]]; then
  alias sysupdate='sudo pacman -Syu'
fi

