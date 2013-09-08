#!/bin/bash

set -e

hash xstow 2>/dev/null || { echo >&2 "I require stow but it's not installed.  Aborting."; exit 1; }

packages=( bash bin gdb git hg ruby screen tmux vim zsh )

if [[ $1 = "clean" ]]; then
	ARGS="-D"
else
	ARGS="-f"
fi


for package in "${packages[@]}"
do
	xstow $ARGS $package
done

if [[ ! $1 = "clean" ]]; then
	if [[ ! $1 = "fast" ]]; then
		vim +BundleInstall +qall
		cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make
	fi
fi


