#! /bin/sh

QUERY="$(cmus-remote -Q)"

TITLE=`echo "$QUERY" | awk '$1 == "tag" && $2 == "title" { for(i = 3; i < NF; i = i+1) printf("%s ", $i); printf $NF }'`

if [ "$TITLE" = "" ]
then
	NTITLE=`cmus-remote -Q | awk '$1 == "file" { print $0 }' | perl -pe "s|file .*/(.*?)$|\1|g"`
else
	ALBUM=`echo "$QUERY" | awk '$1 == "tag" && $2 == "album" { for(i = 3; i < NF; i = i+1) printf("%s ", $i); printf $NF }'`
	ARTIST=`echo "$QUERY" | awk '$1 == "tag" && $2 == "artist" { for(i = 3; i < NF; i = i+1) printf("%s ", $i); printf $NF }'`
	
	NTITLE="$ARTIST - $TITLE - $ALBUM"
fi

STATUS=`echo "$QUERY" | awk '$1 == "status" { print $2 }'`
DURATION=`echo "$QUERY" | awk '$1 == "duration" { print $2 }'`
POSITION=`echo "$QUERY" | awk '$1 == "position" { print $2 }'`
LEFT=`echo "$DURATION-$POSITION" | bc`

DUR=`date -d@$DURATION -u +%H:%M:%S`
POS=`date -d@$POSITION -u +%H:%M:%S`
LEF=`date -d@$LEFT -u +%H:%M:%S`

printf "%s" "%{F$cmusCol}%{F$foreground B$cmusCol} $STATUS | $NTITLE | -$LEF/$DUR | $POS "

