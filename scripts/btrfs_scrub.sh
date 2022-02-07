#!/bin/sh

[ "$1" ] || exit 0

mountpoint="$1"

grep "$mountpoint" /proc/mounts 2>/dev/null 1>&2 || {
    echo "[E]: Path not in /proc/mounts"
    exit 1
}

# clean up completely unused block groups
btrfs balance start -musage=0 -v "$mountpoint" 2>&1
btrfs balance start -dusage=0 -v "$mountpoint" 2>&1

# re-write data block groups with usage under 20% into new locations
# and try to compact them together
btrfs balance start -dusage=20 -v "$mountpoint" 2>&1

# idle (3) io scheduling class
# low (10) cpu scheduling class
# verify all checksums
time \
    nice -n 10 \
        btrfs scrub start -c 3 -B -d "$mountpoint"
