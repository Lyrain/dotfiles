set fish_greeting

set -e EDITOR
set -Ux EDITOR nvim
set -Ux TERM screen-256color

set -Ua fish_user_paths $HOME/go/bin/

if type "ruby" > /dev/null
    set -Ux GEM_HOME (ruby -e 'print Gem.user_dir')
    set -Ua fish_user_paths $GEM_HOME/bin
end

function nixwhere
    readlink (which "$argv")
end

bind \cr __fzf_reverse_isearch

abbr l 'ls -lh'
abbr ll 'ls -lah'
abbr - 'cd -'
abbr .. 'cd ..'
abbr g 'git'

abbr gs 'git status'
abbr gd 'git diff'
abbr gl 'git pull'
abbr gp 'git push'
abbr glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
abbr gco 'git checkout'
abbr gcom 'git checkout master'
abbr config 'git --git-dir $HOME/.dotfiles.git/ --work-tree $HOME'

abbr vi 'nvim'
abbr vim 'nvim'
abbr vif 'nvim $(fzf)'

abbr path 'printenv PATH | tr ":" "\n"'
abbr trim 'sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//"'
