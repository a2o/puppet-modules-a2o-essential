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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### IpTables
# CheckURI: http://www.netfilter.org/projects/iptables/downloads.html
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="iptables" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PNAME-$PVERSION.tar.bz2" &&
export PURI="http://www.netfilter.org/projects/iptables/files/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
./configure --bindir=/bin --sbindir=/sbin &&
make &&
make install &&

# FIXME how about we remove slackware package?
rm -f /usr/local/bin/iptables-xml &&
rm -f /usr/local/sbin/iptables &&
rm -f /usr/local/sbin/iptables-multi &&
rm -f /usr/local/sbin/iptables-restore &&
rm -f /usr/local/sbin/iptables-save &&
rm -f /usr/local/sbin/ip6tables &&
rm -f /usr/local/sbin/ip6tables-multi &&
rm -f /usr/local/sbin/ip6tables-restore &&
rm -f /usr/local/sbin/ip6tables-save &&
cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
