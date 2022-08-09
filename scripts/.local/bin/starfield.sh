#!/bin/sh

# Much simpler version with less flexibility
# cat /dev/urandom | tr -cd '0-9a-z' | tr -c '1' ' ' | tr '1' '.' | fold -w "$(tput cols)" | head -"$(( $(tput lines) - 2 ))"

THRESHOLD=10
[ -n "$1" ] && [ "$1" -gt 0 ] && [ "$1" -le 255 ] && THRESHOLD="$1"

# Generate
cat /dev/urandom | od -An -tu1 \
    | tr -s ' ' | tr ' ' '\n' | sed '/^$/d' \
    | awk "{ if (\$1 <= ${THRESHOLD}) printf(\".\"); else printf(\" \"); }" \
    | fold -w "$(tput cols)" | head -"$(( $(tput lines) - 2 ))"
