# Print args
p() { printf '%s\n' "${@}"; }

# Download vods
dvod() {
    if [ "${#}" = "0" ]; then
        printf "%s\n" "dvod URL OUT_FILE"
    else
        streamlink "${1}" "best" -o "${2}"
    fi
}

bell() { printf '\a'; }

# Check which program is used by xdg-open on a file
xdg-which() {
    if [ "${#}" = "0" ] || { ! [ -f "${1}" ]; }; then
        printf "%s\n" "xdg-which FILE"
    fi

    __XDG_WHICH_TYPE="$(xdg-mime query filetype "${1}")"
    __XDG_WHICH_APP="$( xdg-mime query default "${__XDG_WHICH_TYPE}")"

    printf "File: %s\n" "${1}"
    printf "Type: %s\n" "${__XDG_WHICH_TYPE}"
    printf "App:  %s\n" "${__XDG_WHICH_APP}"

    unset __XDG_WHICH_TYPE
    unset __XDG_WHICH_APP
}

# Play last replay buffer
lrb() {
    cd /mnt/IDATA/OBS_Videos
    mpv "$(p ./Replay_* | sort -r | head -1)"
}

# Display random nvim help page
v_randhelp() {
    HELP_NUM="$(cat /usr/share/nvim/runtime/doc/usr_toc.txt | tr '\t' ' ' | grep -E '^  \|[0-9]+\.[0-9]+\|' | grep -Eo '[0-9]+\.[0-9]+' | sort -R | head -1)"
    nvim --cmd "help ${HELP_NUM}" --cmd "only"
}

mounts() {
    mount | sed 's/\t/ /;s/^\(.*\) on \(.*\) type \(.*\) (\(.*\))$/\2\t->\t\1\t:\t\3\t[\4]/' | column -t -s$'\t'
}

cloa() {
    for __CLOA_URL in "${@}"; do
        curl -LO "${__CLOA_URL}"
    done
    unset __CLOA_URL
}

btrfs_sync() {
    doas /usr/local/sbin/btrfs_sync.sh "${@}"
}

# Check mail
m() {
    if LC_ALL=C mail -e; then
        p "You have new mail!"
    else
        p "No new mail."
    fi
}
