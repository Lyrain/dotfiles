# To clone, see .scripts/bootstrap.sh

# Get antigen if we don't already have it.
if [ ! -f $HOME/antigen.zsh ]; then
  curl -sL git.io/antigen > $HOME/antigen.zsh
fi

source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle cargo
antigen bundle env

antigen bundle kiurchv/asdf.plugin.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme Raymanns/dotfiles xxf

antigen apply

# ZSH_THEME="xxf"

# Aliases
alias cl='clear'
alias l='ls -l'
alias ll='ls -lah'
alias ..='cd ..'
alias desk='~/Desktop'
alias trim='sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//"'

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

# Display the expanded alias on running one
# See https://stackoverflow.com/questions/9299402/echo-all-aliases-in-zsh
_-accept-line () {
    emulate -L zsh
    local -a WORDS
    WORDS=( ${(z)BUFFER} )
    # Unfortunately ${${(z)BUFFER}[1]} works only for at least two words,
    # thus I had to use additional variable WORDS here.
    local -r FIRSTWORD=${WORDS[1]}
    local -r GREEN=$'\e[32m' RESET_COLORS=$'\e[0m'
    [[ "$(whence -w $FIRSTWORD 2>/dev/null)" == "${FIRSTWORD}: alias" ]] &&
        echo -nE $'\n'"${GREEN}Executing $(whence $FIRSTWORD)${RESET_COLORS}"
    zle .accept-line
}
zle -N accept-line _-accept-line

# OS Specific
case "$(uname)" in
  'Darwin')
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
    ;;
  'Linux')
     alias cpwd='printf "%q\n" "$(pwd)" | xsel'
     ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

