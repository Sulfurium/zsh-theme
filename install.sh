#!/usr/bin/env bash
if [[ ! "$(command -v zsh)" ]]; then
	echo -e "\e[91mZSH is not installed... Please install it with your Package manager!"
	exit 1	
fi
