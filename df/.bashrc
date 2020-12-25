#!/bin/sh

alias md="mkdir -p"

alias ls="exa --color=auto"
alias ll="exa -l"
alias la="exa -a"
alias  l="exa -halF"

alias mv="mv -i"
alias rm="rm -i"

alias v="nvim"
alias r="ranger"

alias gs="git status"
alias ga="git log"
alias gc="git commit"

bash_prompt_command() {
	# Make the home display as '~'
	CUSTOM_PWD="$(pwd | sed "s|^$HOME|~|")"

	# Shorten all parent directories' names to one letter
	local SHORT_PATH=$(echo $CUSTOM_PWD | sed 's|/|\n|g' | sed '/^$/d;$d' | cut -c1 | tr '\n' '/')

	# Get the name of the current dir
	local CURRENT_DIR=$(echo $CUSTOM_PWD | sed 's|/|\n|g' | tail -1)

	# Create the new path (don't add leading '/' when at home)
	[ "$(echo $CUSTOM_PWD | cut -c1)" = "~" ] && \
	CUSTOM_PWD="${SHORT_PATH}${CURRENT_DIR}" || \
	CUSTOM_PWD="/${SHORT_PATH}${CURRENT_DIR}"

	# Privilege symbol + path color
	local PS_SYMBOL=">"
	local PATH_COLOR="33m"
	[ "$(id -u)" = "0" ] && local PS_SYMBOL="#" \
	                     && local PATH_COLOR="31m"

	# Update the prompt
	PS1="\[\033[${PATH_COLOR}\]${CUSTOM_PWD}\[\033[0m\]$PS_SYMBOL "
}

PROMPT_COMMAND="bash_prompt_command"

