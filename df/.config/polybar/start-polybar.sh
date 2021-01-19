#!/bin/sh

sleep 1
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	MONITOR=$m polybar -c ~/.config/polybar/config.ini --reload main &
done
