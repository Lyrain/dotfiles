#
# ~/.zshenv
#

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor
export EDITOR='vim'

# Add ~/bin to path, hold lein
export PATH="$PATH:/home/myles/bin"
export PATH="$PATH:/home/myles/.cargo/bin"
export PATH="$PATH:/home/myles/.scripts"
export LD_LIBRARY_PATH="/usr/local/lib"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

