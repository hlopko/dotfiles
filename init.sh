#!/bin/bash

set -e

apt_packages="vim-gnome xstow tree ruby ruby-dev mutt offlineimap "\
"msmtp-gnome tmux zsh"

sudo apt-get install -y $apt_packages

echo "Done installing packages"

packages_to_be_linked=( bash bin gdb git hg ruby screen tmux vim zsh mail )

if [[ $1 = "clean" ]]; then
	ARGS="-D"
else
	ARGS="-f"
fi

for package in "${packages_to_be_linked[@]}"
do
	xstow $ARGS $package
done

echo "Done symlinking"

if [[ ! $1 = "clean" ]]; then
	if [[ ! $1 = "fast" ]]; then
		screen -D -m vim -X +PluginInstall +qall
		echo "Done installing vim plugins"
	fi
fi

echo "Done initializing dotfiles"
