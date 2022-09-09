#!/bin/sh

i3lock \
    --color=000000ff \
    --force-clock \
\
    --ring-color=ff8ab7ff \
    --ringver-color=333333ff \
    --ringwrong-color=ff6600ff \
\
    --keyhl-color=ffffffff \
    --bshl-color=333333ff \
\
    --inside-color=00000000 \
    --insidever-color=00000000 \
    --insidewrong-color=00000000 \
\
    --line-color=00000000 \
    --separator-color=00000000 \
\
    --time-color=ff8ab7ff \
    --date-color=eeeeeeff \
\
    --date-str="%a, %d/%m/%Y" \
\
    --time-align 1 \
    --date-align 1 \
\
    --time-font="Source Code Pro"\
    --date-font="Source Code Pro" \
\
    --time-size=60 \
    --date-size=20 \
\
    --radius 50 \
    --ring-width 10 \
\
    --time-pos="x+25:y+h-55" \
    --date-pos="tx:ty+30" \
\
    --verif-text="" \
    --wrong-text="" \
    --noinput-text="" \
    --lock-text="" \
    --lockfailed-text="" || i3lock || pkill -KILL Xorg
