#!/usr/bin/env zsh

# A simple script for setting up OSX dev environment.

dev="$HOME/Developer"
pushd .
mkdir -p $dev
cd $dev

echo 'Change machine hostname?'
printf '(y/n) [n] '
read should_change_hostname
if [[ $should_change_hostname == 'y' ]]; then
  echo 'Enter new hostname of the machine (e.g. macbook-paulmillr)'
  read hostname
  echo "Setting new hostname to $hostname..."
  scutil --set HostName "$hostname"
  compname=$(sudo scutil --get HostName | tr '-' '.')
  echo "Setting computer name to $compname"
  scutil --set ComputerName "$compname"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"
fi

pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Open Github to paste key in?'
printf '(y/n) [n] '
read should_open_github
if [[ $should_open_github == 'y' ]]; then
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'
fi

# If we are on OS X, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew update
      brew install trash node
      brew tap phinze/homebrew-cask
      brew install caskroom/cask/brew-cask
      brew install git-extras
  fi

  echo 'Tweaking OS X...'
    source "$dev/rosshamish/dotfiles/etc/osx.sh"
else; then
  sudo apt-get install git-extras
fi

echo 'Symlinking config files...'
  source "$dev/rosshamish/dotfiles/symlink-dotfiles.sh"

open_apps() {
  echo 'Install apps:'
  echo 'Dropbox:'
  open https://www.dropbox.com
  echo 'Chrome:'
  open https://www.google.com/intl/en/chrome/browser/
  echo 'VLC:'
  open http://www.videolan.org/vlc/index.html
  echo 'Sublime Text:'
  open http://www.sublimetext.com
}

echo 'Open application pages for download? (e.g. Dropbox, Chrome, VLC, Sublime)'
printf '(y/n) [n] '
read give_links
[[ "$give_links" == 'y' ]] && open_apps

printf '\nSystem setup complete.\n'

popd >> /dev/null
