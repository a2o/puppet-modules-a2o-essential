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
export PVERSION_SW="<%= softwareVersion %>" &&
export PVERSION_DBDEPLOY="<%= softwareVersion_dbDeploy %>" &&
export PVERSION_MYCONNJ="<%= softwareVersion_myConnJ %>" &&
export PDESTDIR="<%= destDir %>" &&



### Apache Ant
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="apache-ant" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR-bin.tar.gz" &&
export PURI="http://www.apache.si/ant/binaries/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR &&



### DBdeploy
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="dbdeploy" &&
export PVERSION="$PVERSION_DBDEPLOY" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PNAME-dist-$PVERSION-distribution.zip" &&
export PURI="http://dbdeploy.googlecode.com/files/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

# Install
mv $PDIR/dbdeploy-*.jar $PDESTDIR/lib &&

# Cleanup
rm -rf $PDIR &&



### MySQL Connector Java
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="mysql-connector-java" &&
export PVERSION="$PVERSION_MYCONNJ" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.arnes.si/mysql/Downloads/Connector-J/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

# Install
mv $PDIR/$PNAME-*.jar $PDESTDIR/lib &&

# Cleanup
rm -rf $PDIR &&



exit 0
