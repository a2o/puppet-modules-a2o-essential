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
export PVERSION_LIBMILTER="<%= packageSoftwareVersion %>" &&



### Libmilter
# CheckURI: http://www.sendmail.com/sm/open_source/download/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="sendmail" &&
export PVERSION="$PVERSION_LIBMILTER" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PNAME.$PVERSION.tar.gz" &&
export PURI="ftp://ftp.sendmail.org/pub/sendmail/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&

# Don't treat warnings as errors
cd libmilter &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
