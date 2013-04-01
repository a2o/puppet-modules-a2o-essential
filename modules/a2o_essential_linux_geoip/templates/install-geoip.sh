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
export PVERSION_SW="<%= softwareVersion %>" &&



### GeoIP
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="GeoIP" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.maxmind.com/download/geoip/api/c/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

libtoolize -f &&
./configure \
  --sysconfdir=/etc \
  --datarootdir=/var/geoip \
  --datadir=/var/geoip \
  --infodir=/usr/local/share \
  --localedir=/usr/local/share \
  --mandir=/usr/local/share \
  --docdir=/usr/local/share/doc/GeoIP &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
