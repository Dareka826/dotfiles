#!/bin/sh
set -eu

p()  { printf '%s\n' "$@"; }
pn() { printf '%s' "$@"; }

PROG_NAME="${0}"
PROG_NAME="${PROG_NAME##*/}"

if ! [ "${#}" = 2 ]; then
    p "Usage:" \
      "  ${PROG_NAME}  FILE  RECV_BLK_COUNT" \
      ""

    exit 0
fi

FILE="${1}"
BLK_CNT="${2}"

if ! [ "$(pn "x${BLK_CNT}x" | tr -d "0-9")" = "xx" ]; then
    p "[E]: Not an integer: ${BLK_CNT}"
    exit 1
fi

if ! [ "$(pn "x${BLK_CNT}" | head -c2 | tr "1-9" "x")" = "xx" ]; then
    p "[E]: Not a valid integer: ${BLK_CNT}"
    exit 1
fi

if ! [ -f "${FILE}" ]; then
    p "[E]: No such file: ${FILE}"
    exit 1
fi

FILE_SIZE="$(du -b "${FILE}" | sed 's/\s.*$//')"
if [ "${FILE_SIZE}" = 0 ]; then
    p "[E]: Empty file: ${FILE}"
    exit 2
fi

# ceil(sqrt((rec_blk_cnt+1)/rec_blk_cnt * 20 * file_size))
MIN_BLK_SIZE="$(awk 'BEGIN { r = '"${BLK_CNT}"'; x = sqrt(((r+1) / r) * 20 * '"${FILE_SIZE}"'); if (int(x) != x) { x += 1 }; print(int(x)) }')"
# Round up to a mult of 4
MIN_BLK_SIZE="$(awk 'BEGIN { print( int(('"${MIN_BLK_SIZE}"' + 3) / 4) * 4 ) }')"

p "${MIN_BLK_SIZE}"
