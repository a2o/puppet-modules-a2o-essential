#!/bin/bash



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi
SRC_URI="$A2O_BOOTSTRAP_URI/files/etc"



###
### Source functions
###
mkdir -p $WORK_DIR && cd $WORK_DIR &&
rm -f _os_install_functions.sh &&
wget "$A2O_BOOTSTRAP_URI/scripts/_os_install_functions.sh" &&
. ./_os_install_functions.sh &&



###
### Download and copy files
###
a2o_download "$SRC_URI/passwd" &&
mv ./passwd $DEST_ROOT/etc/passwd &&
a2o_download "$SRC_URI/group" &&
mv ./group $DEST_ROOT/etc/group &&
a2o_download "$SRC_URI/shadow" &&
mv ./shadow $DEST_ROOT/etc/shadow &&
chmod 640    $DEST_ROOT/etc/shadow &&
chgrp shadow $DEST_ROOT/etc/shadow



###
### Check status
###
RES=$?
if [ "$RES" != "0" ]; then
    echo
    echo "ERROR: An error has occured while configuring networking. Please inspect the output above."
    echo
    exit $RES
fi



echo
echo "OK: Passwd, group and shadow files installed. Root password will be changed at the end."
echo
