#!/bin/sh

notify-send "Controller battery:" "$(cat /sys/class/power_supply/*sony_controller_battery*/capacity)%"

