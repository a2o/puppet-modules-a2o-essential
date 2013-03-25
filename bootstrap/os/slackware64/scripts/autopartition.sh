#!/bin/bash



###
### Settings
###
DEVICE="$DEST_DEVICE"
SIZE_SWAP_GB="4"
SIZE_ROOT_GB="20"
SIZE_VAR_GB_MIN="6"
#FORCE="false" # Currently unimplemented



###
### Sanity check
###
if [ "$DEVICE" == "" ]; then
    echo "INFO:  export DEST_DEVICE='/dev/sda'"
    echo "ERROR: Destination device not specified."
    exit 1
fi
if [ ! -b $DEVICE ]; then
    echo "ERROR: Destination device is not a block device: $DEVICE"
    exit 1
fi

SIZE_GB_REQUIRED=`expr $SIZE_SWAP_GB + $SIZE_ROOT_GB + $SIZE_VAR_GB_MIN`
SIZE_BLOCKS_AVAILABLE=`sfdisk -s $DEVICE`
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to get disk $DEVICE size information"
    exit 1
fi
SIZE_GB_AVAILABLE=`expr $SIZE_BLOCKS_AVAILABLE / 1024 / 1024`
if [ "$SIZE_GB_REQUIRED" -gt "$SIZE_GB_AVAILABLE" ]; then
    echo "ERROR: $SIZE_GB_REQUIRED GB disk space required, but only $SIZE_GB_AVAILABLE GB is available on $DEVICE"
    exit 1
fi



###
### Check if partition table is empty
###
RES=`sfdisk -l $DEVICE | grep "^$DEVICE" | awk '{print $5}' | grep -v '^0$' -c`
if [ "$RES" != "0" ]; then
    echo "ERROR: Partitions already exist on $DEVICE"
    exit 1
fi



###
### Reset device partition table, refresh OS #1, just in case
###

# Erase MBR
#dd if=/dev/zero of=$DEVICE bs=512 count=1 conv=notrunc

# Initializes disklabel with empty partition table
#echo 'w' | fdisk $DEVICE   # Initializes empty partition table
#parted --script --align=optimal $DEVICE -- mklabel msdos

# Kernel reread
partprobe $DEVICE



###
### Create partitions
###
SWAP_GB_START="1"
SWAP_GB_END="$SIZE_SWAP_GB"
ROOT_GB_START="$SWAP_GB_END"
ROOT_GB_END=`expr $SWAP_GB_END + $SIZE_ROOT_GB`
VAR_GB_START="$ROOT_GB_END"

parted --script --align=optimal $DEVICE -- mklabel msdos &&
parted --script --align=optimal $DEVICE -- unit gb mkpart primary linux-swap $SWAP_GB_START $SWAP_GB_END &&
parted --script --align=optimal $DEVICE -- unit gb mkpart primary ext2       $ROOT_GB_START $ROOT_GB_END &&
parted --script --align=optimal $DEVICE -- unit gb mkpart primary ext2       $VAR_GB_START  -1 &&
parted --script --align=optimal $DEVICE -- set 2 boot on &&
partprobe $DEVICE


if [ "$?" != "0" ]; then
    echo "ERROR: Unable to create partitions on $DEVICE. See output above."
    exit 1
fi



###
### Create filesystems
###
mkswap    ${DEVICE}1 &&
mkfs.ext4 ${DEVICE}2 &&
mkfs.ext4 ${DEVICE}3

if [ "$?" != "0" ]; then
    echo "ERROR: Unable to create filesystems on $DEVICE. See output above."
    exit 1
fi



###
### Complete
###
echo
echo "INFO: Partitioning and filesystem creation complete. Please proceed to mounting."
echo
