#!/bin/sh

if [ "$#" -lt 1 ]; then
	echo "too few arguments"
	exit 1
fi

disk="$1"

if [ ! -e "$disk" ]; then
	echo "$disk not found"
	exit 1
fi

if mount | grep "$disk"1 > /dev/null; then
	sudo umount "$disk"1
fi

if mount | grep "$disk"2 > /dev/null; then
	sudo umount "$disk"2
fi

sudo parted -s "$disk" rm 1
sudo parted -s "$disk" rm 2

sudo dd if=output/images/sdcard.img of="$disk" bs=1M

./scripts/utils/resize_partition.py "$disk"
