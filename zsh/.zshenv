#!/usr/bin/env zsh
#
# ~/.zshenv
#

# You may need to manually set your language environment
export LANG=en_GB.UTF-8
export EDITOR="nvim"
# export SHELL="/bin/zsh"

# Don't use screen-256color as it causes issues with the command being printed
# out before execution (seperate to alias expansion)
export TERM="xterm-256color"
export XDG_DATA_HOME="$HOME/.local/share"

export LD_LIBRARY_PATH="/usr/local/lib"
export LIBRARY_PATH=LD_LIBRARY_PATH
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!./git/*"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

if [[ "$(uname)" == 'Darwin' ]]; then
    export JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8)
    alias java8="export JAVA_HOME=$JAVA_8_HOME"

    export JAVA_11_HOME=$(/usr/libexec/java_home -v 11.0.18)
    alias java11="export JAVA_HOME=$JAVA_11_HOME"

    export JAVA_HOME="$JAVA_11_HOME"
else
    export JAVA_HOME="/usr/lib/jvm/default"
fi

export AWS_DEFAULT_REGION="eu-west-2"

# array of paths to try to add to PATH
# Only adds paths that exist as directories
paths=("$HOME/.config/script" # for dotfiles scripts
       "$HOME/.cargo/bin" # cargo
       "$HOME/go/bin" # golang
       "$HOME/.yarn/bin" # yarn
       "$HOME/.config/yarn/global/node_modules/.bin"
       "$HOME/Library/Python/3.7/bin"
       "$HOME/.local/bin" # pip executables installed with --user
       "$HOME/.local/share/coursier/bin" # Coursier (Scala)
       )

for p in $paths; do
  if [ -d "$p" ]; then
    export PATH="$p:$PATH"
  fi
done

if type "ruby" > /dev/null; then
  # Set GEM_HOME for per-user gem install
  export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
fi

if type "rustc" > /dev/null; then
  # set rust src path for racer
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if type pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if type direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# For Enviroment variables that I may not wish to add to git
if [ -f "$HOME/.env" ]; then
  . $HOME/.env
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
