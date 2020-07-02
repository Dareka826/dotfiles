#!/bin/sh

cat /sys/class/power_supply/*sony_controller_battery*/capacity | xargs -I{} notify-send "Controller battery:" "{}%"
