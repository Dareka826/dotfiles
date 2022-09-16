#!/bin/sh
IFS="$(printf "\n")"

if [ "${1}" = "png" ]; then
    # Check for a fake (size = 0)
    if [ -e "${2}" ] && [ ! -s "${2}" ]; then
        rm "${2}"
    fi
fi
