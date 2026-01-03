#!/bin/sh
set -eu

MAX_LEN=30

#swaymsg -t get_tree | \
#    jq '[.nodes[1].nodes[] | {name,representation}]'

# Get the layout for current workspace and collapse the program names into ...
STR="$(\
    swaymsg -t get_workspaces 2>/dev/null | \
        jq -r '.[] | select(.focused == true) | .representation' | \
        sed -e 's/[A-Z]\[/\n&\n/g' \
            -e 's/]/\n]\n/g' | \
        sed -e '/^\s*$/d' \
            -e '/^[^][]\+$/ s/^.*$/... /' | \
        tr -d '\n' | \
        sed 's/\. \]/.]/g' 2>/dev/null)"

if [ "$(printf "%s" "${STR}" | wc -m)" -gt "${MAX_LEN}" ]; then
    printf "%s…\n" "$(printf "%s" "${STR}" | fold -w"$((MAX_LEN - 1))" | head -1)"
else
    printf "%s\n" "${STR}"
fi
