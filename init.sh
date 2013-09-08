#!/bin/bash

set -e

apt_packages="ruby ruby-dev"

sudo apt-get install -y $apt_packages

hash xstow 2>/dev/null || { echo >&2 "I require stow but it's not installed.  Aborting."; exit 1; }

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

if [[ ! $1 = "clean" ]]; then
	if [[ ! $1 = "fast" ]]; then
		rvm use system
		vim +BundleInstall +qall
		cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make
	fi
fi


