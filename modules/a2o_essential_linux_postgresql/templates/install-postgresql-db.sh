#!/bin/bash



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PDESTDIR_POSTGRESQL="<%= destDir %>" &&



### Install database if necessary
if [ ! -f /var/postgresql/data/PG_VERSION ]; then
    su - postgresql -c "$PDESTDIR_POSTGRESQL/bin/initdb /var/postgresql/data"
fi
