#
# ~/.zshenv
#

# OS Specific
if [[ "$(uname)" == 'Darwin' ]]; then
  # Add laravel to the PATH. Gets removed on close, hence here.
  export PATH="$PATH:~/.composer/vendor/bin"

  # Add homebrew sbin to PATH so that executables work
  export PATH="$PATH:/usr/local/sbin"

  # Add Mercurial to PATH
  export PATH="$PATH:/usr/local/Cellar/mercurial/3.5.2/bin"

  # Add pylint to PATH
  export PATH="$PATH:/usr/local/Cellar/python3/3.5.0/Frameworks/Python.framework/Versions/3.5/bin"
elif [[ "$(uname)" == 'Linux' ]]; then
  # Game starting scripts
  export PATH="$PATH:~/Games/startScripts/"

  # Sound set-up for QEMU
  export QEMU_AUDIO_DRV=alsa

  # Set terminal to urxvt
  export TERM=rxvt-unicode
fi

