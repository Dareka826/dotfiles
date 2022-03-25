#!/bin/sh

command -v picom-trans >/dev/null 2>&1 || exit 1

OPACITY="$(seq 50 10 100 | dmenu -p '%:')"
[ -n "${OPACITY}" ] || exit 0

# Select a window for which to set the new opacity
picom-trans -o "${OPACITY}" -s
