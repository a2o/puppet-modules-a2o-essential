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
export PVERSION_NAGIOS="<%= softwareVersion %>" &&
export PDESTDIR_NAGIOS="<%= destDir %>" &&
export PDESTDIR_PERL="<%= externalPackageDestDir_perl %>" &&



### Download and install
# CheckURI: http://www.nagios.org/download/core/thanks/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="nagios" &&
export PVERSION="$PVERSION_NAGIOS" &&
export PDIR="$PNAME" &&
export PFILE="$PDIR-$PVERSION.tar.gz" &&
export PURI="http://garr.dl.sourceforge.net/sourceforge/nagios/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

wget http://source.a2o.si/patches/nagios-3.3.1-html-fix.diff &&
cat nagios-3.3.1-html-fix.diff | patch -p0 &&

./configure --prefix=$PDESTDIR_NAGIOS --sysconfdir=/etc/nagios --localstatedir=/var/nagios \
  --enable-embedded-perl \
  --with-checkresult-dir=/var/nagios/checkresults \
  --with-lockfile=/var/nagios/run/nagios.lock \
  --with-perlcache &&

make all &&
make install &&
make install-commandmode &&

cd $SRCROOT &&
rm -rf $PDIR
