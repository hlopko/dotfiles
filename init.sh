#!/bin/bash

hash stow 2>/dev/null || { echo >&2 "I require stow but it's not installed.  Aborting."; exit 1; }

packages=( ack bash bin gdb git hg ruby screen tmux vim zsh )

if [[ $1 = "clean" ]]; then
	ARGS="-D"
fi


for package in "${packages[@]}"
do
	stow $ARGS $package
done

vim +BundleInstall +qall
cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make


