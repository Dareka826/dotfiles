#!/bin/sh
set -eu

# For details see `src/frameserver/terminal/default/arcterm.c` in the arcan repo

# The palette name doesn't actually matter since we're overriding all the colors
COLOR_DEFS="palette=custom"

# 0-7  normal colors
# 8-15 bright colors
# 16   foreground color
# 17   background color
COLOR_DEFS="${COLOR_DEFS}:ci=0,22,22,22"
COLOR_DEFS="${COLOR_DEFS}:ci=1,238,83,150"
COLOR_DEFS="${COLOR_DEFS}:ci=2,66,190,101"
COLOR_DEFS="${COLOR_DEFS}:ci=3,255,126,182"
COLOR_DEFS="${COLOR_DEFS}:ci=4,51,177,255"
COLOR_DEFS="${COLOR_DEFS}:ci=5,190,149,255"
COLOR_DEFS="${COLOR_DEFS}:ci=6,61,219,217"
COLOR_DEFS="${COLOR_DEFS}:ci=7,208,208,208"
COLOR_DEFS="${COLOR_DEFS}:ci=8,82,82,82"
COLOR_DEFS="${COLOR_DEFS}:ci=9,238,83,150"
COLOR_DEFS="${COLOR_DEFS}:ci=10,66,190,101"
COLOR_DEFS="${COLOR_DEFS}:ci=11,255,126,182"
COLOR_DEFS="${COLOR_DEFS}:ci=12,51,177,255"
COLOR_DEFS="${COLOR_DEFS}:ci=13,190,149,255"
COLOR_DEFS="${COLOR_DEFS}:ci=14,61,219,217"
COLOR_DEFS="${COLOR_DEFS}:ci=15,255,255,255"
COLOR_DEFS="${COLOR_DEFS}:ci=16,242,242,242"
COLOR_DEFS="${COLOR_DEFS}:ci=17,22,22,22"

set -x
exec arcan_db add_appl_kv console terminal "${COLOR_DEFS}"
