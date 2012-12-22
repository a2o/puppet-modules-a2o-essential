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



### Mlocate
# CheckURI: https://fedorahosted.org/mlocate/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="mlocate" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.xz" &&
export PURI="https://fedorahosted.org/releases/m/l/mlocate/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --sysconfdir=/etc --localstatedir=/var/lib
make &&
make install &&

# FIXME remove at some point
rm -f /usr/local/bin/slocate &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
