#!/bin/sh
set -eu

BTRFS_PATH="${1}"
[ -n "${BTRFS_PATH}" ] || exit 1

shift 1
SNOOZE_ARGS="${@}"
[ -n "${SNOOZE_ARGS}" ] || exit 1

TIMEFILE_ID="$(printf "%s %s" "${BTRFS_PATH}" "${SNOOZE_ARGS}" | md5sum | awk '{print $1}')"
TIMEFILE_PATH="/var/snooze/btrfs_scrub_${TIMEFILE_ID}_timefile"

SCRUB_STATUS="$(btrfs scrub status "${BTRFS_PATH}" | grep '^Status' | awk '{print $2}')"
SCRUB_LOG=""
SCRUB_EXIT=""

printf "[I]: Checking for a running scrub on %s...\n" "${BTRFS_PATH}"
if [ "${SCRUB_STATUS}" = "running" ]; then
    # Abort and resume to know when it ends
    printf "[I]: Found a running scrub on %s, attaching...\n" "${BTRFS_PATH}"
    btrfs scrub cancel "${BTRFS_PATH}"
    SCRUB_LOG="$(nice -n 10 btrfs scrub resume -c 3 -B "${BTRFS_PATH}" 2>&1)"
    SCRUB_EXIT="$?"
else
    printf "[I]: Checking for an aborted scrub on %s...\n" "${BTRFS_PATH}"
    if [ "${SCRUB_STATUS}" = "aborted" ]; then

        printf "[I]: Found an aborted scrub on %s, resuming...\n" "${BTRFS_PATH}"
        SCRUB_LOG="$(nice -n 10 btrfs scrub resume -c 3 -B "${BTRFS_PATH}" 2>&1)"
    SCRUB_EXIT="$?"
    else
        # Scrub not running or aborted, start a new one
        printf "[I]: Waiting to start a new scrub on %s...\n" "${BTRFS_PATH}"
        snooze -t "${TIMEFILE_PATH}" "${SNOOZE_ARGS}"

        printf "[I]: Starting a new scrub on %s...\n" "${BTRFS_PATH}"
        SCRUB_LOG="$(nice -n 10 btrfs scrub start -c 3 -B "${BTRFS_PATH}" 2>&1)"
    SCRUB_EXIT="$?"
    fi
fi
printf "[I]: Scrub on %s finished with exit code: %s\n" "${BTRFS_PATH}" "${SCRUB_EXIT}"

# Check for errors
if [ "${SCRUB_EXIT}" != "0" ]; then
    printf "${SCRUB_LOG}\n" | mailx -s "BTRFS Scrub Error" root rin
fi

# The timefile should only be updated after a scrub finishes
[ -d "/var/snooze" ] || mkdir -p "/var/snooze"
printf "[I]: Updating timefile...\n"
touch "${TIMEFILE_PATH}"
