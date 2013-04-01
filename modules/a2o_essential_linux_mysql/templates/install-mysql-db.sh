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



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PDESTDIR="<%= destDir_mysql %>" &&



# Install database if necessary
if [ ! -d /var/mysql/data/mysql ]; then
    if [ -e $PDESTDIR/scripts/mysql_install_db ]; then
	MYSQL_INSTALL_DB="$PDESTDIR/scripts/mysql_install_db"
    elif [ -e $PDESTDIR/bin/mysql_install_db ]; then
	MYSQL_INSTALL_DB="$PDESTDIR/bin/mysql_install_db"
    else
	echo "ERROR: mysql_install_db not found"
	exit 1
    fi
    $MYSQL_INSTALL_DB --basedir=$PDESTDIR --datadir=/var/mysql/data &&

    ### Start without access checking, but disable networking for this occasion
    /bin/bash /etc/rc.d/rc.mysqld start --skip-grant-tables --skip-networking &&

    ### Fix permissions and run upgrade - just in case
    echo "DELETE FROM db"                                                                 | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "DELETE FROM user WHERE User = ''"                                               | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "DELETE FROM user WHERE (Host != '127.0.0.1') AND (Host != 'localhost')"         | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "UPDATE user SET Password='<%= mysql_root_password_hash %>' WHERE Password = ''" | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    $PDESTDIR/bin/mysql_upgrade &&

    ### Restart with permission system enabled
    /bin/bash /etc/rc.d/rc.mysqld restart
fi
