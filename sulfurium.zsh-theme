ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
if [[ $UID == 0 ]]; then
	PROMPT="%B%F{red}%(?..%? )%f%b%B%F{red}%n%f%b@%m %F{cyan}%B%40<.. <%~%<< %b% %F{white}# "
else 
	PROMPT="%B%F{green}%(?..%? )%f%b%B%F{green}%n%f%b@%m %F{cyan}%B%40<.. <%~%<< %b% %F{white}$ "
fi
