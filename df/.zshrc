# Rin's .zshrc

# ===========
# = History =
# ===========

HISTFILE=~/.zsh_history			# History file
HISTSIZE=10000					# Max lines in history file
SAVEHIST=$HISTSIZE				# Max history lines appended by a single shell
setopt INC_APPEND_HISTORY		# Don't wait for exit to write history
setopt HIST_IGNORE_ALL_DUPS		# Remove older duplicates
setopt HIST_IGNORE_SPACE		# Remove lines that start with a space
setopt HIST_VERIFY				# Confirm after history substitution

# ==========
# = Prompt =
# ==========

setopt PROMPT_SUBST	# Enable substitution in prompt

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
	local git_branch="$(git branch --show-current)"
	[[ "${#git_branch}" -gt 24 ]] && \
		git_branch="${git_branch:0:21}..."
	echo -n " ${git_branch:-no branch}"

	# Print + if modified/added, print - if deleted
	local git_status="$(git --no-optional-locks status --untracked-files='no' --porcelain)"
	echo "$git_status" | grep -E "^\ *D" >/dev/null && echo -n "%F{red}-"
	echo "$git_status" | grep -E "^\ *M" >/dev/null && echo -n "%F{green}+"

	# Print s if stash used
	[[ -n "$(git stash list)" ]] && echo -n "%F{yellow}s" || :
}

# Set prompt
local path_color="green"; [[ $UID -eq 0 ]] && path_color="red" # Path color based on priviledges
PROMPT='$(_prompt_user_host)%F{$path_color}$(_short_pwd)%f$(_prompt_git)%f%(0?.. %F{red}%?%f )%(!.#.>) '

# ===============
# = Keybindings =
# ===============

# Vim keys
bindkey -v
export KEYTIMEOUT=1

# History search
bindkey '^R' history-incremental-pattern-search-backward
# Line editor keys
bindkey "^?" backward-delete-char	# Backspace
bindkey '^[[3~' delete-char			# Delete
bindkey '^[[H' beginning-of-line	# Home
bindkey '^[[F' end-of-line			# End

# Edit line in vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# ==============
# = Completion =
# ==============

autoload -U compinit
zmodload zsh/complist
zstyle ':completion:*' menu select			# Use menu select unconditionally
#zstyle ':completion:*' rehash true			# Update hash every call
zstyle ':completion:*' matcher-list \
	'm:{a-zA-Z}={A-Za-z}' \
	'r:|=*' 'l:|=* r:|=*' # Match specification
zstyle ':completion:*' special-dirs true	# Allow completion for special dirs
setopt COMPLETE_ALIASES
compinit	# Initialize completion

### Cursor shape

# Change cursor shape based on insertion mode
function zle-keymap-select {
	{ [[ ${KEYMAP} = vicmd ]] || [[ $1 = 'block' ]] } && \
		echo -ne '\e[1 q' || \
	{ [[ ${KEYMAP} = main ]] || [[ ${KEYMAP} = viins ]] || \
		[[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]] } && \
		echo -ne '\e[5 q' || :
}
zle -N zle-keymap-select # Set widget

# Line init widget sets cursor to beam
zle-line-init() {
	echo -ne "\e[5 q"
}
zle -N zle-line-init # Set widget

# =======================
# = Aliases & Functions =
# =======================

# ls -> exa
alias ls="exa -F"
alias la="exa -aF"
alias ll="exa -lF"
alias  l="exa -halF"

# Mkdir shortcut, rm and mv confirmation
alias md="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"

# Directory aliases
alias ce="cd /mnt/drive_e"
alias cm="cd /mnt/drive_e/Music"
alias ct="cd /mnt/drive_e/_T"
alias cc="cd ~/.config"
alias cb="cd ~/.local/bin"
alias cr="cd /mnt/drive_e/repos"
alias ca="cd /mnt/drive_e/a"
alias cs="cd /mnt/drive_e/src"
alias cg="cd /mnt/drive_e/Games"
alias csc="cd /mnt/drive_e/_school"

# Git aliases
alias  g="git"
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gl="git log"
alias gp="git push"

# Aliases
alias clo="curl -L -O"
alias ytd="youtube-dl --embed-thumbnail"
alias ytdx="youtube-dl -x"
alias aria2t="aria2c --max-upload-limit=1 --max-overall-upload-limit=1 --seed-time=0"
alias mpva="mpv --video=no"
alias mgg="mega-get --ignore-quota-warn"
# Quick vim and ranger shortcuts
alias v="nvim"
alias r="ranger"
# Dvtm change default modifier to ctrl+a
alias dvtm="dvtm -m ^a"

# Rename all opus files in directory according to their metadata
otr() {
	for o in *.opus; do
		taffy --rename-fs "%N. %R - %T" "$o"
	done
}

# Convert all files passed as arguments to opus
cto() {
	for f in "$@"; do
		ffmpeg -i "$f" -c:a libopus -b:a 128k \
			"$(echo "$f" | rev | cut -d'.' -f2- | rev).opus"
	done
}

# Rename file with taffy according to metadata
alias trfs="taffy --rename-fs \"%R - %T\""

# Xournal++ different system theme
alias xournalpp="XDG_CONFIG_HOME=/home/$USER/.xournalpp/theme /usr/bin/xournalpp"

# Time program
_gnu_time() {
	/usr/bin/time -f"%e real\t%U user\t%S sys" "$@"
}
alias time="_gnu_time" # Override time keyword

# ===========
# = Plugins =
# ===========

source ~/.zinit/bin/zinit.zsh

zinit ice lucid wait'!0c' atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait'!0b'
zinit light zsh-users/zsh-syntax-highlighting

zinit ice lucid wait'0a' \
	atload"bindkey '^[[A' history-substring-search-up" \
	atload"bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

zinit ice lucid wait'0a'
zinit light MichaelAquilina/zsh-you-should-use

