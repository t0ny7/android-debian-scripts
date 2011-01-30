#!/bin/sh
mnt="/mnt/sdcard/deb"
img="/mnt/sdcard/deb.img"

if [ "`mount | grep $mnt/proc | wc -l`" == "1" ];then
    echo "Unmounting devpts"
    umount $mnt/proc
fi

if [ "`mount | grep $mnt/dev/pts | wc -l`" == "1" ];then
    echo "Unmounting devpts"
    umount $mnt/dev/pts
fi

if [ "`mount | grep $mnt/sys | wc -l`" == "1" ];then
    echo "Unmounting sysfs"
    umount $mnt/sys
fi

if [ "`mount | grep /dev/debian | wc -l`" == "1" ];then
    echo "Unmounting debian image."
    umount $mnt
fi

if [ "`losetup /dev/debian | grep img | wc -l`" != "0" ];then
    echo "Dettaching /dev/debian"
    losetup -d /dev/debian
fi