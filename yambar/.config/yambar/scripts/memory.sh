#!/bin/sh

MEMINFO="$(grep -E "(Mem|Swap)" /proc/meminfo | tr -s ' :' ' ' | awk '
/MemTotal/     { mem_total  = $2 }
/MemAvailable/ { mem_free   = $2 }
/SwapTotal/    { swap_total = $2 }
/SwapFree/     { swap_free  = $2 }

END {
    if(swap_total == 0) {
        swap_total = 1;
        swap_used  = 1;
    }

    mem_usage  = (mem_total  - mem_free ) / mem_total;
    swap_usage = (swap_total - swap_free) / swap_total;

    printf("%d %d\n", mem_usage * 100 + 0.5, swap_usage * 100 + 0.5);
}')"

printf "%s" "${MEMINFO}" | sed 's/\([0-9]\+\) \([0-9]\+\)/status|string|R:\1%+\2%\n\n/'
