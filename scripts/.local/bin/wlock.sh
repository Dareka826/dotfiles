#!/bin/sh

{ # Display time and date on lockscreen
    sleep 0.1
    nwg-wrapper \
        --layer 3 \
        --script waylock-time.sh \
        --css waylock.css \
        --refresh 1000 \
        --margin_bottom 25 \
        --margin_left   25 \
        --justify left \
        --position left \
        --alignment end \
        --sig_quit 31 # Exit on custom signal
} &
makoctl mode -a locked # Make notifications invisible

waylock --init-color '#000000' --input-color '#6633ff' --fail-color '#ff6600' || pkill river

pkill -f --signal 31 nwg-wrapper & # Kill time+date widget
makoctl mode -r locked & # Make notifications visible again
