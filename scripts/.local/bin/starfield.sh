#!/bin/sh

# Much simpler version with less flexibility
# cat /dev/urandom | tr -cd '0-9a-z' | tr -c '1' ' ' | tr '1' '.' | fold -w "$(tput cols)" | head -"$(( $(tput lines) - 2 ))"

THRESHOLD=10
[ -n "$1" ] && [ "$1" -gt 0 ] && [ "$1" -le 255 ] && THRESHOLD="$1"

FIFO="$(mktemp -u)"
mkfifo -m 600 "${FIFO}"

# Generate 8-bit numbers
cat /dev/urandom | od -An -tu1 | tr -s ' ' | tr ' ' '\n' | sed '/^$/d' >"${FIFO}" &

# Consume the numbers
while read VAR; do
    [ "${VAR}" -le "${THRESHOLD}" ] \
        && printf "." \
        || printf " "

done <"${FIFO}" | fold -w "$(tput cols)" | head -"$(( $(tput lines) - 2 ))"

rm "${FIFO}"
