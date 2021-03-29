#!/usr/bin/env bash

checkzsh() {
	if [[ ! "$(command  -v zsh)" ]]; then
		echo -e "\e[91mZSH is not installed... Please install it with your package manager!"
		exit 1
	fi
}

checkwget() {
    if [[ ! "$(command  -v wget)" ]]; then
	echo -e "\e[91mWget is not installed... Please install it with your package manager!"
	exit 1
    fi
}

checktar() {
    if [[ ! "$(command -v tar)" ]]; then
	echo -e "\e[91mTar is not installed... Please install it with your package manager!"
	exit 1
    fi
}

checkinet() {
    ping -c 1 kernel.org > /dev/null || {
	echo -e "\e[91mYou are not connected to internet! Please check your internet connection and retry!";
	exit 1;
    }
}

createtempdir() {
    printf "\e[96mCreating temp directory...\r"
    TEMPDIR=`mktemp -d`
    echo -e "\e[94mCreated temp directory ${TEMPDIR}"
}

downloadarchive() {
    printf "\e[96mDownloading theme...\r"
    wget https://github.com/Sulfurium/zsh-theme/archive/main.tar.gz -O "${TEMPDIR}/theme.tar.gz" -o /dev/null
    if [[ $? != 0 ]]; then
	echo -e "\e[91mOops! Error while Downloading theme!"
	exit 1
    fi
    echo -e "\e[94mDownloaded Sucessfully!"
}

extracttheme() {
    printf "\e[96mExtracting theme...\r"
    tar xf "${TEMPDIR}/theme.tar.gz" -C "${TEMPDIR}" 2> /dev/null
    if [[ $? != 0 ]]; then
	echo -e "\e[91mOops! Error while extracting theme!"
	exit 1
    fi
    echo -e "\e[94mTheme extracted succesfully!"
}

installtheme() {
    printf "\e[96mInstalling theme...\r"
    if [[ -d "${HOME}/.oh-my-zsh" ]]; then
	OMZ_PRESENT="true"
	INSDIR="${HOME}/.oh-my-zsh/custom/themes"
    else
	OMZ_PRESENT="false"
	INSDIR="${HOME}/.sulfurium-zsh"
    fi
    [ -d "${INSDIR}" ] || mkdir "${INSDIR}"
    mv "${TEMPDIR}/zsh-theme-main/sulfurium.zsh-theme" "${INSDIR}/"
    echo -e "\e[94mTheme successfully installed."
}

setupzshrc() {
    echo -e "\e[96mInstalling new ZSHRC..."
    if [[ -f "${HOME}/.zshrc" ]]
    then 
        cp "${HOME}/.zshrc" "${HOME}/.zshrc-bak"
        echo -e "Old ZSHRC backed up at ${HOME}/.zshrc-bak"
    fi
    if [[ $OMZ_PRESENT == "true" ]]; then
	RC_FILE="zshrc-omz"
    else 
	RC_FILE="zshrc-none"
    fi
    cp "${TEMPDIR}/zsh-theme-main/zshrcs/${RC_FILE}" "${HOME}/.zshrc"
    echo -e "\e[92mTheme successfully installed!"
}

cleantempdir() {
    rm -rf "${TEMPDIR}"
}

main() {
    checkzsh
    checkinet
    checkwget
    checktar
    createtempdir
    downloadarchive
    extracttheme
    installtheme
    setupzshrc
    cleantempdir
}

main
