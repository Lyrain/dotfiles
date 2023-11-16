#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export TERM=screen-256color

# Prompt set up

COLOR_RESET="\[\033[00;00m\]"
COLOR_GREEN="\[\033[00;32m\]"
COLOR_YELLOW="\[\033[00;33m\]"
COLOR_CYAN="\[\033[00;36m\]"

export PS1="${COLOR_CYAN}\u${COLOR_RESET} at ${COLOR_GREEN}\h${COLOR_RESET} ${COLOR_YELLOW}[\w]$COLOR_RESET\n› "

shopt -s autocd

alias cls='clear'
alias ls='ls --color=auto'
alias l='ls -l --color=auto'
alias ll='ls -lah --color=auto '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
#alias "-"='cd -'

alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias gco='git checkout'
alias gcom='git checkout master'
alias config='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

alias vi='nvim'
alias vim='nvim'
alias vif='nvim $(fzf)'

alias path='printenv PATH | tr ":" "\n"'

nixwhere()
{
    readlink $(which $@)
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
