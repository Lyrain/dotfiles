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
plugins=(git ruby rails cargo vundle)

# User configuration

source $ZSH/oh-my-zsh.sh

# No need to change directory with cd, Can just type dir name and hit enter
setopt autocd

# Set vi mode
# bindkey -v

# Aliases
alias cl='clear'
alias ll='ls -lah'
alias ..='cd ..'
alias desk='~/Desktop'

# Git aliases
alias gits='git status'

# Pretty print json
alias json='python -m json.tool'

# OS Specific
if [[ "$(uname)" == 'Darwin' ]]; then
  # Show and hide hidden files
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
  killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
  killall Finder /System/Library/CoreServices/Finder.app'

  alias python='python3'
  # pbcopy is OS X specific
  alias cpwd='printf "%q\n" "$(pwd)" | pbcopy'
  # alias ruby="/usr/local/Cellar/ruby/2.2.3/bin/ruby"

  # Pretty code copy function
  function hl () {
      if [ -z "$1" ]; then
          echo Your doing things wrong...
      else
          highlight -O rtf -t 2 -K 11 "$1" | pbcopy
      fi
  }
elif [[ "$(uname)" == 'Linux' ]]; then
fi

(cat ~/.cache/wal/sequences &)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
