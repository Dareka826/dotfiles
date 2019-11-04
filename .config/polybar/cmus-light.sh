#! /bin/sh

foreground="#FFFFFF"
cmusCol="#222222"

QUERY="$(cmus-remote -Q)"

TITLE=`echo "$QUERY" | awk '$1 == "tag" && $2 == "title" { for(i = 3; i < NF; i = i+1) printf("%s ", $i); printf $NF }'`

if [ "$TITLE" = "" ]
then
	TITLE=`echo "$QUERY" | awk '$1 == "file" { print $0 }' | perl -pe "s|file .*/(.*?)$|\1|g"`
fi

DURATION=`echo "$QUERY" | awk '$1 == "duration" { print $2 }'`
POSITION=`echo "$QUERY" | awk '$1 == "position" { print $2 }'`
LEFT=`echo "$DURATION-$POSITION" | bc`

DUR=`date -d@$DURATION -u +%H:%M:%S`
LEF=`date -d@$LEFT -u +%H:%M:%S`

printf "%s" "%{F$cmusCol}%{F$foreground B$cmusCol} $TITLE | -$LEF/$DUR "

