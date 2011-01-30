#!/bin/sh
mnt="/mnt/sdcard/deb"
img="/mnt/sdcard/deb.img"

if [ ! -f "$img" ];then #check for debian image. Exit if not found.
    echo "Debian image not found!"
    exit
fi

if [ -f "/dev/debian" ];then #make /dev/debian if needed
    echo "Making /dev/debian"
    busybox mknod /dev/debian b 7 200
fi

if [ ! -d "$mnt" ];then #make mnt dir if needed
    echo "Making mount dir."
    mkdir -vp $mnt
fi

if [ "`losetup /dev/debian | grep img | wc -l`" == "0" ];then
    echo "Attaching $img to /dev/debian"
    losetup /dev/debian "$img"
fi

if [ "`mount | grep /dev/debian | wc -l`" == "0" ];then
    echo "Mounting debian image."
    mount -o noatime /dev/debian $mnt
fi

if [ "`mount | grep $mnt/proc | wc -l`" != "1" ];then
    echo "Mounting devpts"
    mount -t proc proc $mnt/proc
fi

if [ "`mount | grep $mnt/dev/pts | wc -l`" != "1" ];then
    echo "Mounting devpts"
    mount -t devpts devpts $mnt/dev/pts
fi

if [ "`mount | grep $mnt/sys | wc -l`" != "1" ];then
    echo "Mounting sysfs"
    mount -t sysfs sysfs $mnt/sys
fi