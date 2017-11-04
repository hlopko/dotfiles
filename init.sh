#!/bin/bash

set -e

apt_packages="vim-gnome xstow tree ruby ruby-dev mutt offlineimap "\
"msmtp-gnome tmux zsh"

# sudo apt-get install -y $apt_packages

echo "Done installing packages"

packages_to_be_linked=( bin gdb git hg )

if [[ $1 = "clean" ]]; then
	ARGS="-D"
else
	ARGS="-S"
fi

for package in "${packages_to_be_linked[@]}"
do
	stow $ARGS $package
done

echo "Done symlinking"

# if [[ ! $1 = "clean" ]]; then
# 	if [[ ! $1 = "fast" ]]; then
# 		screen -D -m vim -X +PluginInstall +qall
# 		echo "Done installing vim plugins"
# 	fi
# fi

echo "Done initializing dotfiles"
