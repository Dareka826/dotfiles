batCap="$(cat /sys/class/power_supply/BAT1/capacity)"
batStat="$(cat /sys/class/power_supply/BAT1/status)"

printf "%s" "%{F${batCol}}$sep_left%{F${foreground} B${batCol}} BAT: "

if [ $batStat == "Charging" ]
then
    printf "+"
else
    if [ $batStat == "Discharging" ]
    then
        printf "-"
    fi
fi

printf "%s" "$batCap%% "
