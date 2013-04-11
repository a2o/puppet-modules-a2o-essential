#!/bin/bash


###
### Environment sanity check
###
a2oBootstrap_environmentCheck_inChroot() {
    if [ "$A2O_REPO_URI" == "" ]; then
	echo "Hint:  export A2O_REPO_URI='http://source.a2o.si/git/puppet-modules-a2o-essential/raw/master'"
	echo "ERROR: A2O_REPO_URI environmental variable must point to a2o repository"
	return 1
    fi
    if [ "$A2O_BOOTSTRAP_URI" == "" ]; then
	echo "Hint:  export A2O_BOOTSTRAP_URI='http://source.a2o.si/git/puppet-modules-a2o-essential/raw/master/bootstrap/os/slackware64'"
	echo "ERROR: A2O_BOOTSTRAP_URI environmental variable must point to download location of this script (for package list retrieval)"
	return 1
    fi

    if [ "$WORK_DIR" == "" ]; then
	echo "Hint:  export WORK_DIR='/root/a2o'"
	echo "ERROR: Working directory path not specified."
	return 1
    fi

    if [ "$NEW_HOSTNAME" == "" ]; then
	echo "Hint:  export NEW_HOSTNAME='my-new-server.example.net'"
	echo "ERROR: Hostname for this new server not specified."
	return 1
    fi

    if [ "$ROOT_PASSWORD_HASH" == "" ]; then
	echo "Hint:  export ROOT_PASSWORD_HASH='my-root-password-hash'"
	echo "ERROR: Root password hash for this new server not specified."
	return 1
    fi
}

a2oBootstrap_environmentCheck() {

    if ! a2oBootstrap_environmentCheck_inChroot; then
	return 1
    fi

    if [ "$DEST_DEVICE" == "" ]; then
	echo "Hint:  export DEST_DEVICE='/dev/sda2'"
	echo "ERROR: Destination root device not specified."
	return 1
    fi
    if [ "$DEST_ROOT" == "" ]; then
	echo "Hint:  export DEST_ROOT='/mnt/newroot'"
	echo "ERROR: Destination root path not specified."
	return 1
    fi

    if [ "$SRC_REPO" == "" ]; then
	echo "Hint:  export SRC_REPO='/mnt/slack'"
	echo "ERROR: Slackware package repository path not specified."
	return 1
    fi
}



###
### File download
###
a2oBootstrap_download() {
    URI="$1"
    FILENAME=`basename "$URI"`

    rm -f "$FILENAME" &&
    echo "Downloading $URI..." &&
    wget -q --no-check-certificate "$URI"

    if [ "$?" != "0" ]; then
	echo "ERROR: Download failed."
	return 1
    fi

    if [[ "$FILENAME" =~ \.sh$ ]]; then
	chmod 755 "$FILENAME"
    fi
}

# Legacy name
a2o_download() {
    a2oBootstrap_download "$1"
}



###
### Script download and execution
###
a2oScript_download() {
    SCRIPT_URI="$1"
    SCRIPT_FILENAME=`basename "$SCRIPT_URI"`

    mkdir -p $WORK_DIR &&
    cd $WORK_DIR &&

    a2oBootstrap_download "$SCRIPT_URI" &&
    chmod 755 $SCRIPT_FILENAME
}

a2oScript_downloadAndRun() {
    SCRIPT_URI="$1"
    SCRIPT_FILENAME=`basename "$SCRIPT_URI"`

    mkdir -p $WORK_DIR &&
    cd $WORK_DIR &&

    a2oScript_download "$SCRIPT_URI" &&
    cd $WORK_DIR &&
    $SCRIPT_FILENAME
}
