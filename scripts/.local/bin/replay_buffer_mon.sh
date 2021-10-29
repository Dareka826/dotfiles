#!/bin/bash
set -uo > /dev/null

# Config
BUFFERS_PATH="/mnt/ID/OBS_Videos" ## DO NOT INCLUDE LAST SLASH
BUFFERS_PREFIX="Replay_"
BUFFERS_SUFFIX=""

# Send a notification every time a new replay buffer appears (just to be sure
# it was saved correctly)

list_buffers() {
    # List all files in BUFFERS_PATH beginning with BUFFERS_PREFIX and ending
    # with BUFFERS_SUFFIX then remove the leading BUFFERS_PATH by counting its
    # length and stripping that many characters from the beginning
    ls "${BUFFERS_PATH}/${BUFFERS_PREFIX}"*"${BUFFERS_SUFFIX}" | \
        cut -c "$(($(echo "${BUFFERS_PATH}" | wc -m) + 1))-"
}

check_buffer_count() {
    BUFFER_COUNT_NEW=$(list_buffers | wc -l)

    [ $BUFFER_COUNT -lt $BUFFER_COUNT_NEW ] && {
        # Notify about all the new buffers
        BUFFERS_NEW="$(comm -13 <(echo "$BUFFERS_LAST" | sort) <(list_buffers | sort))"

        while IFS=$'\n' read; do
            notify-send "New buffer: ${REPLY}"
        done <<< "$BUFFERS_NEW"

        BUFFERS_LAST=$BUFFERS_NEW
    }
    # Don't do anything if a buffer was removed

    BUFFER_COUNT=$BUFFER_COUNT_NEW
}

# Initialize variables
BUFFERS_LAST="$(list_buffers)"
BUFFER_COUNT=$(list_buffers | wc -l)

# Main loop
while true; do
    check_buffer_count
    sleep 1
done
