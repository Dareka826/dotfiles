#!/bin/sh

cmus-remote -Q | awk '
$1=="duration" { dur = $2 }
$1=="position" { pos = $2 }
function stohms(t) {
	s = t%60
	m = ((t-s)/60)%60
	h = (t-m*60-s)/3600
	if(h<10) h = "0"h
	if(m<10) m = "0"m
	if(s<10) s = "0"s
	return h ":" m ":" s
}
END {
	if(dur!=0)
	{
		lef = dur-pos
		printf(" -%s/%s ", stohms(lef), stohms(dur))
	}
	else
		printf(" --:--:--/--:--:-- ")
}'
