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
### Fix home to symlink
###
mkdir -p $DEST_ROOT/var/home &&
rm -rf $DEST_ROOT/home &&
ln -sf var/home $DEST_ROOT/home



echo
echo "OK: /home has been moved to /var/home (and symlink created)."
echo
