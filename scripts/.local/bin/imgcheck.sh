#!/bin/sh
set -eu

IM_PROG="magick"
command -v magick >/dev/null 2>&1 || \
    IM_PROG="convert"
command -v convert >/dev/null 2>&1 || \
    exit 100

for IMG_FILE in "$@"; do
    [ -e "${IMG_FILE}" ] || continue

    if "${IM_PROG}" "${IMG_FILE}" null:-; then
        printf "OK: %s\n" "${IMG_FILE}"
    else
        printf "ERR: %s\n" "${IMG_FILE}"
    fi
done
