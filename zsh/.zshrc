# Rin's .zshrc

########## History ##########

HISTFILE=~/.zsh_history			# History file
HISTSIZE=10000					# Max lines in history file
SAVEHIST=$HISTSIZE				# Max history lines appended by a single shell
setopt INC_APPEND_HISTORY		# Don't wait for exit to write history
setopt HIST_IGNORE_ALL_DUPS		# Remove older duplicates
setopt HIST_IGNORE_SPACE		# Remove lines that start with a space
setopt HIST_VERIFY				# Confirm after history substitution
setopt INTERACTIVE_COMMENTS		# Allow comments in interactive mode

########## Prompt ##########

setopt PROMPT_SUBST # Enable substitution in prompt

# Shorten current path
_short_pwd() {
	# Replace user's home with a '~', split path by '/'
	# and put it all in an array
	local pwd=("${(s:/:)PWD/#$HOME/~}")

	# If more than one directory in path
	[[ ${#pwd} -gt 1 ]] && \
		for (( i=1 ; i<$#pwd ; i++ )); do
			# If element begins with a '.', keep two characters
			[[ "$pwd[$i]" = .* ]] && \
				pwd[$i]="${pwd[$i][1,2]}" || \
				pwd[$i]="${pwd[$i][1]}"
		done

	# Join the array back using "/"
	echo "${(j:/:)pwd}"
}

# Don't display username and hostname if not over ssh
_prompt_user_host() {
	[[ -n "${SSH_CLIENT}" ]] && echo "%n@%m " || :
}

# Git status in prompt
_prompt_git() {
	# Print nothing and return if not in a working tree
	! git rev-parse --is-inside-work-tree >/dev/null 2>&1 && return

	# Print branch (shorten if over 14 chars long)
	local git_branch="$(git branch --show-current 2>/dev/null)"
	[ "${#git_branch}" -gt 24 ] && \
		git_branch="${git_branch:0:21}..."
	# If no branch, print the latest commit hash
	[ -z "${git_branch}" ] && \
		git_branch="$(git log --oneline | head -1 | awk '{ print $1 }' 2>/dev/null)"
	echo -n " $git_branch"

	# Print + if modified/added, print - if deleted
	local git_status="$(git --no-optional-locks status --porcelain 2>/dev/null)"
	echo "$git_status" | grep -E "^\ *\?" >/dev/null && echo -n "%F{cyan}?"
	echo "$git_status" | grep -E "^\ *D" >/dev/null && echo -n "%F{red}-"
	echo "$git_status" | grep -E "^\ *M" >/dev/null && echo -n "%F{green}+"
	echo "$git_status" | grep -E "^\ *A" >/dev/null && echo -n "%F{yellow}+"

	# Git bisect
	git bisect log >/dev/null 2>&1 && echo -n "%F{yellow}B"

	# git-bug integration
	command -v git-bug >/dev/null && {
		[ "$(git-bug ls -s open 2>/dev/null | wc -l)" -gt 0 ] && echo "%F{yellow}#"
	}

	# Print * if stash in use
	[[ -n "$(git stash list 2>/dev/null)" ]] && echo -n "%F{yellow}*" || :
}

# Set prompt
local path_color="green"; [[ $UID -eq 0 ]] && path_color="red" # Path color based on priviledges
PROMPT='$(_prompt_user_host)%F{$path_color}$(_short_pwd)%f$(_prompt_git)%f%(0?.. %F{red}%?%f)%(!.#.>) '

########## Env ##########

# Use nvim as the pager for man
export MANPAGER='nvim +Man!'

########## Keybindings ##########

# Vim keys
bindkey -v
export KEYTIMEOUT=1

bindkey '^R'    history-incremental-pattern-search-backward	# History search
bindkey '^[[D'  backward-char								# Left
bindkey '^[[C'  forward-char								# Right
bindkey '^?'    backward-delete-char						# Backspace
bindkey '^[[3~' delete-char									# Delete
bindkey '^[[H'  beginning-of-line							# Home
bindkey '^[[1~' beginning-of-line							# Home
bindkey '^[[F'  end-of-line									# End
bindkey '^[[4~' end-of-line									# End
bindkey '^[[Z'  reverse-menu-complete						# Shift-Tab
bindkey '^[[5~' beginning-of-buffer-or-history				# PageUp
bindkey '^[[6~' end-of-buffer-or-history					# PageDown

# Edit line in vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

########## Cursor shape ##########

# Only if not running in a tty
tty | grep pts >/dev/null && {
	# Change cursor shape based on insertion mode
	function zle-keymap-select {
		{ [[ ${KEYMAP} = vicmd ]] || [[ $1 = 'block' ]] } && \
			echo -ne '\e[1 q' || \
		{ { [[ ${KEYMAP} = main ]] || [[ ${KEYMAP} = viins ]] || \
			[[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]] } && \
			echo -ne '\e[5 q' || : }
	}
	zle -N zle-keymap-select # Set widget

	# Line init widget sets cursor to beam
	zle-line-init() { echo -ne "\e[5 q" }
	zle -N zle-line-init # Set widget
}

########## Aliases & Functions ##########

# ls -> exa
LSOPTS="-F --color=auto"
LSPROG="ls"
command -v exa >/dev/null && LSPROG="exa" && LSOPTS="-gbF"

alias  ls="$LSPROG $LSOPTS"
alias   l="$LSPROG $LSOPTS -hal"
alias  ll="$LSPROG $LSOPTS -hl"
alias  la="$LSPROG $LSOPTS -a"
alias  li="$LSPROG $LSOPTS -hali"
alias lli="$LSPROG $LSOPTS -hli"

# Mkdir shortcut, rm and mv confirmation
alias md="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"
# rm without -i
alias rmnoi="/usr/bin/rm"

# Directory aliases
[ -f $ZDOTDIR/dir_aliases.zsh ] && \
	source $ZDOTDIR/dir_aliases.zsh

# Git stuff
alias    gs="git status"
alias   gss="git status -s"
alias    gc="git commit"
alias    ga="git add"
alias   gap="git add -p"
alias    gd="git diff"
alias   gds="git diff --staged"
alias    gl="git log"
alias   glo="git log --oneline"
alias  glog="git log --oneline --graph"
alias   gla="git log --all"
alias  gloa="git log --oneline --all"
alias gloag="git log --oneline --all --graph"
alias   glp="git log --patch"
alias  glpg="git log --patch --graph"
alias   gco="git checkout"
alias    gb="git branch"
alias   gsw="git switch"
alias    gp="git pull"
alias   gpu="git push"
alias    gb="git branch"
alias    gt="git tag"
alias   gcf="git cat-file"
alias  gcft="git cat-file -t"
alias  gcfp="git cat-file -p"
alias   gfu="git fsck --no-reflogs --unreachable"
alias   gbg="git-bug"
gloagu() { gloag $(gfu 2>/dev/null | cut -d' ' -f3) }

# Command aliases
alias clo="curl -LO"
alias r="ranger"
alias f="~/.config/vifm/scripts/vifm_ueberzug"
[ "$DISPLAY" ] || alias f="vifm"
alias f3="VIFM_USE_W3M=yes vifm"

# Program aliases
[ -f $ZDOTDIR/program_aliases.zsh ] && \
	source $ZDOTDIR/program_aliases.zsh

# Vinfo / info alias
alias info="info --vi-keys"
vinfo() { nvim -c "Vinfo $1" -c "silent only" }
command -v nvim >/dev/null && alias info="vinfo"

# Vim shortcuts
alias -g v="nvim"
alias  vim="nvim"

# GPG entry
GPG_TTY=$(tty)
export GPG_TTY

[ -f $ZDOTDIR/functions.zsh ] && \
	source $ZDOTDIR/functions.zsh

# Time in nanoseconds
# $1 = Command to be run
# $2 = How many times to take the average from (default: 1000)
nstime() {
	[[ -z "$1" ]] && return 1 # Exit if no command

	# Display short help
	[[ "$1" = "-h" ]] && echo "$0 cmd [repeat_num]" && return

	local AMOUNT=1000
	[[ -n "$2" ]] && AMOUNT=$2 # Set AMOUNT to $2 if non empty

	echo "$AMOUNT x $1" # Print what is being measured
	local TIME_AVG=0 TS # Define variables

	repeat $AMOUNT; do
		TS=$(date +%s%N) # Time start
		eval "$1" >/dev/null 2>&1 # Run $1 with no output
		(( TIME_AVG+=($(date +%s%N) - TS) )) # Add measured time to TIME_AVG
	done
	(( TIME_AVG/=AMOUNT )) # Calculate the average

	# Display output
	echo "$0 $TIME_AVG ns ~= $((TIME_AVG / 1000000)) ms"
}

########## Plugins ##########

# Install zinit if not found
[ -d ~/.zinit ] || {
	mkdir ~/.zinit
	git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
}

source ~/.zinit/bin/zinit.zsh

zinit ice lucid wait'!0c' atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait'!0a'
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid wait'0b' \
	atload"bindkey '^[[A' history-substring-search-up" \
	atload"bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

zinit ice lucid wait'1'
zinit light MichaelAquilina/zsh-you-should-use

########## Dynamic window title ##########

_change_title_to_pwd() {
	printf "\033]0;%s\a" "zsh: ${PWD/#$HOME/~}"
}

_change_title_to_program() {
	printf "\033]0;%s\a" "$1"
}

precmd_functions+=(_change_title_to_pwd)
preexec_functions+=(_change_title_to_program)

########## Completion ##########

autoload -U compinit
zmodload zsh/complist
zstyle ':completion:*' menu select			# Use menu select unconditionally
#zstyle ':completion:*' rehash true			# Update hash every call
zstyle ':completion:*' matcher-list \
	'm:{a-zA-Z}={A-Za-z}' \
	'r:|=*' 'l:|=* r:|=*'					# Match specification
zstyle ':completion:*' special-dirs true	# Allow completion for special dirs
unsetopt COMPLETE_ALIASES					# Expand aliases before attempting completion
compinit									# Initialize completion

# Prevent using yay for full system upgrades (no useful pacman logs in /var/log)
yay() {
    local IS_SYNC="n"
    local IS_SYSUPGRADE="n"
    local IS_AUR_LIMITED="n"

    # Parse options
    for word in "$@"; do
        if [ "${word:0:1}" = "-" ]; then
            if [ "${word:1:1}" != "-" ]; then
                # Single dash option(s)
                printf "%s" "$word" | grep 'S' >/dev/null && IS_SYNC="y"
                printf "%s" "$word" | grep 'u' >/dev/null && IS_SYSUPGRADE="y"
                printf "%s" "$word" | grep 'a' >/dev/null && IS_AUR_LIMITED="y"
            else
                # Double dash option
                [ "$word" = "--sync" ] && IS_SYNC="y"
                [ "$word" = "--sysupgrade" ] && IS_SYSUPGRADE="y"
                [ "$word" = "--aur" ] && IS_AUR_LIMITED="y"
            fi
        fi
    done

    # Decide whether to allow
    if [ "$IS_SYNC" = "y" ] && [ "$IS_SYSUPGRADE" = "y" ] && [ "$IS_AUR_LIMITED" = "n" ]; then
        printf " \033[31;1m*\033[0;1m DO NOT USE \`yay\` FOR SYSTEM UPGRADES\033[0m\n"
    else
        command yay "$@"
    fi
}
