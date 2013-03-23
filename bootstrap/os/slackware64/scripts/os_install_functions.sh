#!/bin/bash

###
### Script download and execution
###

_a2oScript_download() {
    SCRIPT_URI="$1"
    SCRIPT_FILENAME=`basename "$SCRIPT_URI"`

    mkdir -p $WORK_DIR &&
    cd $WORK_DIR &&

    rm -f $SCRIPT_FILENAME &&
    wget --no-check-certificate "$SCRIPT_URI" &&

    chmod 755 $SCRIPT_FILENAME
}

_a2oScript_downloadAndRun() {
    SCRIPT_URI="$1"
    SCRIPT_FILENAME=`basename "$SCRIPT_URI"`

    a2oScript_download "$SCRIPT_URI" &&
    cd $WORK_DIR &&
    $SCRIPT_FILENAME
}

# That is all.
