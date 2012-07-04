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
export PVERSION_MK_LIVESTATUS="<%= softwareVersion %>" &&
export PDESTDIR_MK_LIVESTATUS="<%= destDir %>" &&
export PDESTDIR_NAGIOS="<%= destDir_nagios %>" &&



### Download and install
# CheckURI: http://mathias-kettner.de/check_mk_download.html
cd $SRCROOT && . ../_functions.sh &&
export PNAME="mk-livestatus" &&
export PVERSION="$PVERSION_MK_LIVESTATUS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://mathias-kettner.de/download/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR_MK_LIVESTATUS &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
