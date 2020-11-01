#!/usr/bin/env bash
function Check-ZSH {
	if [[ ! "$(command  -v zsh)" ]]; then
		echo -e "\e[91mZSH is not installed... Please install it with your package manager!"
		exit 1
	fi
}
function Check-Wget {
    if [[ ! "$(command  -v wget)" ]]; then
	echo -e "\e[91mWget is not installed... Please install it with your package manager!"
	exit 1
    fi
}
function Check-Tar {
    if [[ ! "$(command -v tar)" ]]; then
	echo -e "\e[91mTar is not installed... Please install it with your package manager!"
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
function Create-Testdir {
    printf "\e[96mCreating temp directory...\r"
    TEMPDIR=`mktemp -d`
    echo -e "\e[94mCreated temp directory ${TEMPDIR}"
}
function Download-Archive {
    printf "\e[96mDownloading theme...\r"
    wget https://github.com/Sulfurium/zsh-theme/archive/main.tar.gz -O "${TEMPDIR}/theme.tar.gz" -o /dev/null
    if [[ $? != 0 ]]; then
	echo -e "\e[91mOops! Error while Downloading theme!"
	exit 1
    fi
    echo -e "\e[94mDownloaded Sucessfully!"
}
function Extract-Theme {
    printf "\e[96mExtracting theme...\r"
    tar xf "${TEMPDIR}/theme.tar.gz" -C "${TEMPDIR}" 2> /dev/null
    if [[ $? != 0 ]]; then
	echo -e "\e[91mOops! Error while extracting theme!"
	exit 1
    fi
    echo -e "\e[94mTheme extracted succesfully!"
}
function Install-Theme {
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
function Setup-ZSHRC {
    echo -e "\e[96mInstalling new ZSHRC..."
    cp "${HOME}/.zshrc" "${HOME}/.zshrc-bak"
    echo -e "Old ZSHRC backed up at ${HOME}/.zshrc-bak"


}
function main {
    Check-ZSH;
    Check-Inet;
    Check-Wget;
    Check-Tar;
    Create-Testdir
    Download-Archive;
    Extract-Theme;
    Install-Theme;
    Setup-ZSHRC;
}
main;
