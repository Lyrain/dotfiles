set fish_greeting

set -Ux EDITOR nvim

abbr l 'ls -lh'
abbr ll 'ls -lah'
abbr - 'cd -'
abbr .. 'cd ..'

function take
    mkdir -p $argv;
    cd $argv
end

abbr g 'git'
abbr gs 'git status'
abbr gd 'git diff'
abbr gl 'git pull'
abbr gp 'git push'
alias glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
abbr gco 'git checkout'
abbr gcom 'git checkout master'
alias config 'git --git-dir $HOME/.dotfiles.git/ --work-tree $HOME'

abbr vi 'nvim'
abbr vim 'nvim'
abbr vif 'nvim $(fzf)'

abbr path 'printenv PATH | tr ":" "\n"'
abbr trim 'sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//"'
