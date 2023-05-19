#!/bin/sh

#swaymsg -t get_tree | \
#    jq '[.nodes[1].nodes[] | {name,representation}]'

swaymsg -t get_workspaces | \
    jq -r '.[] | select(.focused == true) | .representation'
