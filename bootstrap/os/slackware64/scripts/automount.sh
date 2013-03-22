#!/bin/bash


###
### Check: if mounted (device, mountpoint, device on mountpoint)
###
_check_if_mounted_device() {
    DEVICE="$1"

    RES=`mount | grep "^$DEVICE on " -c`
    if [ "$RES" == "1" ]; then
	return 0
    else
	return 1
    fi
}

_check_if_mounted_mountpoint() {
    MOUNTPOINT="$1"

    RES=`mount | grep " on $MOUNTPOINT type " -c`
    if [ "$RES" == "1" ]; then
	return 0
    else
	return 1
    fi
}

_check_if_mounted_device_on_mountpoint() {
    DEVICE="$1"
    MOUNTPOINT="$2"

    RES=`mount | grep "^$DEVICE on $MOUNTPOINT type" -c`
    if [ "$RES" != "1" ]; then
	return 1
    fi

    RES=`mount | grep "^$DEVICE on $MOUNTPOINT type" | fgrep "(rw)" -c`
    if [ "$RES" != "1" ]; then
	echo "WARNING: Device $DEVICE not mounted in Read-Write mode on $MOUNTPOINT"
	return 1
    fi

    return 0
}

_check_if_mounted_bind() {
    DEVICE="$1"
    MOUNTPOINT="$2"

    RES=`mount | grep "^$DEVICE on $MOUNTPOINT type" -c`
    if [ "$RES" != "1" ]; then
	return 1
    fi

    RES=`mount | grep "^$DEVICE on $MOUNTPOINT type" | fgrep "bind)" -c`
    if [ "$RES" != "1" ]; then
	echo "WARNING: Device $DEVICE not mounted in Bind mode on $MOUNTPOINT"
	return 1
    fi

    return 0
}



###
### Mount normal filesystems
###
_mount() {
    DEVICE="$1"
    MOUNTPOINT="$2"
    FILESYSTEM="$3"

    if _check_if_mounted_mountpoint $MOUNTPOINT; then
	if _check_if_mounted_device_on_mountpoint $DEVICE $MOUNTPOINT; then
	    echo "    Already done."
	    return 0
	else
	    echo "WARNING: Mountpoint $MOUNTPOINT mounted, but not with device $DEVICE"
	    return 1
	fi
    fi
    if _check_if_mounted_device $DEVICE; then
	if _check_if_mounted_device_on_mountpoint $DEVICE $MOUNTPOINT; then
	    echo "    Already done."
	    return 0
	else
	    echo "WARNING: Device $DEVICE already mounted, but not on mountpoint $MOUNTPOINT"
	    return 1
	fi
    fi

    mkdir -p $MOUNTPOINT
    mount $DEVICE $MOUNTPOINT
}


###
### Mount with --bind option
###
_mount_bind() {
    DEVICE="$1"
    MOUNTPOINT="$2"

    if _check_if_mounted_mountpoint $MOUNTPOINT; then
	if _check_if_mounted_bind $DEVICE $MOUNTPOINT; then
	    echo "    Already done."
	    return 0
	else
	    echo "WARNING: Mountpoint $MOUNTPOINT mounted, but not with device $DEVICE"
	    return 1
	fi
    fi
    if _check_if_mounted_device $DEVICE; then
	if _check_if_mounted_bind $DEVICE $MOUNTPOINT; then
	    echo "    Already done."
	    return 0
	else
	    echo "WARNING: Device $DEVICE already mounted, but not on mountpoint $MOUNTPOINT"
	    return 1
	fi
    fi

    mkdir -p $MOUNTPOINT
    mount --bind $DEVICE $MOUNTPOINT
}


###
### Settings
###
MAIN_DEVICE="/dev/sda"
PART_NR_swap="1"
PART_NR_root="2"
PART_NR_var="3"
NEW_ROOT="/mnt/newroot"


###
### Do the real stuff
###
echo "Turning on swap on ${MAIN_DEVICE}${PART_NR_SWAP}..." &&
SWAPSPACE=`free | grep -i swap | awk '{print $2}'`
if [ "$SWAPSPACE" != "0" ]; then
    echo "  Swap space is already enabled, skipping"
else
    mkswap ${MAIN_DEVICE}${PART_NR_swap} &&
    swapon ${MAIN_DEVICE}${PART_NR_swap}
fi &&

echo &&

echo "Mounting new root filesystem to $NEW_ROOT..." &&
_mount ${MAIN_DEVICE}${PART_NR_root} $NEW_ROOT &&

echo "Mounting new /var filesystem to $NEW_ROOT/var..." &&
_mount ${MAIN_DEVICE}${PART_NR_var} $NEW_ROOT/var &&

echo &&

#export FS="dev" &&
#echo "Binding /$FS  to $NEW_ROOT/$FS..." &&
#_mount_bind /$FS $NEW_ROOT/$FS &&
#
#export FS="proc" &&
#echo "Binding /$FS to $NEW_ROOT/$FS..." &&
#_mount_bind /$FS $NEW_ROOT/$FS &&
#
#export FS="sys" &&
#echo "Binding /$FS  to $NEW_ROOT/$FS..." &&
#_mount_bind /$FS $NEW_ROOT/$FS &&


echo "Mounting Slackware64 installation media to /mnt/slack..." &&
if _check_if_mounted_mountpoint /mnt/slack; then
    echo "    Already done."
else
    mkdir -p /mnt/slack &&
    mount -o ro /dev/cdrom /mnt/slack
fi &&


### Check CDROM
if [ ! -d /mnt/slack/slackware64 ]; then
    echo "ERROR: Not a Slackware64 installation media mounted on /mnt/slack"
    exit 1
fi


### Check exit status
RES=$?
if [ "$RES" != "0" ]; then
    echo
    echo "ERROR: An error has occured while mounting required devices. Please inspect the output above."
    echo
    exit $RES
fi

echo
echo "OK: Mounting complete. Please proceed to package installation."
echo
