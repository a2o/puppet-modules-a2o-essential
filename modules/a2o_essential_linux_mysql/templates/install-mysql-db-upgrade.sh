#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_MYSQL="<%= softwareVersion %>" &&
export PVERSION_MYSQL_MAJOR=`echo "$PVERSION_MYSQL" | cut -d. -f1,2` &&
export PDESTDIR_MYSQL="<%= destDir_mysql %>" &&



### Upgrade database
# FIXME change to mysql_fix_privilege_tables?
#export USER="root" &&
#export HOME="/root" &&
if [ -e /var/mysql/data/mysql ]; then

    # Execute upgrade first
    $PDESTDIR_MYSQL/bin/mysql_upgrade --defaults-file=/root/.my.cnf
    if [ "$?" != "0" ]; then
	echo "WARNING: mysql_upgrade returned non-zero exit status, checking if upgrade has already been performed"
	RES=`$PDESTDIR_MYSQL/bin/mysql_upgrade --defaults-file=/root/.my.cnf | grep -c "is already upgraded"`
	if [ "$RES" != "1" ]; then
	    echo "ERROR: Database upgrade failed"
	    exit 1
	fi
	echo "INFO: Upgrade has already been completed"
    fi

    # Restart after tables have been upgraded
    echo "INFO: In order to pick up upgraded table chages, let's restart mysqld..."
    /etc/rc.d/rc.mysqld restart
fi
