#!/usr/bin/env zsh

# Get antigen if we don't already have it.
if [ ! -f $HOME/antigen.zsh ]; then
  curl -sL git.io/antigen > $HOME/antigen.zsh
fi

source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle env
antigen bundle ssh-agent

# Configure ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme Lyrain/dotfiles xxf

antigen apply

# Aliases
alias cl='clear'

if type exa > /dev/null; then
  alias ls='exa'
  alias l='exa -lg --icons'
  alias ll='exa -lag --icons'
else
  alias l='ls -l'
  alias ll='ls -lah'
fi

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

# Convenience
alias hm='home-manager'
alias k='kubectl'
alias tf='terraform'
alias gdb='gdb -q'
alias mol='molecule'
alias ans='ansible'
alias ansp='ansible-playbook'
alias ansl='ansible-lint'

alias awsident='export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)'

alias msf-pattern_create='/opt/metasploit/tools/exploit/pattern_create.rb'
alias msf-pattern_offset='/opt/metasploit/tools/exploit/pattern_offset.rb'
alias tunip="ip a s tun0 | grep 'inet ' | awk '{ print \$2 }'"

# Tmux
alias tma='tmux attach'
alias tmz='tmux detatch'
alias tms='tmux list-sessions'

function getcert() {
  echo | openssl s_client -connect "${1}:${2}" | \
    sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

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

start-tmux-logger() {
  local -r COLOR_RED=$'\e[31m' COLOR_GREEN=$'\e[32m' \
    COLOR_BLUE=$'\e[34m' RESET_COLORS=$'\e[0m'

  if [ -n "$TMUX" ]; then
    log_file_name=$(tmux display-message -p "#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log")
    file="$HOME/.local/share/tmux/${log_file_name}"

    if type ansifilter >/dev/null 2>&1; then
      tmux pipe-pane "exec cat - | ansifilter >> $file"
      printf "${COLOR_GREEN}Started logging to ${file}.${RESET_COLORS}\n"
    else
      printf "${COLOR_RED}ansifilter not installed.${RESET_COLORS}\n"
    fi
  else
    printf "${COLOR_RED}Not in a tmux session.${RESET_COLORS}\n"
  fi
}

# OS Specific
case "$(uname)" in
  'Darwin')
    # pbcopy is OS X specific
    alias cpwd='printf "%q\n" "$(pwd)" | pbcopy'
    ;;
  'Linux')
     alias cpwd='printf "%q\n" "$(pwd)" | xsel'
     ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
