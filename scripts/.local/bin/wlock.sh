#!/bin/sh

# Make notifications invisible
makoctl mode -a locked

#waylock -init-color '0x000000' -input-color '0x7755ff' -fail-color '0xff7733'
swaylock --color 000000 -e -f

# Make notifications visible again
makoctl mode -r locked
