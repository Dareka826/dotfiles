#!/bin/sh

i3lock \
	-i ~/Wallpapers/lockscreen2.png \
	--indicator \
	--force-clock \
	-S 0 \
\
	--ringver-color=222222ff \
	--ringwrong-color=EE99BB \
	--ring-color=DD5588FF \
\
	--keyhl-color=FFFFFFFF \
	--bshl-color=111111ff \
\
	--insidever-color=00000000 \
	--insidewrong-color=00000000 \
	--inside-color=00000000 \
\
	--line-color=00000000 \
	--separator-color=00000000 \
\
	--verif-color=00000000 \
	--wrong-color=00000000 \
\
	--time-color=DD5588FF \
	--date-color=FF22AAFF \
\
	--date-str="%A %d/%m/%Y" \
\
	--time-align 2 \
	--date-align 2 \
\
	--time-font="Source Code Pro"\
	--date-font="Source Code Pro" \
\
	--time-size=80 \
	--date-size=15 \
\
	--radius 50 \
	--ring-width 15 \
\
	--ind-pos="x+r+20:y+h-r-20" \
	--time-pos="x+w-25:y+h-55" \
	--date-pos="tx:ty+30" \
\
	--verif-text="" \
	--wrong-text="" \
	--noinput-text="" \
	--lock-text="" \
	--lockfailed-text="" || i3lock || pkill -KILL Xorg
