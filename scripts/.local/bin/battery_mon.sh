#!/bin/sh

# Settings
BAT_LOW="20"
BAT_VERY_LOW="10"
BAT_CRITICAL="5"
PROG_NAME="Battery Monitor"

# Program
BAT="$(cat /sys/class/power_supply/BAT0/capacity)"

while true; do
    LAST_BAT="$BAT"
    BAT="$(cat /sys/class/power_supply/BAT0/capacity)"

    if [ "$LAST_BAT" -gt "$BAT" ]; then
        # If the charge level lowered

        if   [ "$BAT" -le "$BAT_CRITICAL" ]; then
            notify-send -u critical "$PROG_NAME" "BATTERY CRITICAL: ${BAT}%"
        elif [ "$BAT" -le "$BAT_VERY_LOW" ]; then
            notify-send -u critical "$PROG_NAME" "BATTERY VERY LOW: ${BAT}%"
        elif [ "$BAT" -le "$BAT_LOW" ]; then
            notify-send -u critical "$PROG_NAME" "Battery low: ${BAT}%"
        fi
    fi

    sleep 10
done
