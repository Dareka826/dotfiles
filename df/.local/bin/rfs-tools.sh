#!/bin/sh

[ $1 = "" -o $2 = "" ] && exit 1
RFSDIR=$2

if [ $1 = "mount" ]; then
	mount -t proc /proc $RFSDIR/proc
	mount -o bind /sys $RFSDIR/sys
	mount -o bind /dev $RFSDIR/dev
	mount -o bind /dev/pts $RFSDIR/dev/pts
	mount -o bind /dev/shm $RFSDIR/dev/shm
	mount -o bind /run $RFSDIR/run
	mount -o bind /tmp $RFSDIR/tmp
fi

if [ $1 = "chroot" ]; then
	chroot $RFSDIR /usr/bin/env -i \
		HOME=/root \
		TERM="xterm-256color" \
		PATH=:/usr/sbin:/usr/bin:/sbin:/bin \
		/usr/bin/zsh -l
fi
if [ $1 = "proot" ]; then
	proot -r $RFSDIR \
		-b /proc \
		-b /sys \
		-b /dev \
		-b /run \
		-b /tmp \
		-b /etc/resolv.conf \
		-w /root \
		-0 \
		/usr/bin/env -i \
		HOME=/root \
		TERM="xterm-256color" \
		PATH=:/usr/sbin:/usr/bin:/sbin:/bin \
		/usr/bin/zsh -l
fi

if [ $1 = "umount" ]; then
	umount $RFSDIR/proc
	umount $RFSDIR/sys
	umount $RFSDIR/dev
	umount $RFSDIR/dev/pts
	umount $RFSDIR/dev/shm
	umount $RFSDIR/run
	umount $RFSDIR/tmp
fi

