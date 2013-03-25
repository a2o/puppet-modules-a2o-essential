#!/bin/bash



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi


###
### Generate
###
DEST_FILE="${DEST_ROOT}/etc/hardwareclock" &&
echo "UTC" > $DEST_FILE &&

SRC_FILE="${DEST_ROOT}/usr/share/zoneinfo/UTC" &&
DEST_FILE="${DEST_ROOT}/etc/localtime" &&
cp $SRC_FILE $DEST_FILE &&
ln -sf /usr/share/zoneinfo/UTC ${DEST_FILE}-copied-from



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
echo "OK: Time configuration files generated."
echo
