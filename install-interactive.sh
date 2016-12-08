#!/usr/bin/env zsh

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

dev="$HOME/Developer"
pushd .
mkdir -p $dev
cd $dev

echo 'Beginning...'

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
  echo 'Install zsh?'
  printf '(y/n) [y] '
  read should_zsh
  if [[ $should_brew != 'n' && $should_zsh != 'n' ]]; then
    brew install zsh

    echo 'Install oh-my-zsh?'
    printf '(y/n) [y] '
    read should_oh_my_zsh
    if [[ $should_oh_my_zsh != 'n' ]]; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
  fi
else
  echo 'Nvm, cant install brew, not on OSX'
fi

echo 'Symlink dotfiles?'
printf '(y/n) [y] '
read should_dotfiles
if [[ $should_dotfiles != 'n' ]]; then
  source "$dev/rosshamish/dotfiles/symlink-dotfiles.sh"
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
echo '* use the .otf font in this directory'
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
  source "$dev/rosshamish/dotfiles/etc/osx.sh"
fi

printf '\n== Complete ===\n'

popd >> /dev/null
