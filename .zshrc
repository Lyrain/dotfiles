# # To clone:
# #
# # git clone --separate-git-dir=$HOME/.myconf /path/to/repo $HOME/myconf-tmp
# # cp ~/myconf-tmp/.gitmodules ~  # If you use Git submodules
# # rm -r ~/myconf-tmp/
# # alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
# #
#
# # Path to your oh-my-zsh installation.
# export ZSH=~/.oh-my-zsh
#
# # Set name of the theme to load.
# # Look in ~/.oh-my-zsh/themes/
# # Optionally, if you set this to "random", it'll load a random theme each
# # time that oh-my-zsh is loaded.
#
# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder
#
# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(git cargo env)
#
# # User configuration
#
# source $ZSH/oh-my-zsh.sh
#
# # No need to change directory with cd, Can just type dir name and hit enter
# setopt autocd

if [ ! -f $HOME/antigen.zsh ]; then
  curl -sL git.io/antigen > $HOME/antigen.zsh
fi

source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle cargo
antigen bundle env

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme Raymanns/dotfiles xxf

antigen apply

# ZSH_THEME="xxf"

# Aliases
alias cl='clear'
alias ll='ls -lah'
alias ..='cd ..'
alias desk='~/Desktop'

# Git aliases
alias gs='git status' # take priority over GhostScript
alias config='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# use neovim
alias vi='nvim'
alias vim='nvim'
alias vif='nvim $(fzf)'

# Pretty print json
alias json='python -m json.tool'

# Print out PATH legibly
alias path='printenv PATH | tr ":" "\n"'

# play youtube videos given a URL
function yt() {
  mpv --ytdl "$@"
}

if [ -d ~/Homestead ] && type "vagrant" > /dev/null; then
  function homestead() {
      ( cd ~/Homestead && vagrant $* )
  }
fi

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

  alias matlab='/Applications/MATLAB_R2018b.app/bin/matlab -nodesktop'
elif [[ "$(uname)" == 'Linux' ]]; then
  alias cpwd='printf "%q\n" "$(pwd)" | xsel'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

