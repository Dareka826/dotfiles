#!/bin/sh

# Make notifications invisible
makoctl mode -a locked

waylock -init-color '0x000000' -input-color '0x6633ff' -fail-color '0xff6600'

# Make notifications visible again
makoctl mode -r locked
