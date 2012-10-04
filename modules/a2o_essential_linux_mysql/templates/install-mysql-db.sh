#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
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
    $PDESTDIR/bin/mysql_install_db --basedir=$PDESTDIR --datadir=/var/mysql/data &&

    /etc/rc.d/rc.mysqld start &&

    echo "DELETE FROM db"                                                                 | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "DELETE FROM user WHERE User = ''"                                               | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "DELETE FROM user WHERE (Host != '127.0.0.1') AND (Host != 'localhost')"         | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&
    echo "UPDATE user SET Password='<%= mysql_root_password_hash %>' WHERE Password = ''" | $PDESTDIR/bin/mysql --user=root --password= --database=mysql &&

    $PDESTDIR/bin/mysql_fix_privilege_tables
fi
