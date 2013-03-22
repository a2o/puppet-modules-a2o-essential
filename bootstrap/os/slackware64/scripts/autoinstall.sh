#!/bin/bash



###
### Actual package installation routine
###
_installpkg() {
    GROUP_PACKAGE_NAME="$1"
    PACKAGE_REPO_PATH="$2"
    DEST_ROOT="$3"

    # Check destination root
    if [ "$DEST_ROOT" == "" ]; then
	echo "ERROR: Destination root argument not set!"
	return 1
    fi

    # Get exact filename
    RES=`ls $PACKAGE_REPO_PATH/$GROUP_PACKAGE_NAME-*.t?z | egrep "${GROUP_PACKAGE_NAME}-[^-]\+-[^-]\+-[^-]\+\.t[xg]z$" | grep -c .`
    if [ "$RES" != "1" ]; then
	echo "ERROR: Zero or multiple package files found for the pattern $GROUP_PACKAGE_NAME"
	return 1
    fi

    installpkg --terse --root $DEST_ROOT `ls $PACKAGE_REPO_PATH/$GROUP_PACKAGE_NAME-*.t?z | egrep "${GROUP_PACKAGE_NAME}-[^-]\+-[^-]\+-[^-]\+\.t[xg]z$"`
}



###
### Check if URI is given as the ENV variable
###
if [ "$A2O_BOOTSTRAP_URI" == "" ]; then
    echo
    echo "ERROR: A2O_BOOTSTRAP_URI environmental variable must point to download location of this script (for package list retrieval)"
    echo
    exit 1
fi



###
### Settings
###
PACKAGE_LIST_FILE="slackware64-14.0.pkglist"
PACKAGE_LIST_URI="$A2O_BOOTSTRAP_URI/package-lists/$PACKAGE_LIST_FILE"
PACKAGE_REPO_PATH="/mnt/slack/slackware64"
DEST_ROOT="/mnt/newroot"



###
### Do the real stuff
###
cd /root &&
rm -f $PACKAGE_LIST_FILE &&
wget $PACKAGE_LIST_URI &&

echo &&
echo "INSTALLING PACKAGES to $DEST_ROOT:" &&
echo &&

for GROUP_PACKAGE_NAME in `cat $PACKAGE_LIST_FILE`; do
    _installpkg $GROUP_PACKAGE_NAME $PACKAGE_REPO_PATH $DEST_ROOT
    RES=$?
    if [ "$RES" != "0" ]; then
	echo
	echo "ERROR: There was an error while installing package $GROUP_PACKAGE_NAME. Please resolve the issue manually."
	echo
	exit 1
    fi
done



### Check exit status
RES=$?
if [ "$RES" != "0" ]; then
    echo
    echo "ERROR: There was an error at package installation. Please inspect the output above."
    echo
    exit $RES
fi

echo
echo "OK: Package installation complete. Please proceed to system configuration."
echo
