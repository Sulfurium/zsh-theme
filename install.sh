#!/usr/bin/env bash
function Check-ZSH {
	if [[ ! "$(command  -v zsh)" ]]; then
		echo -e "\e[91mZSH is not installed... Please install it with your package manager!"
		exit 1
	fi
}
function Check-Inet {
ping -c 1 kernel.org > /dev/null
if [[ $? != 0 ]]; then
    echo -e "\e[91mYou are not connected to internet! Please check your internet connection and retry!";
    exit 1;
fi
}
function main {
    Check-ZSH;
    Check-Inet;
}

