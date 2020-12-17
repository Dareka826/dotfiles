#!/bin/sh

sleep 1
polybar -c ~/.config/polybar/config-double.ini main &
sleep 1
polybar -c ~/.config/polybar/config-double.ini second &

