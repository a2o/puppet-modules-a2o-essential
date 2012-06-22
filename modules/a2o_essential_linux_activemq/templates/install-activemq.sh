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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_ACTIVEMQ="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### ActiveMQ
# CheckURI: http://www.openssh.com/
# Requires: openssl, zlib
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="apache-activemq" &&
export PVERSION="$PVERSION_ACTIVEMQ" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR-bin.tar.gz" &&
export PURI="http://apache.osuosl.org/activemq/apache-activemq/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

rm -rf $PDESTDIR &&
mv $PDIR $PDESTDIR &&

cd $PDESTDIR &&
chown -R root.root . &&

# Create conf and datadir symlinks, store original folders
mv conf conf.dist &&
mv data data.dist &&

ln -s /etc/activemq ./conf &&
ln -s /var/activemq ./data &&



### Signal successful exit
true
