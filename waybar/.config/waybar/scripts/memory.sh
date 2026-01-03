#!/bin/sh
set -eu

grep -E '^(Mem|Swap)' /proc/meminfo | tr -s ' :' ' ' | awk '
/MemTotal/     { mem_total  = $2 }
/MemAvailable/ { mem_free   = $2 }
/SwapTotal/    { swap_total = $2 }
/SwapFree/     { swap_free  = $2 }

END {
    mem_usage = 100 * (mem_total - mem_free) / mem_total;
    printf("R:%.0f%%", mem_usage);

    if(swap_total != 0) {
        swap_usage = 100 * (swap_total - swap_free) / swap_total;
        printf("+%.0f%%", swap_usage);
    }
}'
