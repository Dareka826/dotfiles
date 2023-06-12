#!/bin/sh
set -eu

# 4k UHD
MAX_W=3840
MAX_H=2160

MAX_S="${MAX_W}"
[ "${MAX_H}" -gt "${MAX_S}" ] && MAX_S="${MAX_H}" || :

TMP_OUT=""
cleanup() {
    { [ -n "${TMP_OUT}" ] && [ -e "${TMP_OUT}" ]; } \
        && rm "${TMP_OUT}" \
        || :
}
trap cleanup TERM INT HUP EXIT

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
