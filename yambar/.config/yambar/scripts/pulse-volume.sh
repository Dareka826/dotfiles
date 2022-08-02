#!/bin/sh

VOLUME="$(pamixer --get-volume)"
MUTE="$(pamixer --get-mute)"

if [ "${MUTE}" = "true" ]; then
    printf "status|string|M%s%%M\n\n" "${VOLUME}"
else
    printf "status|string|%s%%\n\n" "${VOLUME}"
fi
