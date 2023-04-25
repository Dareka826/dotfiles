#!/bin/sh
set -eu

for IMG_FILE in "$@"; do
    [ -e "${IMG_FILE}" ] || continue

    if convert "${IMG_FILE}" null:- 2>&1; then
        printf "OK: %s\n" "${IMG_FILE}"
    else
        printf "ERR: %s\n" "${IMG_FILE}"
    fi
done
