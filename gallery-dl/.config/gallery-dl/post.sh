#!/bin/sh
IFS="$(printf "\n")"

process_png() {
    convert "${1}" -quality 99 "${1%png}jpg"
    rm "${1}"
}

process_jpg() {
    jpegoptim -p -P -q "${1}"
}

case "${1}" in
    "png")
        process_png "${2}"
        ;;
    "jpg")
        process_jpg "${2}"
        ;;
    "jpeg")
        mv "${2}" "${2%jpeg}jpg"
        process_jpg "${2%jpeg}jpg"
        ;;
esac
