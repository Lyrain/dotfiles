#! /bin/bash

# Ask for sudo upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [[ "$(uname)" == 'Darwin' ]]; then
  # Install home brew
  if [[ "$(which brew)" == "" ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Update brew and upgrade everything
  brew update
  brew upgrade --all

  # Install the necessary stuff
  brew install git
  brew install tree
  brew install rmtree

  # Remove outdated versions from the cellar
  brew cleanup

elif [[ "$(uname)" == 'Linux' ]]; then
  # Assume arch, use pacman
  pacman -Syu
fi
