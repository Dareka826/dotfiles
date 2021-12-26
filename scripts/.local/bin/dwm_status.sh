#!/bin/sh

LAST_CPU_TOTAL=0
LAST_CPU_BUSY=0

while true; do
    ##### CMUS
    CMUS="$(cmus-remote -C status | awk '
    $1=="file" { $1=""; sub(/.*\//,""); title = $0 }
    $1=="tag" && $2=="title" { sub("tag title ",""); title = $0 }
    $1=="tag" && $2=="tracknumber" { tracknum = $3 }
    $1=="duration" { dur = $2 }
    $1=="position" { pos = $2 }
    function stohms(t) {
        s = t%60
        m = ((t-s)/60)%60
        h = (t-m*60-s)/3600
        if(h<10) h = "0"h
        if(m<10) m = "0"m
        if(s<10) s = "0"s
        return h ":" m ":" s
    }
    END {
        if(dur!=0)
        {
            if(tracknum == 0) tracknum = "?"
            lef = dur-pos
            printf("%s. %s | -%s/%s", tracknum, title, stohms(lef), stohms(dur))
        }
        else
            printf("cmus off")
    }')"

    ##### CPU Usage
    # /proc/stat
    # cpu: user(normal) user(nice) system idle iowait irq softirq steal
    CURR_CPU_TIME="$(grep "^cpu " /proc/stat | tr -s ' ')"

    CURR_CPU_TOTAL=$(echo "${CURR_CPU_TIME}" | awk '{ print $1+$2+$3+$4+$5+$6+$7+$8 }')
    CURR_CPU_BUSY=$( echo "${CURR_CPU_TIME}" | awk '{ print $1+$2+$3+$6+$7+$8 }') # Without idle and iowait

    CPU_USAGE=$(( 100 * ( CURR_CPU_BUSY - LAST_CPU_BUSY ) / ( CURR_CPU_TOTAL - LAST_CPU_TOTAL ) ))

    LAST_CPU_TOTAL=$CURR_CPU_TOTAL
    LAST_CPU_BUSY=$CURR_CPU_BUSY

    ##### Memory/Swap Usage
    # /proc/meminfo relevant information in MiB
    MEMINFO="$(cat /proc/meminfo | grep -E "(Mem|Swap)" | tr -s ' :' ' ' | awk '
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
        # mem_used  = mem_total  - mem_free;
        # swap_used = swap_total - swap_free;

        printf("%d%% %d%%\n", mem_usage * 100 + 0.5, swap_usage * 100 + 0.5);
        # printf("%d/%d GiB %d/%d GiB", mem_used / 1048576 + 0.5, mem_total / 1048576 + 0.5, swap_used / 1048576 + 0.5, swap_total / 1048576 + 0.5);
    }')"

    MEM_USAGE="${MEMINFO% *}"
    SWAP_USAGE="${MEMINFO#* }"

    ##### Volume
    VOL_PERCENT=$(pamixer --get-volume)
    VOL_MUTED=$(pamixer --get-mute)
    VOL="${VOL_PERCENT}%"
    [ $VOL_MUTED = "true" ] && VOL="M${VOL}M"

    ##### Display
    xsetroot -name " [ ${CMUS} ] | C:${CPU_USAGE}% R:${MEM_USAGE}+${SWAP_USAGE} | V:${VOL} | $(date "+%Y-%m-%d %H:%M:%S ")"

    sleep 1
done
