#!/bin/sh

STATUS="$(cmus-remote -C status | awk '
$1=="file" { $1=""; sub(/.*\//,""); title = $0 }
$1=="tag" && $2=="title" { sub("tag title ",""); title = $0 }
$1=="tag" && $2=="tracknumber" { tracknum = $3 }
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
        if(tracknum == 0) tracknum = "?"
        lef = dur-pos
        printf("%s. %s\342\200\255 | -%s/%s", tracknum, title, stohms(lef), stohms(dur))
    }
    else
        printf("cmus off")
}')"

if [ "$1" = "yambar-mode" ]; then
    printf "status|string|%s\n\n" "${STATUS}"
else
    printf "%s" "${STATUS}"
fi
