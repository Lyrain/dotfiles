#
# ~/.zshenv
#

# You may need to manually set your language environment
export LANG=en_GB.UTF-8
export EDITOR="nvim"

export LD_LIBRARY_PATH="/usr/local/lib"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# array of paths to try to add to PATH
# Only adds paths that exist as directories
paths=("$HOME/bin" # for lein
       "$HOME/.scripts" # for dotfiles scripts
       "$HOME/.composer/vendor/bin" # laravel (macOS)
       "$HOME/.config/.composer/vendor/bin" # laravel (linux)
       "$HOME/.cargo/bin" # cargo
       "$HOME/.src/Cataclysm-DDA"
       "/usr/local/Cellar/python3/3.5.0/Frameworks/Python.framework/Versions/3.5/bin" # pylint
       )

for p in $paths; do
  if [ -d "$p" ]; then
    export PATH="$PATH:$p"
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

