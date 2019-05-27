#
# ~/.zshenv
#

# You may need to manually set your language environment
export LANG=en_GB.UTF-8
export EDITOR="nvim"

export LD_LIBRARY_PATH="/usr/local/lib"
export LIBRARY_PATH=LD_LIBRARY_PATH
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# array of paths to try to add to PATH
# Only adds paths that exist as directories
paths=("$HOME/bin"
       "$HOME/.scripts" # for dotfiles scripts
       "$HOME/.composer/vendor/bin" # laravel (macOS)
       "$HOME/.config/.composer/vendor/bin" # laravel (linux)
       "$HOME/.cargo/bin" # cargo
       "$HOME/go/bin" # golang
       "$HOME/Library/Python/3.7/bin"
       "$HOME/.local/bin" # pip executables installed with --user
       "/usr/local/Cellar/python3/3.5.0/Frameworks/Python.framework/Versions/3.5/bin" # pylint
       "/snap/bin" # Snap
       "/usr/local/opt/php@7.1/bin"
       "/usr/local/opt/php@7.1/sbin"
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

# For Enviroment variables that I may not wish to add to git
if [ -f "$HOME/.env" ]; then
  . $HOME/.env
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

