#!/bin/bash



###
### Get UUID of a device
###
_get_uuid() {
    DEVICE_PATH="$1"

    UUID=`blkid $DEVICE_PATH | cut -d'"' -f2`
    if [ "$?" != "0" ]; then
	echo "ERROR: Unable to get UUID of $DEVICE_PATH" 1>&2
	return 1
    fi

    COUNT=`blkid $DEVICE_PATH | cut -d'"' -f2 | grep -c .`
    if [ "$COUNT" == "0" ]; then
	echo "ERROR: Unable to find UUID of $DEVICE_PATH" 1>&2
	return 1
    fi
    if [ "$COUNT" -gt "1" ]; then
	echo "ERROR: Multiple UUIDs returned for $DEVICE_PATH" 1>&2
	return 1
    fi

    if [ "$UUID" == "" ]; then
	echo "ERROR: Unable to extract UUID of $DEVICE_PATH" 1>&2
	return 1
    fi

    echo $UUID
    return 0
}



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi
DEST_FILE="$DEST_ROOT/etc/fstab"


###
### Initialize empty new /etc/fstab
###
if [ -f $DEST_FILE ]; then
    echo "ERROR: File $DEST_FILE already exists, WTF?"
    exit 1
fi
rm -f $DEST_FILE && touch $DEST_FILE



###
### Generate swap partition entries
###
for STORAGE_DEVICE in `cat /proc/swaps | awk '{print $1}' | tail -n+2`; do

    UUID=`_get_uuid $STORAGE_DEVICE`
    if [ "$?" != "0" ]; then
	echo "ERROR: _get_uuid() returned non-zero exit status for $STORAGE_DEVICE"
	exit 1
    fi

    echo "# $STORAGE_DEVICE" >> $DEST_FILE
    echo "UUID=$UUID   swap   swap   defaults   0   0" >> $DEST_FILE
done
echo >> $DEST_FILE



###
### Generate storage partition entries
###
for PREFIXED_MOUNT_PATH in `cat /proc/mounts | fgrep " $DEST_ROOT" | awk '{print $2}'`; do

    # Get all variables
    STORAGE_DEVICE=`cat /proc/mounts | fgrep " $PREFIXED_MOUNT_PATH " | awk '{print $1}'`
    STORAGE_FS=`cat /proc/mounts | fgrep " $PREFIXED_MOUNT_PATH " | awk '{print $3}'`

    FINAL_MOUNT_PATH=`echo "$PREFIXED_MOUNT_PATH" | sed -e "s#^$DEST_ROOT##"`
    if [ "$FINAL_MOUNT_PATH" == "" ]; then
	FINAL_MOUNT_PATH="/"
    fi

    UUID=`_get_uuid $STORAGE_DEVICE`

    echo "# $STORAGE_DEVICE" >> $DEST_FILE
    echo "UUID=$UUID   $FINAL_MOUNT_PATH   $STORAGE_FS   defaults,noatime,nodiratime" >> $DEST_FILE
done
echo >> $DEST_FILE



###
### Additional entries
###
cat >> $DEST_FILE <<-EOF
/dev/cdrom       /mnt/cdrom       auto        noauto,owner,ro
devpts           /dev/pts         devpts      gid=5,mode=620
proc             /proc            proc        defaults
tmpfs            /dev/shm         tmpfs       defaults
EOF



echo
echo "OK: /etc/fstab generation complete."
echo
