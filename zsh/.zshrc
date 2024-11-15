#!/usr/bin/env zsh

# Configure ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

autoload -U colors && colors

setopt autocd

# setup git information
autoload -Uz vcs_info
precmd_functions+=( vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats '%F{7}on %s%f:%F{14}%b%f%F{3}%c%f%F{9}%u%a%f %F{3}%6.6i%f'
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' ✔︎'
zstyle ':vcs_info:*' unstagedstr ' ✗'
zstyle ':vcs_info:*' enable git

PROMPT='
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[%~]%{$reset_color%} \
${vcs_info_msg_0_} \
%{$terminfo[bold]$fg[white]%}
› %{$reset_color%}'

# Aliases
alias cl='clear'

if type eza > /dev/null; then
  alias ls='eza'
  alias l='eza -lg --icons'
  alias ll='eza -lag --icons'
else
  alias l='ls -l'
  alias ll='ls -lah'
fi

# if type coursier > /dev/null; then
#     alias cs='coursier'
# fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias desk='~/Desktop'
alias trim='sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//"'

# Git aliases
alias g='git'
alias ga='git add'

alias gb='git branch'

alias gc='git commit -v'

alias gs='git status' # take priority over GhostScript

alias gd='git diff'
alias glol='git log --graph --pretty="%Cred%h%Creset %G? -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias config='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# use neovim
alias vi='nvim'
alias vim='nvim'
alias vif='nvim $(fzf)'

# Print out PATH legibly
alias path='printenv PATH | tr ":" "\n"'

alias gdb='gdb -q'

alias mol='molecule'
alias ans='ansible'
alias ansp='ansible-playbook'
alias ansl='ansible-lint'

alias hm='home-manager'
alias hme="$EDITOR ~/.config/nixpkgs/home.nix"
function nixwhere() {
    readlink $(which $@)
}

alias k='kubectl'
alias dcup='docker compose up'
alias dcdw='docker compose down'
alias dcb='docker compose build'
alias dcbnc='docker compose build --no-cache'

alias awsident='export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)'

alias msf-pattern_create='/opt/metasploit/tools/exploit/pattern_create.rb'
alias msf-pattern_offset='/opt/metasploit/tools/exploit/pattern_offset.rb'
alias tunip="ip a s tun0 | grep 'inet ' | awk '{ print \$2 }'"

# Tmux
alias tma='tmux attach'
alias tmz='tmux detach'
alias tms='tmux list-sessions'

alias work='cd $WORKSPACE'

function getcert() {
  echo | openssl s_client -connect "${1}:${2}" | \
    sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

# play youtube videos given a URL
function yt() {
  mpv --ytdl "$@"
}

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
  cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Batch rename files using sed
# https://stackoverflow.com/questions/602706/batch-renaming-files-with-bash
function sedrename() {
  if [ $# -gt 1 ]; then
    sed_pattern=$1
    shift
    for file in $(ls $@); do
      mv -v "$file" "$(sed $sed_pattern <<< $file)"
    done
  else
    echo "usage: $0 sed_pattern files..."
  fi
}


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

    ### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
    export PATH="$PATH:$HOME/.rd/bin"
    ### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
    ;;
  'Linux')
     alias cpwd='printf "%q\n" "$(pwd)" | xsel'
     ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
