# Rin's .zshrc

## Env {{{

#unset LD_LIBRARY_PATH

# Use nvim as the pager for man
export MANPAGER='nvim +Man!'

## }}}

## History {{{

export HISTFILE="${HOME}/.zsh_history" # History file
export HISTSIZE=10000000        # Max lines in history file
export SAVEHIST="${HISTSIZE}"   # Max history lines appended by a single shell
setopt INC_APPEND_HISTORY       # Don't wait for exit to write history
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicates
setopt HIST_IGNORE_SPACE        # Remove lines that start with a space
setopt HIST_VERIFY              # Confirm after history substitution
setopt INTERACTIVE_COMMENTS     # Allow comments in interactive mode

## }}}

## Prompt {{{

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
    printf "%s" "${(j:/:)pwd}"
}

# Don't display username and hostname if not over ssh
_prompt_user_host() {
    [[ -n "${SSH_CLIENT}" ]] && printf "%s" "%n@%m " || :
}

# Git status in prompt
_prompt_git() {
    # Print nothing and return if not in a working tree
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    # Print branch (shorten if over 14 chars long)
    local git_branch="$(git branch --show-current 2>/dev/null)"
    [ "${#git_branch}" -gt 24 ] && \
        git_branch="${git_branch:0:21}..."

    # If no branch, print the latest commit hash
    [ -z "${git_branch}" ] && \
        git_branch="$(git rev-parse --short HEAD)"
    printf " %s" "${git_branch}"

    # Print + if modified/added, print - if deleted
    local git_status="$(timeout -s KILL 0.2s git --no-optional-locks status --porcelain 2>/dev/null || printf '%s' "KILLED")"
    if printf '%s' "${git_status}" | grep -Fx "KILLED" >/dev/null 2>&1; then
        printf "%s" "%F{magenta}X"
    else
        printf "%s" "${git_status}" | grep -E '^ *\?' >/dev/null && printf "%s" "%F{cyan}?"
        printf "%s" "${git_status}" | grep -E '^ *D'  >/dev/null && printf "%s" "%F{red}-"
        printf "%s" "${git_status}" | grep -E '^ *M'  >/dev/null && printf "%s" "%F{green}+"
        printf "%s" "${git_status}" | grep -E '^ *A'  >/dev/null && printf "%s" "%F{yellow}+"
    fi

    # Git bisect
    git bisect log >/dev/null 2>&1 && printf "%s" "%F{yellow}B"

    ## git-bug integration
    #command -v git-bug >/dev/null && {
    #    [ "$(git-bug ls -s open 2>/dev/null | wc -l)" -gt 0 ] && printf "%s" "%F{yellow}#"
    #}

    # Print * if stash in use
    [[ -n "$(git stash list 2>/dev/null)" ]] && printf "%s" "%F{yellow}*" || :
}

# Set prompt
local path_color="green"; [[ $UID -eq 0 ]] && path_color="red" # Path color based on priviledges
PROMPT='$(_prompt_user_host)%F{$path_color}$(_short_pwd)%f$(_prompt_git)%f%(0?.. %F{red}%?%f)%(!.#.>) '

## }}}

## Keybindings {{{

# Vim keys
bindkey -v
export KEYTIMEOUT=1

bindkey '^R'    history-incremental-pattern-search-backward # History search
bindkey '^[[D'  backward-char                               # Left
bindkey '^[[C'  forward-char                                # Right
bindkey '^?'    backward-delete-char                        # Backspace
bindkey '^[[3~' delete-char                                 # Delete
bindkey '^[[H'  beginning-of-line                           # Home
bindkey '^[[1~' beginning-of-line                           # Home
bindkey '^[[F'  end-of-line                                 # End
bindkey '^[[4~' end-of-line                                 # End
bindkey '^[[Z'  reverse-menu-complete                       # Shift-Tab
bindkey '^[[5~' beginning-of-buffer-or-history              # PageUp
bindkey '^[[6~' end-of-buffer-or-history                    # PageDown

# Edit line in vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

## }}}

## Cursor shape {{{

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

## }}}

## Aliases & Functions {{{

# doas, sudo alias expansion
alias doas="doas "
alias sudo="sudo "

# ls -> exa
LSPROG="ls"
LSOPTS="--color=auto"
command -v exa >/dev/null && {
    LSPROG="exa"
    LSOPTS="-gb"
}

alias ls="$LSPROG $LSOPTS"
alias ll="$LSPROG $LSOPTS -hla"
alias  l="$LSPROG $LSOPTS -hl"

# Mkdir shortcut, rm and mv confirmation
alias md="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"

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
alias   gla="git log --all"
alias  gloa="git log --oneline --all"
alias gloag="git log --oneline --all --graph"
alias   glp="git log --patch"
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

# Command aliases
alias clo="curl -LO"
alias f="vifm"

# Program aliases
[ -f $ZDOTDIR/program_aliases.zsh ] && \
    source $ZDOTDIR/program_aliases.zsh

# Vinfo / info alias
alias info="info --vi-keys"
vinfo() { nvim -c "Vinfo $1" -c "silent only" }
command -v nvim >/dev/null && alias info="vinfo"

# Vim shortcuts
alias v="nvim"

# GPG entry
GPG_TTY=$(tty)
export GPG_TTY

[ -f $ZDOTDIR/functions.zsh ] && \
    source $ZDOTDIR/functions.zsh

## }}}

## Plugins {{{

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

## }}}

## FZF {{{

[ -f "/usr/share/fzf/completion.zsh" ] && \
    . "/usr/share/fzf/completion.zsh"

[ -f "/usr/share/fzf/key-bindings.zsh" ] && \
    . "/usr/share/fzf/key-bindings.zsh"

# cd without alt CTRL-N for navigate
bindkey -M vicmd '^N' fzf-cd-widget
bindkey -M viins '^N' fzf-cd-widget

## }}}

## Dynamic window title {{{

_change_title_to_pwd() {
    printf "\033]0;%s\a" "zsh: ${PWD/#$HOME/~}"
}

_change_title_to_program() {
    printf "\033]0;%s\a" "$1"
}

precmd_functions+=(_change_title_to_pwd)
preexec_functions+=(_change_title_to_program)

## }}}

## Completion {{{

autoload -U compinit
zmodload zsh/complist
zstyle ':completion:*' menu select          # Use menu select unconditionally
#zstyle ':completion:*' rehash true         # Update hash every call
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|=*' 'l:|=* r:|=*'                   # Match specification
#zstyle ':completion:*' special-dirs true    # Allow completion for special dirs
unsetopt COMPLETE_ALIASES                   # Expand aliases before attempting completion
compinit                                    # Initialize completion

## }}}

