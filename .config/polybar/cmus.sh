#! /bin/sh

QUERY="$(cmus-remote -C status)"

if [ "$QUERY" = "" ]
then
	printf "%s" "%{B#444444} cmus off %{B#222222} --:--:--/--:--:-- "
else
	TITLE=`echo "$QUERY" | awk '$1 == "file" { print $0 }' | perl -pe "s|file .*/(.*?)$|\1|g"`
	if [ "$TITLE" == "" ]
	then
		printf "%s" "%{B#444444} cmus off %{B#222222} --:--:--/--:--:-- "
	else
		TITLE=`echo "$QUERY" | awk '$1 == "tag" && $2 == "title" { for(i = 3; i < NF; i = i+1) printf("%s ", $i); printf $NF }'`
		
		TRACK=`echo "$QUERY" | awk '$1 == "tag" && $2 == "tracknumber" { print $3 }'`
		if [ "$TRACK" = "" ]
		then
			TRACK="?"
		fi
		TRACK=$TRACK.
		
		if [ "$TITLE" = "" ]
		then
			TITLE=`echo "$QUERY" | awk '$1 == "file" { print $0 }' | perl -pe "s|file .*/(.*?)$|\1|g"`
		fi
		
		DURATION=`echo "$QUERY" | awk '$1 == "duration" { print $2 }'`
		POSITION=`echo "$QUERY" | awk '$1 == "position" { print $2 }'`
		LEFT=`echo "$DURATION-$POSITION" | bc`
		
		DUR=`date -d@$DURATION -u +%H:%M:%S`
		LEF=`date -d@$LEFT -u +%H:%M:%S`
		
		printf "%s" "%{B#444444} $TRACK $TITLE %{B#222222} -$LEF/$DUR "
	fi
fi

