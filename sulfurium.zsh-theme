if [[ $UID == 0 ]]; then
	PROMPT="%B%F{red}%(?..%? )%f%b%B%F{red}%n%f%b@%m %F{cyan}%B%40<.. <%~%<< %b% %F{white}# "
else 
	PROMPT="%B%F{red}%(?..%? )%f%b%B%F{red}%n%f%b@%m %F{cyan}%B%40<.. <%~%<< %b% %F{white}$ "
fi
