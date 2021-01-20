#! /bin/sh

i3lock \
	-i ~/Wallpapers/lockscreen2.png \
	--indicator \
	--force-clock \
	-S 0 \
\
	--ringvercolor=222222ff \
	--ringwrongcolor=EE99BB \
	--ringcolor=DD5588FF \
\
	--keyhlcolor=FFFFFFFF \
	--bshlcolor=111111ff \
\
	--insidevercolor=00000000 \
	--insidewrongcolor=00000000 \
	--insidecolor=00000000 \
\
	--linecolor=00000000 \
	--separatorcolor=00000000 \
\
	--verifcolor=00000000 \
	--wrongcolor=00000000 \
\
	 --indpos="x+20+r:y+h-r-20" \
	 --timepos="x+w-25:y+h-55" \
	 --datepos="tx:ty+30" \
\
	--timecolor=DD5588FF \
	--datecolor=FF22AAFF \
\
	--datestr="%A %d/%m/%Y" \
\
	--time-align 2 \
	--date-align 2 \
\
	--time-font=source-code-pro \
	--date-font=source-code-pro \
\
	--timesize=80 \
	--datesize=15 \
\
	--radius 50 \
	--ring-width 15 \
\
	--veriftext="" \
	--wrongtext="" \
	--noinputtext="" \
	--locktext="" \
	--lockfailedtext=""

