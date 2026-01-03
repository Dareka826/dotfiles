#!/bin/sh
set -eu

# Discard input
exec </dev/null

# Load theme vars
. ~/.config/env/bar_status_colors

VOLUME_SINK="alsa_output.pci-0000_05_00.6.analog-stereo"

# Header
printf '%s\n' '{"version": 1}' '['

battery() {
  printf '%s' "$(cat /sys/class/power_supply/BAT0/capacity)%"
}

BAT_CTR=0
BAT="XX%"

volume() {
  MUTECHR=""
  [ "$(pamixer --sink "${VOLUME_SINK}" --get-mute)" = "false" ] || \
    MUTECHR="M"

  printf '%s' "${MUTECHR}$(pamixer --sink "${VOLUME_SINK}" --get-volume)${MUTECHR}%"
}

memory() {
  ~/.config/waybar/scripts/memory.sh
}

if ! [ -e ~/.config/waybar/scripts/memory.sh ]; then
  #memory() {
  #  free -b | awk '
  #    BEGIN { mem = ""; swap = "" }
  #    /^Mem:/ { mem = sprintf("%.0f%%", 100 * ($2 - $7) / $2); }
  #    /^Swap:/ { if ($2 != 0) { swap = sprintf("+%.0f%%", 100 * $3 / $2) } }
  #    END { printf("%s%s", mem, swap) }'
  #}

  memory() {
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
  }
fi

CPU_BUSY_PREV=""
CPU_IDLE_PREV=""
CPU_TEXT="XX%"

gen_cpu_text() {
  CPU_DATA="$(grep '^cpu ' /proc/stat | awk '{ printf("%s\n%s\n", $2 + $3 + $4, $5) }')"
  CPU_BUSY="$(printf '%s\n' "${CPU_DATA}" | head -1)"
  CPU_IDLE="$(printf '%s\n' "${CPU_DATA}" | tail -1)"

  if [ "${CPU_BUSY_PREV}" != "" ]; then
    CPU_BUSY_DELTA="$((CPU_BUSY - CPU_BUSY_PREV))"
    CPU_IDLE_DELTA="$((CPU_IDLE - CPU_IDLE_PREV))"

    CPU_TEXT="$(( 100 * CPU_BUSY_DELTA / (CPU_BUSY_DELTA + CPU_IDLE_DELTA) ))%"
  fi

  CPU_BUSY_PREV="${CPU_BUSY}"
  CPU_IDLE_PREV="${CPU_IDLE}"
}

window_title() {
  swaymsg -t get_tree 2>/dev/null \
    | jq -r '.. | try select(.focused == true).name' 2>/dev/null
}


while true; do
  # Refresh battery value every 10 seconds
  if [ "${BAT_CTR}" = "0" ]; then
    BAT="$(battery)"
    BAT_CTR=10
  else
    BAT_CTR="$((BAT_CTR - 1))"
  fi

  gen_cpu_text

cat <<EOF
[
  {
    "full_text": " $(window_title) ",
    "min_width": "200%",
    "separator_block_width": 0
  },
  {
    "full_text": " $(~/.config/waybar/scripts/sway-tree.sh) ",
    "background": "${BAR_BLOCK}",
    "separator_block_width": 0
  },
  {
    "full_text": " $(~/.local/bin/cmus-status.sh) ",
    "background": "${BAR_BLOCK_ALT}",
    "separator_block_width": 0
  },
  {
    "full_text": " C:${CPU_TEXT} R:$(memory) | V:$(volume) B:${BAT} ",
    "background": "${BAR_BLOCK}",
    "separator_block_width": 0
  },
  {
    "full_text": " $(date "+%Y-%m-%d %H:%M:%S") ",
    "color": "${BAR_ACCENT_FG}",
    "background": "${BAR_ACCENT_BG}",
    "separator_block_width": 0
  }
],
EOF

  sleep 1
done
