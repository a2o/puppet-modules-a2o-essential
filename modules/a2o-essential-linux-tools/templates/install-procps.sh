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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### ProcPs
# CheckURI: http://procps.sourceforge.net/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="procps" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://procps.sourceforge.net/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Patch to build on Slack64 14.0
wget http://source.a2o.si/patches/procps-3.2.8-makefile.diff &&
patch -p1 < procps-3.2.8-makefile.diff &&

make &&
if [ -f /etc/slackware-version ]; then
    if [ -f /var/log/packages/procps-* ]; then
	removepkg procps
    fi
fi &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
