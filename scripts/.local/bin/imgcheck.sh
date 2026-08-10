#!/bin/sh
set -eu

IM_PROG=""

if command -v magick >/dev/null 2>&1; then
    IM_PROG="magick identify"
elif command -v identify >/dev/null 2>&1; then
    IM_PROG="dentify"
else
    printf '%s\n' "[E]: Neither \`magick' nor \`identify' programs found!" >&2
    exit 100
fi

for IMG_FILE in "$@"; do
    if ! [ -e "${IMG_FILE}" ]; then
        printf '%s\n' "[W]: Skipping \`${IMG_FILE}' as it does not exist" >&2
        continue
    fi

    if ${IM_PROG} -regard-warnings -format '' "${IMG_FILE}" 2>&1; then
        printf "[OK ]: %s\n" "${IMG_FILE}"
    else
        printf "[ERR]: %s\n" "${IMG_FILE}"
    fi
done
