#!/bin/bash

dev="$HOME/Developer"
dotfiles="$dev/rosshamish/dotfiles"

if [[ -d "$dotfiles" ]]; then
  echo "Symlinking dotfiles from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

pushd $dotfiles >> /dev/null
for location in $(find home -name '.*'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$dotfiles/$location" "$HOME/$file"
done
popd >> /dev/null

if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/sublime/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  link "$dotfiles/sublime/Packages/Theme - Soda" "$HOME/Library/Application Support/Sublime Text 3/Packages/Theme - Soda"
fi
