#!/bin/bash



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi
DEST_FILE="$DEST_ROOT/etc/lilo.conf"



###
### Initialize empty new /etc/lilo.conf
###
if [ -f $DEST_FILE ]; then
    echo "ERROR: File $DEST_FILE already exists, WTF?"
    exit 1
fi
rm -f $DEST_FILE && touch $DEST_FILE



###
### Get root and boot device names
###
ROOT_DEVICE=`cat /proc/mounts | fgrep " $DEST_ROOT " | awk '{print $1}'` &&
BOOT_DEVICE=`echo "$ROOT_DEVICE" | sed -e 's/[0-9]$//'` &&



###
### Write /etc/lilo.conf
###
cat >> $DEST_ROOT/etc/lilo.conf <<-EOF
lba32
#message    = /boot/boot_message.txt
prompt
timeout    = 20
boot       = $BOOT_DEVICE
root       = $ROOT_DEVICE
read-only
append     = " vt.default_utf8=0"
vga        = normal
#restricted
#password   = "lilo"

image = /boot/vmlinuz
  label = dist
EOF



###
### Write MBR
###
chroot $DEST_ROOT lilo



###
### Check status
###
RES=$?
if [ "$RES" != "0" ]; then
    echo
    echo "ERROR: An error has occured while configuring time. Please inspect the output above."
    echo
    exit $RES
fi



echo
echo "OK: /etc/lilo.conf generated, MBR written."
echo
