#!/bin/bash

set -e

apt_packages="xstow tree screen ruby ruby-dev"

sudo apt-get install -y $apt_packages

echo "Done installing packages"

packages_to_be_linked=( bash bin gdb git hg ruby screen tmux vim zsh )

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
		hash rvm 2>/dev/null && rvm use system
		screen -D -m vim -X +BundleInstall +qall
		echo "Done installing vim plugins"
		cd ~/.vim/bundle/command-t/ruby/command-t 
		ruby extconf.rb 
		make
	fi
fi

echo "Done initializing dotfiles"
