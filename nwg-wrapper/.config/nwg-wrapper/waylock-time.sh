#!/bin/sh

FONT="Source Code Pro"
SMALL_TEXT="15000"
LARGE_TEXT="30000"

date_raw="$(date +'%a, %d/%m/%Y|%H:%M:%S')"
date="${date_raw%%|*}"
time="${date_raw##*|}"

printf '<span size="%s" foreground="%s" face="%s">%s</span>\n' "${LARGE_TEXT}" "#ff8952" "${FONT}" "${time}"
printf '<span size="%s" foreground="%s" face="%s">%s</span>\n' "${LARGE_TEXT}" "#ff5c9a" "${FONT}" "${time}"
printf '<span size="%s" foreground="%s" face="%s">%s</span>\n' "${LARGE_TEXT}" "#ff8ab7" "${FONT}" "${time}"
printf '<span size="%s" foreground="%s" face="%s">%s</span>\n' "${SMALL_TEXT}" "#eeeeee" "${FONT}" "${date}"
printf '<span size="%s" foreground="%s" face="%s">%s</span>\n' "${SMALL_TEXT}" "#eeeeee" "${FONT}" "$(uptime -p)"
