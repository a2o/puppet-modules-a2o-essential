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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_NET_SNMP="<%= packageSoftwareVersion %>" &&



### net-snmp
# CheckURI: http://www.net-snmp.org/download.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="net-snmp" &&
export PVERSION="$PVERSION_NET_SNMP" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://surfnet.dl.sourceforge.net/sourceforge/net-snmp/5.7/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure \
  --with-default-snmp-version=3 \
  --with-sys-contact="root@`hostname -f`" \
  --with-sys-location="unknown" \
  --with-logfile="/var/log/snmpd.log" \
  --with-persistent-directory="/var/net-snmp" &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
