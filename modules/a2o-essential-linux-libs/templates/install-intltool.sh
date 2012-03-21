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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_INTLTOOL="<%= packageSoftwareVersion %>" &&
export PVERSION_XMLPARSER="<%= packageSoftwareVersion_xmlparser %>" &&



### Perl XML::Parser
# CheckURI: http://www.cpan.org/modules/01modules.index.html
# ReqBy: intltool
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="XML-Parser" &&
export PVERSION="$PVERSION_XMLPARSER" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/M/MS/MSERGEANT/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' &&

perl Makefile.PL &&
make &&
make install &&

unset PKG_CONFIG_PATH &&

cd $SRCROOT &&
rm -rf $PDIR &&



### intltool
# CheckURI: http://ftp.gnome.org/pub/gnome/sources/intltool/
# Req: Perl XML::Parser module
cd $SRCROOT && . ../_functions.sh &&
export PNAME="intltool" &&
export PVERSION="$PVERSION_INTLTOOL" &&
export PVERSION_MAJOR=`echo $PVERSION | cut -d. -f1,2` &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://ftp.gnome.org/pub/gnome/sources/intltool/$PVERSION_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure &&
make -j 2 &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
