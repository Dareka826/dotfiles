#!/bin/sh
# For Nix on Nvidia
#unset LD_LIBRARY_PATH

# Env {{{
# Fcitx
#export GTK_IM_MODULE="fcitx"
#export QT_IM_MODULE="fcitx"
#export SDL_IM_MODULE="fcitx"
#export XMODIFIERS="@im=fcitx"

# Qt style
#export QT_QPA_PLATFORMTHEME="qt5ct"

# Path
export PATH="${PATH}:${HOME}/.local/bin"

export GOPATH="${HOME}/.go"
export PATH="${PATH}:${GOPATH}/bin"

# Rust
[ -n "${CARGO_HOME}" ] || CARGO_HOME="${HOME}/.cargo"
[ -f "${CARGO_HOME}/env" ] && \
    . "${CARGO_HOME}/env"

# Wayland gtk theme
export GTK_THEME="Materia-dark-compact"

# Config for bemenu
export BEMENU_OPTS="-i -l 10 -p '' --tb '#6600ff' --tf '#ffffff' --fb '#111111' --ff '#ffffff' --cb '#111111' --cf '#ffffff' --nb '#111111' --nf '#ffffff' --hb '#6600ff' --hf '#ffffff' --sb '#222222' --sf '#ffffff'"

# Fix java apps
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender=true"

export XKB_DEFAULT_OPTIONS="caps:backspace,compose:menu"

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="foot"
export BROWSER="firefox-esr"
export VIDEO="mpv"
export IMAGE="nsxiv"
export PAGER="less"
export WM="sway"

# Diff
export DIFFPROG="nvim -d"

# FZF
export FZF_DEFAULT_OPTS="--preview-window=right:50%:sharp"

# KVM
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Lynx colors
#export LYNX_LSS="${HOME}/.config/lynx/lynx.lss"

# Use nvim for man pages
export MANPAGER='nvim +Man!'

# Disable less history
export LESSHISTFILE=-

# Colors in less
LESS_TERMCAP_md=$'\e[34m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[0;41m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[0;36m'
# }}}

# History {{{
export HISTFILE="${HOME}/.bash_history"
export HISTCONTROL=ignorespace
export HISTSIZE=100000
export HISTILESIZE=100000
shopt -s histappend
shopt -s histreedit
shopt -s histverify
# }}}

# Vi mode {{{
set -o vi
bind -m vi-command '"\C-l": clear-screen'
bind -m vi-insert  '"\C-l": clear-screen'
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "[I]"'
bind 'set vi-cmd-mode-string "[N]"'
# }}}

# Completion {{{
bind 'set completion-ignore-case on'
bind 'set show-all-if-unmodified on'
bind 'set skip-completed-text on'
bind 'set completion-query-items 0'
bind 'set colored-stats on'
bind 'set visible-stats on'

bind -m vi-insert '"\C-g": glob-list-expansions'
bind -m vi-insert '"\C-x": glob-expand-word'
# }}}

# FZF {{{
[ -f /usr/share/fzf/key-bindings.bash ] && {
    . /usr/share/fzf/key-bindings.bash
    bind -m vi-command '"\C-n": "\C-z\ec\C-z"'
    bind -m vi-insert  '"\C-n": "\C-z\ec\C-z"'
}
# }}}

# ls -> exa {{{
LSPROG="ls"
LSOPTS="-F"
command -v exa >/dev/null && {
    LSPROG="exa"
    LSOPTS="-bgF"
}

alias ls="$LSPROG $LSOPTS"
alias la="$LSPROG $LSOPTS -a"
alias ll="$LSPROG $LSOPTS -l"
alias  l="$LSPROG $LSOPTS -hal"
# }}}

# Aliases / functions
alias  md="mkdir -p"
alias  mv="mv -i"
alias  rm="rm -i"
alias rmn="rm"
alias mvv="mv -v"

# curl
clo()  { curl -LO "${@}"; }
cloa() {
    for URL in "$@"; do
        clo "${URL}"
    done
}

alias v="nvim"
alias f="vifm"

alias pac="pacman"

