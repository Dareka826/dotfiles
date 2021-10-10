#!/bin/sh

[ $TERM = "linux" ] || exit 0

printf '\033]P0111111
        \033]P8444444
        \033]P1ff0066
        \033]P9ff0066
        \033]P200ff66
        \033]PA00ff66
        \033]P3ff6600
        \033]PBff6600
        \033]P40066ff
        \033]PC0066ff
        \033]P56600ff
        \033]PD6600ff
        \033]P633eecc
        \033]PE33eecc
        \033]P7888888
        \033]PFffffff
        \033c'
