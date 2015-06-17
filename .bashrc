#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Show and hide hidden files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
killall Finder /System/Library/CoreServices/Finder.app'

# Reset the screen shot directory to the desktop
alias resetScreenshotdir='defaults write com.apple.screencapture location ~/Desktop; killall SystemUIServer'

alias cl='clear'

# Pretty code copy function
function hl() {
    if [ -z "$1" ]; then
        echo Your doing things wrong...
    else
        highlight -O rtf -t 2 -K 11 "$1" | pbcopy
    fi
}

# Add laravel to the PATH. Gets removed on close, hence here.
export PATH="$PATH:~/.composer/vendor/bin"

# Add homebrew sbin to PATH so that executables work
export PATH="/usr/local/sbin:$PATH"

# Set the EDITOR env variable
export EDITOR=vim
