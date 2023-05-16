#!/bin/sh
set -eu

ENCTMP_SRCDIR="/home/rin/.enctmp"
ENCTMP_MOUNTPOINT="/mnt/enc_tmp"

command -v gocryptfs >/dev/null 2>&1 || exit 1

# Check if already mounted
grep "${ENCTMP_SRCDIR} ${ENCTMP_MOUNTPOINT} " /proc/mounts >/dev/null 2>&1 && exit 0 || :

FIFO1="$(mktemp -u)";
FIFO2="$(mktemp -u)";

cleanup() { rm "${FIFO1}" "${FIFO2}" || :; }
trap cleanup TERM INT HUP EXIT

mkfifo "${FIFO1}"
mkfifo "${FIFO2}"

# Generate random one-time password
tr -cd 'a-zA-Z0-9' </dev/urandom | head -c1024 | tee "${FIFO1}" | tee "${FIFO2}" >/dev/null &

[ -d "${ENCTMP_SRCDIR}" ] || mkdir "${ENCTMP_SRCDIR}"
gocryptfs -init -passfile "${FIFO1}" "${ENCTMP_SRCDIR}"
gocryptfs       -passfile "${FIFO2}" "${ENCTMP_SRCDIR}" "${ENCTMP_MOUNTPOINT}"
