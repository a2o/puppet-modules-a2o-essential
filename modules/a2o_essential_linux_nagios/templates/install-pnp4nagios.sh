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
export PVERSION_PNP4NAGIOS="<%= packageSoftwareVersion %>" &&
export PDESTDIR_PNP4NAGIOS="<%= destDir %>" &&
export PDESTDIR_PERLLIB="<%= externalDestDir_perllib %>" &&
export PDESTDIR_NAGIOS="<%= destDir_nagios %>" &&



### Download and install
# CheckURI: http://sourceforge.net/projects/pnp4nagios/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="pnp4nagios" &&
export PVERSION="$PVERSION_PNP4NAGIOS" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://downloads.sourceforge.net/sourceforge/pnp4nagios/PNP-0.6/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR_PNP4NAGIOS --sysconfdir=/etc/nagios/pnp4nagios \
  --with-perfdata-logfile=$PDESTDIR_PNP4NAGIOS/bin \
  --with-perfdata-dir=/var/nagios/rrd \
  --with-perfdata-spool-dir=/var/nagios/spool \
  --with-perl_lib_path=$PDESTDIR_PERLLIB &&

make all &&
make install &&
make install-processperfdata &&
make install-html &&

# Install SSI for nagios integration
mkdir -p $PDESTDIR_NAGIOS/share/ssi &&
cp contrib/ssi/status-header.ssi $PDESTDIR_NAGIOS/share/ssi/ &&

# (Re)move install.php file
mv $PDESTDIR_PNP4NAGIOS/share/install.php $PDESTDIR_PNP4NAGIOS/share/install.php.disabled &&

cd $SRCROOT &&
rm -rf $PDIR