# yt-dlp / youtube-dl {{{
_ytd() {
    local YTD
    YTD="$(command -v yt-dlp)"
    [ -n "${YTD}" ] || YTD="$(command -v youtube-dl)"
    [ -n "${YTD}" ] || {
        printf "Neither yt-dlp nor youtube-dl found!\n"
        return
    }

    "${YTD}" --no-mtime \
             --write-info-json \
             -o "[%(webpage_url_domain)s]_[%(upload_date)s]_[%(uploader_id)s]_[%(id)s]_%(title)s.%(ext)s" \
             "${@}"
}
ytd()  { _ytd --embed-thumbnail "${@}"; }
ytdx() { _ytd -x -f 'bestaudio[acodec=opus]/best[acodec=opus]/bestaudio/best' "${@}"; }
# }}}

info() { command info "${@}" | nvim -R -; }

_gdl() {
    gallery-dl --sleep 1 \
               --write-metadata \
               "${@}"
}
gdl()  { _gdl --ugoira-conv-lossless "${@}"; }
gdln() { _gdl --ugoira-conv "${@}"; }

# doas, sudo alias expansion
alias doas="doas "
alias sudo="sudo "

mounts() {
    mount | \
        sed 's/\t/ /;s/^\(.*\) on \(.*\) type \(.*\) (\(.*\))$/\2\t->\t\1\t:\t\3\t[\4]/' | \
        column -t -s$'\t'
}

tmux() { command tmux -S "${HOME}/.tmux-socket"; }

# Git {{{
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
# }}}

# Additional config files
if [ -d ~/.config/bash.d ] && stat -t ~/.config/bash.d/*.sh >/dev/null 2>&1; then
    for conf_file in ~/.config/bash.d/*.sh; do
        . "${conf_file}"
    done
fi

## PROMPT {{{
# Shorten current path
_short_pwd() {
    # Make the home display as '~'
    local CUSTOM_PWD="$(pwd | sed "s|^${HOME}|~|")"

    # Shorten all parent directories' names to one letter
    local SHORT_PATH="$(printf "%s" "${CUSTOM_PWD}" | sed 's|\(\.\?[^./]\)[^/]\+/|\1/|g')"

    printf "%s" "${SHORT_PATH}"
}

# Don't display username and hostname if not over ssh
_prompt_user_host() {
    [ -n "${SSH_CLIENT}" ] && printf "%s " "\u@\h" || :
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
    local git_status="$(git --no-optional-locks status --porcelain 2>/dev/null)"
    printf "%s" "${git_status}" | grep -E '^ *\?' >/dev/null && printf "\033[36m?"
    printf "%s" "${git_status}" | grep -E '^ *D'  >/dev/null && printf "\033[31m-"
    printf "%s" "${git_status}" | grep -E '^ *M'  >/dev/null && printf "\033[32m+"
    printf "%s" "${git_status}" | grep -E '^ *A'  >/dev/null && printf "\033[33m+"

    # Git bisect
    git bisect log >/dev/null 2>&1 && printf "\033[33mB"

    # git-bug integration
    command -v git-bug >/dev/null && {
        [ "$(git-bug ls -s open 2>/dev/null | wc -l)" -gt 0 ] && printf "\033[33m#"
    }

    # Print * if stash in use
    [ -n "$(git stash list 2>/dev/null)" ] && printf "\033[33m*" || :
}

bash_prompt_command() {
    local SHORT_PWD="$(_short_pwd)"
    local PROMPT_USER="$(_prompt_user_host)"
    local PROMPT_GIT="$(_prompt_git)"

    # Privilege symbol + path color
    local PS_SYMBOL=">"
    local PATH_COLOR="\033[33m"
    [ "$(id -u)" = "0" ] && {
        local PS_SYMBOL="#"
        local PATH_COLOR="\033[31m"
    }

    # Update the prompt
    PS1=" ${PROMPT_USER}\[${PATH_COLOR}\]${SHORT_PWD}\[\033[0m\]${PROMPT_GIT}\[\033[0m\]${PS_SYMBOL} "
}

PROMPT_COMMAND="history -a; history -c; history -r; bash_prompt_command"
# }}}
