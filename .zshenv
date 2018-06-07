#
# ~/.zshenv
#

# You may need to manually set your language environment
export LANG=en_GB.UTF-8
export EDITOR="nvim"

# OS Specific
if [[ "$(uname)" == 'Darwin' ]]; then
  # Add laravel to the PATH. Gets removed on close, hence here.
  export PATH="$PATH:~/.composer/vendor/bin"


# Add ~/bin to path, hold lein
export PATH="$PATH:/home/myles/bin"
export PATH="$PATH:/home/myles/.cargo/bin"
export PATH="$PATH:/home/myles/.scripts"
export LD_LIBRARY_PATH="/usr/local/lib"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

  # Add pylint to PATH
  export PATH="$PATH:/usr/local/Cellar/python3/3.5.0/Frameworks/Python.framework/Versions/3.5/bin"

  # Set GEM_HOME for per-user gem install
  export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
fi

# if [[ "$(uname)" == 'Linux' ]]; then
#   # Game starting scripts
#   export PATH="$PATH:~/Games/startScripts/"
#
#   # Sound set-up for QEMU
#   export QEMU_AUDIO_DRV=alsa
#
#   # Set terminal to urxvt
#   export TERM=rxvt-unicode
# fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
