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
  echo "$from -> $to"
  if [[ -f "$to" ]]; then
    rm -f "$to"
  else
    rm -rf "$to"
  fi
  ln -s "$from" "$to"
}

pushd $dotfiles >> /dev/null
for location in $(find home -name '.*'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$dotfiles/$location" "$HOME/$file"
done
echo "Done."
ls -al $HOME | grep -e '\..*'
popd >> /dev/null


