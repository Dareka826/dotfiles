#! /bin/sh

i3lock \
	-i ~/Wallpapers/lockscreen1.png \
	--indicator \
	--force-clock \
\
	--ringvercolor=222222ff \
	--ringwrongcolor=ff6600ff \
	--ringcolor=ff22aaff \
\
	--keyhlcolor=66ff00ff \
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
	--indpos="20+r:h-r-20" \
	--timepos="w-25:h-55" \
	--datepos="tx:ty+30" \
\
	--timecolor=66ff00ff \
	--datecolor=ff22aaff \
\
	--datestr="%A %m/%Y" \
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

