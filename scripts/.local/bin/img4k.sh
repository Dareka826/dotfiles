#!/bin/sh
set -eu

# 4k UHD
MAX_W=3840
MAX_H=2160

MAX_S="${MAX_W}"
[ "${MAX_H}" -gt "${MAX_S}" ] && MAX_S="${MAX_H}" || :

#for f in "${@}"; do
#    # Check orientation
#    IMG_SIZE="$(convert "${f}" -ping -format "%w %h" info:)"
#    IMG_W="${IMG_SIZE% *}"
#    IMG_H="${IMG_SIZE#* }"
#
#    # Check if portrait
#    if [ "${IMG_H}" -gt "${IMG_W}" ]; then
#        __TMP="${MAX_W}"
#        MAX_W="${MAX_H}"
#        MAX_H="${__TMP}"
#    fi
#
#    printf "%s %s -> %s %s\n" "${IMG_W}" "${IMG_H}" "${MAX_W}" "${MAX_H}"
#
#    convert "${f}" -resize "${MAX_W}x${MAX_H}>" "${f}_shrink.jpg"
#done

for f in "${@}"; do
    [ -e "${f}" ] || continue

    EXT="${f##*.}"
    [ "${EXT}" != "${f}" ] || continue # No extension!

    TMP_OUT="$(mktemp --suffix=".${EXT}")"

    if ! convert "${f}" -resize "${MAX_S}x${MAX_S}>" "${TMP_OUT}"; then
        rm "${TMP_OUT}"
        continue
    fi

    touch -r "${f}" "${TMP_OUT}"
    mv "${TMP_OUT}" "${f}"

    printf "conv 4k: %s\n" "${f}"
done
