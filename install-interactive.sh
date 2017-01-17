#!/bin/bash

owner=rosshamish

dev="$HOME/Developer"
mkdir -p $dev
cd $dev

echo '== Interactive script to set up your OSX dev environment =='
echo 'Ctrl-C to quit at any time.'
echo ''
echo 'Walks you through the following'
echo '* set machine name'
echo '* create ssh keypair, copy public key to clipboard'
echo '* install brew'
echo '* install zsh and oh-my-zsh'
echo '* install dotfiles for git, vim, tmux'
echo '$ setup your iterm2 color scheme, font'
echo '* set good OSX settings'
echo ''
echo "Will use dotfiles at $dev/$owner/dotfiles."
echo 'Continue?'
printf '(y/n) [y] '
read should_main
if [[ $should_main == 'n' ]]; then
  echo 'No changes made.'
  exit
fi

echo "Beginning... using dotfiles at $dev/$owner/dotfiles"

pushd .

echo 'Set machine hostname?'
printf '(y/n) [n] '
read should_change_hostname
if [[ $should_change_hostname == 'y' ]]; then
  echo 'Enter new hostname of the machine (e.g. macbook-yourname)'
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
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo 'Copy public key to clipboard?'
printf '(y/n) [n] '
read should_pbcopy_pubkey
if [[ $should_pbcopy_pubkey == 'y' ]]; then
  [[ -f $pub ]] && cat $pub | pbcopy
fi

echo 'Install brew?'
printf '(y/n) [y] '
if [[ `uname` == 'Darwin' ]]; then
  read should_install_brew
  if [[ $should_install_brew != 'n' ]]; then
    which -s brew
    if [[ $? != 0 ]]; then
      echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew update
      brew tap phinze/homebrew-cask
      brew install caskroom/cask/brew-cask
    fi
  fi
else
  echo 'Nvm, cant install brew, not on OSX'
fi

echo 'Install zsh? (requires brew on macOS)'
printf '(y/n) [y] '
read should_zsh
if [[ $should_brew != 'n' && $should_zsh != 'n' ]]; then
  if [[ `uname` == 'Darwin' ]]; then
    brew install zsh
  else
    apt-get install zsh
  fi

  echo 'Install oh-my-zsh?'
  printf '(y/n) [y] '
  read should_oh_my_zsh
  if [[ $should_oh_my_zsh != 'n' ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
fi

echo 'Install vim?'
printf '(y/n) [y] '
read should_vim
if [[ $should_vim != 'n' ]]; then
  if [[ `uname` == 'Darwin' && $should_brew != 'n' ]]; then
    brew install vim
    alias vi /usr/local/bin/vim
    alias vim /usr/local/bin/vim
  else
    apt-get install vim
  fi
fi


echo 'Symlink dotfiles? Itll symlink all these to your $HOME directory:'
find $dev/$owner/dotfiles/home -mindepth 1 -maxdepth 1 -name ".*"
printf '(y/n) [y] '
read should_dotfiles
if [[ $should_dotfiles != 'n' ]]; then
  source "$dev/$owner/dotfiles/symlink-dotfiles.sh"
fi

echo 'Setup git config?'
printf '(y/n) [y] '
read should_git_config
if [[ $should_git_config != 'n' ]]; then
  printf 'Name: '
  read git_name
  printf 'Email: '
  read git_email
  git config --global user.name $git_name
  git config --global user.email $git_email
fi

echo 'View suggested iTerm2 setup in browser?'
echo 'Youll want to'
echo '* use the Menlo font in this directory'
echo '* use the Solarized Dark theme in this directory'
printf '(y/n) [n] '
read view_in_browser
if [[ $view_in_browser == 'y' ]]; then
  open http://gist.github.com/kevin-smets/8568070
fi


echo 'Set good OSX settings?'
echo 'This changes a LOT of settings, read ./etc/osx.sh before doing this.'
printf '(y/n) [n] '
read should_osx
if [[ $should_osx == 'y' ]]; then
  source "$dev/$owner/dotfiles/etc/osx.sh"
fi

printf '\n== Complete ===\n'

popd >> /dev/null
