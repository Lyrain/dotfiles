#
# ~/.profile
#

export EDITOR=nvim
export TERM=screen-256color

export LD_LIBRARY_PATH="/usr/local/lib"
export LIBRARY_PATH=${LD_LIBRARY_PATH}

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--height 40% --reverse --border"

if type "ruby" > /dev/null; then
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
    PATH="$PATH:${GEM_HOME}/bin"
fi
