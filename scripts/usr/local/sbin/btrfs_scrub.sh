#!/bin/sh
set -eu

MOUNT_POINT="${1}"
[ -n "${MOUNT_POINT}" ] || exit 1
[ -d "${MOUNT_POINT}" ] || exit 1
shift 1

SNOOZE_ARGS="$(printf "%s " "$@" | sed 's/ \+$//')"
[ -n "${SNOOZE_ARGS}" ] || exit 1

TIMEFILE_ID="$(printf "%s %s" "${MOUNT_POINT}" "${SNOOZE_ARGS}" | md5sum | awk '{print $1}')"
TIMEFILE_PATH="/var/snooze/btrfs_scrub_${TIMEFILE_ID}_timefile"

printf "[I]: Trying to cancel scrub on %s...\n" "${MOUNT_POINT}"
btrfs scrub cancel "${MOUNT_POINT}" >/dev/null 2>&1 || :

printf "[I]: Trying to resume scrub on %s...\n" "${MOUNT_POINT}"
SCRUB_EXIT="0"
SCRUB_LOG="$(set +e; nice -n 10 btrfs scrub resume -c 3 -d -B "${MOUNT_POINT}" 2>&1)" || SCRUB_EXIT="$?"

if [ "${SCRUB_EXIT}" = "2" ]; then
    # There was nothing to resume
    printf "[I]: Waiting to start a new scrub on %s...\n" "${MOUNT_POINT}"
    snooze -t "${TIMEFILE_PATH}" "${SNOOZE_ARGS}"

    printf "[I]: Starting a new scrub on %s...\n" "${MOUNT_POINT}"
    SCRUB_EXIT="0"
    SCRUB_LOG="$(set +e; nice -n 10 btrfs scrub start -c 3 -B "${MOUNT_POINT}" 2>&1)" || SCRUB_EXIT="$?"
fi

printf "[I]: Scrub on %s finished with exit code: %s\n" "${MOUNT_POINT}" "${SCRUB_EXIT}"

# Check for errors
if [ "${SCRUB_EXIT}" != "0" ]; then
    printf "${SCRUB_LOG}\n" | mailx -s "BTRFS Scrub Error" root rin
fi

printf "[I]: Updating timefile...\n"
# Might be touched if scrub was aborted, but we try to resume every time,
# so it shouldn't matter
[ -d "/var/snooze" ] || mkdir -p "/var/snooze"
touch "${TIMEFILE_PATH}"
