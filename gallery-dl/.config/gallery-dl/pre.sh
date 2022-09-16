#!/bin/sh
IFS="$(printf "\n")"

if [ "${1}" = "png" ]; then
    if [ -e "${2%png}jpg" ]; then
        # File exists, so touch a fake one
        touch "${2}"
    fi
fi
