foreground="#FFFFFF"
mpdCol="#222222" #MPD Color

cur=$(mpc current 2>/dev/null)

if [ "$cur" == "" ]
then
    cur="MPD OFF"
fi

printf "%s" "%{F${mpdCol}}%{F${foreground} B${mpdCol}} ${cur} "
