#! /bin/sh

i3lock \
	-i ~/Wallpapers/lockscreen1.png \
	--indicator \
	--force-clock \
\
	--ringvercolor=222222ff \
	--ringwrongcolor=ff6633ff \
	--ringcolor=6633ffff \
\
	--keyhlcolor=ff6633ff \
	--bshlcolor=ff6633ff \
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
	--timecolor=ff6633ff \
	--datecolor=ff6633ff \
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

