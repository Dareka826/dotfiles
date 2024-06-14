#!/bin/sh
set -eu

[ "$#" = 2 ] || {
    printf "%s\n" \
        "Usage:" \
        "  ./par2_min_bs.sh  FILE  RECV_BLK_COUNT" \
        ""
    exit 0
}

FILE="${1}"
N_BLK="${2}"

[ -e "${FILE}" ] || {
    printf "%s\n" "[E]: No such file: ${FILE}"
    exit 1
}

[ "$(printf "%s" "${N_BLK}" | tr -d '0-9')" = "" ] || {
    printf "%s\n" "[E]: Not an integer: ${N_BLK}"
    exit 1
}

FILE_SIZE="$(du -b "${FILE}" | grep -Eo '^[0-9]+')"
[ "${FILE_SIZE}" != 0 ] || {
    printf "%s\n" "[W]: Empty file: ${FILE}"
    exit 2
}

# ceil(sqrt((rec_blk_cnt+1)/rec_blk_cnt * 20 * file_size))
MIN_BLK_SIZE="$(awk 'BEGIN { r = '"${N_BLK}"'; x = sqrt(((r+1) / r) * 20 * '"${FILE_SIZE}"'); if (int(x) != x) { x += 1 }; print(int(x)) }')"
# Round up to a mult of 4
MIN_BLK_SIZE="$(awk 'BEGIN { print( int(('"${MIN_BLK_SIZE}"' + 3) / 4) * 4 ) }')"

printf "%s\n" "${MIN_BLK_SIZE}"
