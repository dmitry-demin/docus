#!/bin/bash
# set -v
E_WRONGCOMMAND=1
E_WRONGPARTITION=2
E_ERASE=3

fs_write() {
sudo -u root bash -c 'echo fs_write'
#local param_fs=$1
#local param_file=$2
#local param_device=$3
#exportfs none
#exportfs $param_fs
#device_detect $param_device
#echo sudo dd if=$param_file of=$device bs=2048||return $?
#sync
#exportfs none
}

#fs_read() {
#echo fs_read $*
#local param_fs=$1
#local param_file=$2
#local param_device=$3
#exportfs none
#exportfs $param_fs
#device_detect $param_device
#echo sudo dd if=$device of=$param_file bs=2048||return $?
#exportfs none
#}

#fs_erase() {
#echo fs_erase $*
#local param_fs=$1
#local param_device=$2
#case $param_fs in
# hboot) echo Erasing partition $param_fs not allowed: it will brick Your phone!; exit $E_ERASE;;
# emmc)  echo Erasing partition $param_fs not allowed: it will brick Your phone!; exit $E_ERASE;;
# none)  echo Unable to erase partition $param_fs!; exit $E_ERASE;;
# *) fs_write $param_fs /dev/zero $param_device ;; 
#esac
#}

#exportfs() {
#echo exportfs $*
#case $1 in
# hboot)    partition=/dev/block/mmcblk0p12;;
# radio)    partition=/dev/block/mmcblk0p17;;
# adsp)     partition=/dev/block/mmcblk0p19;;
# boot)     partition=/dev/block/mmcblk0p20;;
# recovery) partition=/dev/block/mmcblk0p21;;
# system)   partition=/dev/block/mmcblk0p22;;
# data)     partition=/dev/block/mmcblk0p23;;
# cache)    partition=/dev/block/mmcblk0p24;;
# devlog)   partition=/dev/block/mmcblk0p27;;
# emmc)     partition=/dev/block/mmcblk0;;
# sdcard)   partition=/dev/block/mmcblk1;;
# none)     partition=/dev/null;;
# *) echo Wrong partition: $1; exit $E_WRONGPARTITION;;
#esac
#legacy="/sys/devices/platform/usb_mass_storage/lun0/file"
#recent="/sys/devices/platform/msm_otg/msm_hsusb/gadget/lun0/file"
#echo 'until /opt/android-sdk-update-manager/platform-tools/adb shell "echo $partition > $legacy" ; do sleep 1;done'
#echo 'until /opt/android-sdk-update-manager/platform-tools/adb shell "echo $partition > $recent" ; do sleep 1;done'
#}

#device_detect() {
#echo "device_detect $*"
#if [[ "z$1" != "z" ]] ;then device=$1; return; fi
#device=`find /dev/disk/by-id/|grep -i Android|sort|head -n 1` ## TODO: write better detect function!
#}
#
#usage() {
#echo "Usage: adbflasher flash    hdsp     boot.img   [device_to_flash]
#       adbflasher flash    recovery recovery.img [device_to_flash]
#       adbflasher flash    radio    radio.img    [device_to_flash]
#       adbflasher flash    hboot    hboot.img    [device_to_flash] ## Dangerous!
#       adbflasher flash    adsp     adsp.img     [device_to_flash]
#       adbflasher flash    emmc     emmc.img     [device_to_flash] ## Extremly dangerous! DO NOT FLASH ANY FILE EXCEPT YOUR HAVE READ FROM YOUR PHONE EARLIER!
#       adbflasher exportfs {hboot|radio|adsp|boot|recovery|system|data|cache|devlog|emmc|sdcard|none} 
#       ## Might br dangerous! ALWAYS do exportfs none before exportfs another partition!
#       adbflasher read     {hboot|radio|adsp|boot|recovery|system|data|cache|devlog|emmc|sdcard|none} filename.img [device_to_read]
#       adbflasher erase    {radio|adsp|boot|recovery|system|data|cache|devlog|sdcard} [device_to_erase]"
#}

#if [[ $# -eq 0 ]] ;then usage; exit $E_WRONGCOMMAND; fi

#case $1 in
#exportfs) exportfs $2 ;;
#erase)    fs_erase $2 $3    |exit $? ;;
#read)     fs_read  $2 $3 $4 |exit $? ;;
#flash)    fs_write $2 $3 $4 |exit $? ;;
#*)        echo "Wrong command: $1"; usage; exit $E_WRONGCOMMAND ;;
#esac

##until /opt/android-sdk-update-manager/platform-tools/adb reboot ; do sleep 1;done
