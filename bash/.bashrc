#!/bin/sh

# History stuff
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTILESIZE=100000
shopt -s histappend

# Vi mode
set -o vi
bind -m vi-command '"\C-l": clear-screen'
bind -m vi-insert  '"\C-l": clear-screen'

alias md="mkdir -p"
alias mv="mv -i"
alias rm="rm -i"

# ls -> exa
LSOPTS="-F"
LSPROG="ls"
command -v exa >/dev/null && LSPROG="exa" && LSOPTS="-gF"

alias ls="$LSPROG $LSOPTS"
alias la="$LSPROG $LSOPTS -a"
alias ll="$LSPROG $LSOPTS -l"
alias  l="$LSPROG $LSOPTS -hal"

# Command aliases
alias clo="curl -LO"
alias info="info --vi-keys"
alias f="vifm"

# Nvim
alias v="nvim"

# Git aliases
alias   g="git"
alias  gs="git status"
alias gss="git status -s"
alias  gc="git commit"
alias  ga="git add"
alias gap="git add -p"
alias  gd="git diff"
alias gds="git diff --staged"
alias  gl="git log"
alias gco="git checkout"
alias  gb="git branch"
alias gsw="git switch"
alias  gp="git pull"
alias gpu="git push"
alias  gb="git-bug"

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

PROMPT_COMMAND="history -a; history -c; history -r; bash_prompt_command"

