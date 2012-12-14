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
export PVERSION_NRPE="<%= softwareVersion %>" &&
export PDESTDIR_NRPE="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Download and install
# CheckURI: http://www.nagios.org/download/core/thanks/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="nrpe" &&
export PVERSION="$PVERSION_NRPE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.sourceforge.net/sourceforge/nagios/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# SuSE creates invalid -I argument (adds trailing openssl/), let's mitigate that
export CFLAGS="-I$PDESTDIR_OPENSSL/include" &&

./configure --prefix=$PDESTDIR_NRPE --sysconfdir=/etc/nagios --localstatedir=/var/nagios \
  --enable-ssl \
  --with-ssl-inc=$PDESTDIR_OPENSSL/include \
  --with-ssl-lib=$PDESTDIR_OPENSSL/lib \
  --enable-command-args &&

make all &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
